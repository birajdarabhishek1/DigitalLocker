package com.email;

import java.io.IOException;
import java.sql.*;
import javax.print.*;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * A servlet that takes message details from user and send it as a new e-mail
 * through an SMTP server.
 * 
 * @author www.codejava.net
 * 
 */
@WebServlet("/EmailSendingServlet")
public class EmailSendingServlet extends HttpServlet {
	private String host;
	private String port;
	private String user;
	private String pass;

	public void init() {
		// reads SMTP server setting from web.xml file
		ServletContext context = getServletContext();
		host = context.getInitParameter("host");
		System.out.println(host);
		port = context.getInitParameter("port");
		System.out.println(port);
		user = context.getInitParameter("user");
		System.out.println(user);
		pass = context.getInitParameter("pass");
		System.out.println(pass);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// reads form fields

		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		Statement st1 = null;
		String key = null;
		String document_name = request.getParameter("dname");
		String email = request.getParameter("email");
		String toUser=request.getParameter("toUser");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/digilocker";
			con = DriverManager.getConnection(url, "root", "root");
			st = con.createStatement();
			st1=con.createStatement();
			rs = st.executeQuery("select distinct d.privatekey from documents d join access a on(d.upload_by=a.touser) where d.filename ='"+ document_name + "' and a.touser='" + toUser + "'");
			int i=st1.executeUpdate("update access set status='Approve' where toUser='"+toUser+"' and fillename='"+document_name+"'");
			if (rs.next()) {
				key = rs.getString(1);
				System.out.print(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		String fileName = document_name;
		// String content = request.getParameter("content");

		String resultMessage = "";

		PrintWriter out = response.getWriter();

		try {

			EmailUtility.sendEmail(host, port, "filekeycosteffective@gmail.com", "gaurav123$", email, fileName, key);
			resultMessage = "The File Key Successfully sent in your e-mail,Please check it!!!";
		} catch (Exception ex) {
			ex.printStackTrace();
			resultMessage = "There were an error: " + ex.getMessage();
		} finally {
			request.setAttribute("Message", resultMessage);
			getServletContext().getRequestDispatcher("/Result.jsp").forward(request, response);
		}
	}
}