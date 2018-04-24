package com.filesharing;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.MyConnection;

/**
 * Servlet implementation class RevokeServlet
 */
@WebServlet("/RevokeServlet")
public class RevokeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RevokeServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String FileName = (String) session.getAttribute("FileName");
		String[] Checkbox = request.getParameterValues("Checkbox");
		String Checked[] = Checkbox;
		int i = 0;
		try {
			FileUploadDBServlet dbServlet = new FileUploadDBServlet();
			String PriKey = dbServlet.keyData();
			Connection con =MyConnection.getConnection();
			Statement st = con.createStatement();
			for (String s : Checkbox) {
				Checked[i] = s;
				System.out.println("CheckBox Values" + s);
				i++;
				st.executeUpdate("delete from access where fromuser='" + s + "'");
			}
			String quer = "select * from access where fillename='" + FileName + "'";
			Statement st1 = con.createStatement();
			ResultSet rs = st1.executeQuery(quer);
			String EmailId = "";
			while (rs.next()) {
				Statement st2 = con.createStatement();
				ResultSet rs2 = st2.executeQuery("select * from user_details where uname='" + rs.getString("fromuser") + "'");
				if (rs2.next()) {
					EmailId = rs2.getString("user_email");
				}
				SendMail.mailSend(FileName, PriKey, EmailId);
			}
			st.executeUpdate("update documents set privateKey='" + PriKey + "' where filename='" + FileName + "'");
			response.sendRedirect("RevokeAccess.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
