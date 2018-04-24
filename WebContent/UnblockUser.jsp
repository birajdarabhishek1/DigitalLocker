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
			
				<table border="1" cellspacing="1" cellpadding="1">
					<tr bgcolor="#428bca" style="height: 40px;">
						<td><font color="white">User Name</font></td>
						<td><font color="white">Action</font></td>
					</tr>
					<tr>
						<%
						
							ResultSet rs = MyConnection.getResultFromSqlQuery("Select * from blockuser where times=5");
							while (rs.next()) {%>
							<form action="unblockUser" method="post">
										<tr>
											<td><input type="text" name="blockuser" value="<%=rs.getString(1)%>" style="width:100px;height:20px;border-radius: 8px;""></td>
											<td><input type="submit" value="Unblock User" style="height: 23px; color: white; background-color: #428bca; border-radius: 8px;"></td>
										</tr>
							</form>
										<%}%>
							
					</tr>
				</table>
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




