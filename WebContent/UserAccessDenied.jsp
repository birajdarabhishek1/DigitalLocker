<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"
	dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
</head>
<body id="top">
	<div class="wrapper col1" style="background-color:white;height:180px;">
	<img src="images/DigiIcon.png"></img>
		<div id="header">
			<div id="logo">
				<p>
					<strong></strong>
				</p>
			</div>

			<br class="clear" />
		</div>
	</div>
	<div class="wrapper col2" style="left-margin: 10px;">
		<div id="topbar" style="width: 1300px; left-margin: 10px;">
			<div id="topnav" style="width: 1200px; left-margin: 15px;">
				<ul>
					<li><a href="documentsApproval.jsp">Documents Approval</a></li>
					<li><a href="pieChart.jsp">Analysis</a></li>
					<li><a href="UnblockUser.jsp">Unblock User</a></li>
					<li><a href="BlockUser.jsp">Block User</a></li>
					<li><a href="UserAccessDenied.jsp">User Access Denied</a></li>
					<li><a href="Logout.jsp"><font color="yellow">Logout</font></a></li>
				</ul>
			</div>
			<br class="clear" />
		</div>
	</div>
	<div class="wrapper col5">
		<div id="container">
			<div id="content">
			
				<h2>
				<font color="#0099FF">All User List</font>
			</h2>
			<fieldset style="width: 900px; border-radius: 15px;">
				<table style="border-radius: 15px;" border="1">
					<tr bgcolor="#428bca" style="height: 45px; border-radius: 8px;">
						<td><strong><font color="white">Delete</font></strong></td>
						<td><strong><font color="white">Id</font></strong></td>
						<td><strong><font color="white">User Name</font></strong></td>
						<td><strong><font color="white">Address</font></strong></td>
						<td><strong><font color="white">Mobile</font></strong></td>
						<td><strong><font color="white">Email</font></strong></td>
						<td><strong><font color="white">Designation</font></strong></td>
						<td><strong><font color="white">User Name</font></strong></td>
						<td><strong><font color="white">Password</font></strong></td>
						
					</tr>
					<%
						try {
								Connection con = MyConnection.getConnection();
								Statement st = con.createStatement();
								ResultSet rs = st.executeQuery("select * from user_details");
								while (rs.next()) {
					%>
					<form action="DeniedPerticularUserProfile.jsp" method="post">
						<%
							if (rs.getInt(1) % 2 == 0) {
						%>
						<tr bgcolor="#F0F0F0">
							<td><input type="image" src="images/delete.png" alt="submit"
								style="height: 25px;"></td>
							<td><input type="text" name="id" value="<%=rs.getInt(1)%>"
								style="width: 20px; border: hidden; background-color: #F0F0F0;"
								readonly></td>
							<td><%=rs.getString(2)%></td>
							<td><%=rs.getString(3)%></td>
							<td><%=rs.getString(4)%></td>
							<td><%=rs.getString(5)%></td>
							<td><%=rs.getString(6)%></td>
							<td><%=rs.getString(8)%></td>
							<td><%=rs.getString(9)%></td>
							
						</tr>
						<%
							} else {
						%>

						<tr bgcolor="white">
							<td><input type="image" src="images/delete.png" alt="submit"
								style="height: 25px;"></td>
							<td><input type="text" name="id" value="<%=rs.getInt(1)%>"
								style="width: 20px; border: hidden;" readonly></td>
							<td><%=rs.getString(2)%></td>
							<td><%=rs.getString(3)%></td>
							<td><%=rs.getString(4)%></td>
							<td><%=rs.getString(5)%></td>
							<td><%=rs.getString(6)%></td>
							<td><%=rs.getString(8)%></td>
							<td><%=rs.getString(9)%></td>
							
						</tr>
					</form>
					<%
						}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
					%>

				</table>
			</fieldset>

			</div>

			<div id="column">
				<div class="holder">
					<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
				</div>
			</div>
			<br class="clear" />
		</div>
		<div class="wrapper col7">
			<div id="copyright">
				<p class="fl_left">Copyright &copy; 2016 - All Rights Reserved.
				</p>
				<br class="clear" />
			</div>
		</div>
		
</body>
</html>
