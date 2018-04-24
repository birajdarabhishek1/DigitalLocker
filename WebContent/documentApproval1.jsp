<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.MyConnection"%>
<%
	String confirm = request.getParameter("confirm");
	System.out.print(confirm);
	String fileName=request.getParameter("fileName");
	System.out.print(fileName);
	String uname=request.getParameter("uname");
	System.out.println(uname);
	Connection con = MyConnection.getConnection();
	Statement st = con.createStatement();
	int i = st.executeUpdate("update documents set status='confirm' where FileName='"+fileName+"' and upload_by='"+uname+"'");
	if (i > 0) {
		response.sendRedirect("documentsApproval.jsp");
	} else {
		response.sendRedirect("documentsApproval.jsp");
	}
%>