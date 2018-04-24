<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.DBConnection"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<center>
		<fieldset style="width: 400px; background-color: white;">
			<table>
				<%!String id;
				   String password;%>
				<%
					String question = request.getParameter("question");
					String answer = request.getParameter("answer");
					Connection con = null;
					Statement st = null;
					ResultSet rs = null;

					try {
						con = DBConnection.getConn();
						st = con.createStatement();
						rs = st.executeQuery("select uname,password from user_details where security_question='" + question+ "' and answer='" + answer + "'");
						if(rs.next()) {
							id = rs.getString(1);
							password = rs.getString(2);
						}

					} catch (Exception e) {
						e.printStackTrace();
					}
				%>
				<tr>
					<td width="28%" rowspan="4"><img
						src="images/UserName&Password.jpg" width="180" height="130" /></td>
				</tr>
				<tr>
					<td><strong>Your User Id:</strong><font color="blue"><%=id%></font></td>
				</tr>
				<tr>
					<td><strong>Password:</strong><font color="blue"><%=password%></font></td>
				</tr>
				<tr>
					<td><a href="index.jsp">Please Login</a></td>
				</tr>
			</table>
		</fieldset>
	</center>
</body>
</html>