<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.MyConnection"%>
<%
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		System.out.println(id);
		Connection con = MyConnection.getConnection();
		Statement st = con.createStatement();
		int i = st.executeUpdate("delete from user_details where userid='" + id + "'");
		if (i > 0) {
			response.sendRedirect("UserAccessDenied.jsp");
		} else {
			response.sendRedirect("UserAccessDenied.jsp");
		}

	} catch (Exception e) {
		e.printStackTrace();
	}
%>