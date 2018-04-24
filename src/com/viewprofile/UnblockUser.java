package com.viewprofile;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import com.connection.MyConnection;
import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class UnblockUser
 */

public class UnblockUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UnblockUser() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String blockuser = request.getParameter("blockuser");
		try {
			Connection con = (Connection) MyConnection.getConnection();
			Statement st = con.createStatement();
			int i = st.executeUpdate("delete from blockuser where user='" + blockuser + "'");
			if (i > 0) {
				response.sendRedirect("UnblockUserSuccessfully.jsp");
			} else {
				response.sendRedirect("UnblockUser.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
