import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AddPhotoServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		try {
			// Apache Commons-Fileupload library classes
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload sfu = new ServletFileUpload(factory);

			if (!ServletFileUpload.isMultipartContent(request)) {
				System.out.println("sorry. No file uploaded");
				return;
			}

			// parse request
			List items = sfu.parseRequest(request);
			int id = 0;

			FileItem ename = (FileItem) items.get(0);
			String empname = ename.getString();

			FileItem eaddress = (FileItem) items.get(1);
			String empaddress = eaddress.getString();

			FileItem emobile = (FileItem) items.get(2);
			String empmobile = emobile.getString();

			FileItem eemail = (FileItem) items.get(3);
			String empemail = eemail.getString();

			FileItem edesignation = (FileItem) items.get(4);
			String empdesignation = edesignation.getString();

			// get uploaded file
			FileItem file = (FileItem) items.get(5);
			
			FileItem uname = (FileItem) items.get(6);
			String username = uname.getString();
			
			FileItem pass = (FileItem) items.get(7);
			String password = pass.getString();
			
			FileItem question = (FileItem) items.get(8);
			String userquestion = question.getString();
			
			FileItem answer = (FileItem) items.get(9);
			String useranswer = answer.getString();

			// Connect to Mysql Database
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/digilocker", "root", "root");
			con.setAutoCommit(false);
			PreparedStatement ps = con.prepareStatement("insert into user_details values(?,?,?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, id);
			ps.setString(2, empname);
			ps.setString(3, empaddress);
			ps.setString(4, empmobile);
			ps.setString(5, empemail);
			ps.setString(6, empdesignation);
			// size must be converted to int otherwise it results in error
			ps.setBinaryStream(7, file.getInputStream(), (int) file.getSize());
			ps.setString(8, username);
			ps.setString(9, password);
			ps.setString(10,userquestion);
			ps.setString(11,useranswer);
			ps.executeUpdate();
			con.commit();
			con.close();
			response.sendRedirect("UserRegisrationSuccessfully.jsp");
			// out.println("Photo Added Successfully.");
		} catch (Exception ex) {
			out.println("Error --> " + ex.getMessage());
		}
	}
}