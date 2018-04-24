<%@page import="com.filesharing.AESencrp"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.filesharing.FileUploadDBServlet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import=" java.io.IOException"%>
<%@page import=" java.io.PrintWriter"%>
<%@page import=" java.sql.Connection"%>
<%@page import=" java.sql.DriverManager"%>
<%@page import=" java.sql.PreparedStatement"%>
<%@page import=" java.util.List"%>
<%@page import=" javax.servlet.ServletException"%>
<%@page import=" javax.servlet.http.HttpServlet"%>
<%@page import=" javax.servlet.http.HttpServletRequest"%>
<%@page import=" javax.servlet.http.HttpServletResponse"%>
<%@page import=" org.apache.commons.fileupload.FileItem"%>
<%@page import=" org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import=" org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.util.Random"%>

<%
	try {
		// Apache Commons-Fileupload library classes
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload sfu = new ServletFileUpload(factory);

		if (!ServletFileUpload.isMultipartContent(request)) {
			System.out.println("sorry. No file uploaded");
			return;
		}

		StringBuilder ss = new StringBuilder();
		Random r = new Random();
		char ch;
		for (int i = 0; i < 5; i++) {
			ch = (char) (Math.floor(26 * r.nextDouble() + 65));
			ss.append(ch);

		}
		String DataForEncryption = "";
		// parse request

		List items = sfu.parseRequest(request);
		FileItem file = (FileItem) items.get(0);

		String fileExtesion = "";
		fileExtesion = file.getName().substring(file.getName().lastIndexOf("."));
		DataForEncryption = file.getName();

		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
		if (fileExtesion.equalsIgnoreCase("docx") || fileExtesion.equalsIgnoreCase(".txt")) {
			String line;
			br = new BufferedReader(new InputStreamReader(file.getInputStream()));
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}

		}
		if (!sb.toString().equals("")) {
			DataForEncryption = sb.toString();
		}

		AESencrp aesAlgo = new AESencrp();
		String EncryptedData = aesAlgo.encrypt(DataForEncryption);

		System.out.println("--Encrypted Data-- " + EncryptedData);
		System.out.println("--Decrypted Data-- " + aesAlgo.decrypt(EncryptedData));

		FileItem description = (FileItem) items.get(1);
		String description1 = description.getString();
		System.out.println(description1);

		FileItem issuing_Authority = (FileItem) items.get(2);
		String issuing_Authority1 = issuing_Authority.getString();
		System.out.println(issuing_Authority1);

		// get uploaded file

		// Connect to Mysql Database
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/digilocker", "root", "root");
		String uname = request.getParameter("uname");
		PreparedStatement ps1 = con.prepareStatement("select filename from documents where filename=?");
		ps1.setString(1, file.getName());
		ResultSet rs = ps1.executeQuery();
		if (!rs.next()) {
			con.setAutoCommit(false);
			PreparedStatement ps = con.prepareStatement("insert into documents(filename, type,content,data_of_file,upload_by,privateKey,status,description,issuing_authority)values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, file.getName());
			ps.setString(2, fileExtesion);
			ps.setBinaryStream(3, file.getInputStream(), (int) file.getSize());
			ps.setString(4, EncryptedData);
			ps.setString(5, (String) session.getAttribute("uid"));
			ps.setString(6, ss.toString());
			ps.setString(7, "Not Confirm");
			// size must be converted to int otherwise it results in error
			ps.setString(8, description1);
			ps.setString(9, issuing_Authority1);

			ps.executeUpdate();
			con.commit();
			con.close();
			response.sendRedirect("DocumentsUploadingAndDownloading.jsp");
		} else {
			//out.println("File name is already in use,please upload different file!!!");
			response.sendRedirect("FileAlreadyExist.jsp");
		}
		// out.println("Photo Added Successfully.");
	} catch (Exception ex) {
		out.println("Error --> " + ex.getMessage());
	}
%>