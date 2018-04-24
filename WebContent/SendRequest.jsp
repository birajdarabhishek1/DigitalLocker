<%@page import="java.sql.Statement"%>
<%@page import="com.connection.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		String Approve = "Approve";
		String upload_by = request.getParameter("upload_by_Filename");
		String[] Upload_by_Filename = upload_by.split("-");
		Connection conn = MyConnection.getConnection();
		Statement st = conn.createStatement();
		Statement st1 = conn.createStatement();
		ResultSet rs = st1.executeQuery("select status from access where fillename='" + Upload_by_Filename[1]+ "' and fromuser='" + session.getAttribute("uid") + "'");
		if (rs.next()) {
			String status = rs.getString(1);
			//System.out.print(status);
			if (status.equals("Approve")) {
				response.sendRedirect("FileAlreadyShared.jsp");
			}
		} else {
			st.executeUpdate("insert into access values('" + session.getAttribute("uid") + "','"
					+ Upload_by_Filename[1] + "','" + Upload_by_Filename[0] + "','Pending','"
					+ session.getAttribute("email") + "')");
			response.sendRedirect("MyRequester.jsp");
			
		}
		
		
	%>

</body>
</html>