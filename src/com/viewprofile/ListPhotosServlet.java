package com.viewprofile;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.connection.MyConnection;

public class ListPhotosServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		System.out.println(id);
		try {
			Connection con=MyConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("select userid,username,user_address,user_mobile,user_email,user_designation from user_details where uname='" + id + "'");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				out.print("<br><br><br><br><br><br>");
				out.print("<center>");
				out.print("<fieldset style='width:300px;background-color:#F8F8F8 ;'>");
				out.print("<table>");
				out.print("<tr>");
				out.print("<center>");
				out.print("<h2><font color='blue'>User Profile</font></h2>");
				out.print("</center>");
				out.print("</tr>");
				out.print("<br>");
				out.print("<tr>");
				out.print("<img width='100' height='100' border='1' src=displayphoto?id=" + request.getParameter("id")+"></img> <p/>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>User Id : </strong> </td>");
				out.print("<td>");
				out.println(rs.getInt(1));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>User Name : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString(2));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Address : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString(3));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Mobile : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString(4));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Email : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString(5));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Occupation : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString(6));
				out.print("</td>");
				out.print("</tr>");
				out.print("</table>");
				out.print("</fieldset>");
				out.print("<br>");
				out.print("<a href='ViewProfile.jsp'>Back</a>");
				out.print("</table>");
				out.print("</center>");
			} else {
				out.print("<br><br><br><br><br><br>");
				out.print("<center>");
				out.print("<fieldset style='width:300px;background-color:#F8F8F8 ;'>");
				out.print("<table>");
				out.print("User Record Not Found");
				out.print("<br>");
				out.print("<a href='ViewProfile.jsp'>Click Here</a>");
				out.print("</table>");
				out.print("</fieldset>");
				out.print("</center>");
			}
		} catch (Exception ex) {

		} finally {
			out.close();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}