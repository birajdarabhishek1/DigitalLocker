package com.viewprofile;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.connection.MyConnection;
import com.mysql.jdbc.Connection;

/**
 * Servlet implementation class BlockUser
 */

public class BlockUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BlockUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String blockuser = request.getParameter("blockuser");
		int times=5;
		try {
			Connection con = (Connection) MyConnection.getConnection();
			Statement st = con.createStatement();
			int i = st.executeUpdate("insert into blockuser(user,times) values('"+blockuser+"','"+times+"')");
			if (i > 0) {
				response.sendRedirect("BlockUserSuccessfully.jsp");
			} else {
				response.sendRedirect("BlockUser.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
