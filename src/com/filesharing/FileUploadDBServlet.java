package com.filesharing;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import java.util.logging.Logger;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.swing.text.Document;

@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)
public class FileUploadDBServlet extends HttpServlet {
	public String private_key, pkey;
	public Boolean repeat;
	public int row = 0;
	public String PriKey;
	private static Logger logger = Logger.getAnonymousLogger();

	BigInteger g = null;

	BigInteger b = null;
	BigInteger a = null;
	BigInteger[] rtn1 = { null, null };
	BigInteger p = null;

	/*
	 * private String dbURL1 = "jdbc:mysql://localhost:3306/cloud1"; private
	 * String dbUser1 = "root"; private String dbPass1 = "admin";
	 */
	public String keyData() {
		StringBuilder ss = new StringBuilder();
		Random r = new Random();
		char ch;

		for (int i = 0; i < 5; i++) {
			ch = (char) (Math.floor(26 * r.nextDouble() + 65));
			ss.append(ch);

		}

		return ss.toString();

	}

	protected void doPost(HttpServletRequest request,

	HttpServletResponse response) throws ServletException, IOException {

		PriKey = keyData();
		pkey = PriKey;

		HttpSession session = request.getSession(false);
		String nam = (String) session.getAttribute("unam");
		InputStream inputStream = null;
		Part filePart = request.getPart("file1");

		String fileName = getFileName(filePart);
		session.setAttribute("FILEName", fileName);

		if (filePart != null) {
			System.out.println(filePart.getName());
			System.out.println(filePart.getSize());
			System.out.println(filePart.getContentType());
			System.out.print("-----" + fileName);
			System.out.println("" + nam);

			inputStream = filePart.getInputStream();

		}

		Connection conn = null;
		String message = null;
		try {
			conn = Dbconn.conn();
			Statement stavailable = conn.createStatement();
			ResultSet rsavailable = stavailable
					.executeQuery("select * from Data where filename='"
							+ fileName + "'");
			if (rsavailable.next()) {
				PrintWriter out1 = null;
				response.setContentType("text/html;charset=UTF-8");
				out1 = response.getWriter();
				out1.println("<html><script>alert('File Already Exists');</script><body>");
				out1.println("");
				out1.println("</body></html>");
				RequestDispatcher rd = request
						.getRequestDispatcher("/mainPage.jsp");
				rd.include(request, response);
				// response.sendRedirect("Homepage.jsp");
			} else {

				Boolean upload = false;
				if (filePart != null) {
					System.out.println(filePart.getName());
					System.out.println(filePart.getSize());
					System.out.println(filePart.getContentType());
					if (filePart.getContentType().startsWith("image/")
							|| filePart.getContentType().startsWith("audio/")
							|| filePart.getContentType().startsWith("video/")
							|| filePart.getContentType().startsWith(
									"application/")) {

						try {
							System.out.println("----------Image Uploaded");

							inputStream = filePart.getInputStream();
							conn = Dbconn.conn();
							// insert into Data values('" + nam + "' , '"
							// +EncryptFile + "'  ,'" +fileName + "'  ,'"
							// +PriKey + "' ,'0'  )"
							

							String sql = "INSERT INTO Data values (?, ?, ?,?,?,?,?)";
							PreparedStatement statement = conn
									.prepareStatement(sql);
							statement.setString(1, nam);

							if (inputStream != null) {
								// fetches input stream of the upload file for
								// the blob column
								statement.setBlob(2, inputStream);
							}
							statement.setString(3, "second part");
							statement.setString(4, fileName);
							statement.setString(5, PriKey);
							statement.setString(6, "a");
							statement.setString(7, "p");

							// sends the statement to the database server
							int row = statement.executeUpdate();
							if (row > 0) {
								message = "File uploaded and saved into database";
								response.sendRedirect("FileUploadSuccessfully.jsp");
							}
							

						} catch (Exception e) {
							e.printStackTrace();
						}
						// getServletContext().getRequestDispatcher("/Homepage.jsp").forward(request,
						// response);
					} else {
						upload = true;
					}

					System.out.print("-----" + fileName);
					System.out.println("" + nam);

					inputStream = filePart.getInputStream();

				}

				if (upload) {

					String strOriginal = "";
					String strPart1 = null, strPart2 = null;
					if (inputStream != null) {
						strOriginal = getStringFromInputStream(inputStream);
						session.setAttribute("OG", strOriginal);

						System.out.println(" Origional String is "
								+ strOriginal);

						ElGamal eg = new ElGamal();

						String signm = strOriginal;

						rtn1 = eg.getRandomP(new BigInteger(signm.getBytes())
								.bitLength());

						p = rtn1[0];
						g = rtn1[1];
						a = eg.getRandoma(p);
						b = eg.calculateb(g, a, p);

						System.out.println("Input Data is:" + signm);
						byte[] mb = signm.getBytes();

						System.out.println("Encrypted key is" + p);
						// System.out.println(p+""+b+""+g);

						BigInteger[] EncryptedData = eg.encryptSignature(
								strOriginal, p, b, g);
						System.out.println("Dec text is =-------------- "
								+ EncryptedData[0]);
						System.out.println("Dec text is =-------------- "
								+ EncryptedData[1]);
						String dec = eg.decryptSignature(EncryptedData[0],
								EncryptedData[1], a, p);
						System.out
								.println("Dec text is =-------------- " + dec);
						System.out.println("Sucess Encrypted");

						Statement st = conn.createStatement();
						int i=st.executeUpdate("insert into Data values('" + nam+ "' , '" + EncryptedData[0] + "'  , '"+ EncryptedData[1] + "'  ,'" + fileName+ "'  ,'" + PriKey + "'  ,'" + a + "' ,'" + p+ "' )");
						if(i>0)
						{
							response.sendRedirect("FileUploadSuccessfully.jsp");
						}
						
					}
				}
			}
		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			if (conn != null) {

				try {
					conn.close();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			

			// getServletContext().getRequestDispatcher("/Homepage.jsp").forward(request,
			// response);
		}
		RequestDispatcher rd = request.getRequestDispatcher("/mainPage.jsp");
		rd.include(request, response);
	}

	String getFileName(Part filePart) {

		String partHeader = filePart.getHeader("content-disposition");
		logger.info("Part Header = " + partHeader);

		for (String cd : filePart.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim()
						.replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1)
						.substring(fileName.lastIndexOf('\\') + 1);
				// return cd.substring(cd.indexOf('=') + 1).trim().replace("\"",
				// "") ;
			}

		}

		return null;

	}

	private String getStringFromInputStream(InputStream is) {

		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();

		String line;
		try {

			br = new BufferedReader(new InputStreamReader(is));
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return sb.toString();

	}

}
