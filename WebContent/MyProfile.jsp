<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.connection.DBConnection"%>
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
	<div class="wrapper col2">
		<div id="topbar" style="width:1300px;left-margin:10px;">
			<div id="topnav" style="width:1400px;left-margin:15px;">
				<ul>
					<li><a href="MyProfile.jsp">My Profile</a></li>
					<li><a href="EditProfile.jsp">Edit Profile</a></li>
					<li><a href="DocumentsUploadingAndDownloading.jsp">My Certificate</a></li>
					<li><a href="MyIssuer.jsp">Notification</a></li>
					<li><a href="ViewProfile.jsp">View Profile</a></li>
					<li><a href="MyRequester.jsp">My Requester</a></li>
					<li><a href="RevokeAccess.jsp">Revoke Access</a></li>
					<li><a href="Resources.jsp">Resources</a></li>
					<li><a href="ContactUs.jsp">Contact</a></li>
					<li><a href="">Welcome&nbsp;<strong><font color="yellow"><%out.print((String) session.getAttribute("uid"));%></font></strong></a></li>
					<li><a href="Logout.jsp"><font color="yellow">Logout</font></a></li>
				</ul>
			</div>
			<br class="clear" />
		</div>
	</div>
	<%
		if (session.getAttribute("uid") != null && session.getAttribute("uid") != "") {
	%>
	<div class="wrapper col5">
		<div id="container">
			<div id="content">
				<form action="" method="post">
					<fieldset style="width: 550px;">
						<table bgcolor="white ">
							<tr>
								<center>
									<strong><h3>
											<font color="blue">My Profile</font>
										</h3></strong>
									</td>
								</center>
							</tr>
							<%
								Connection con = DBConnection.getConn();
									Statement st = con.createStatement();
									ResultSet rs = st.executeQuery("select username,user_address,user_mobile,user_email,user_designation,uname,password,security_question,answer from user_details where uname='"+ session.getAttribute("uid") + "'");
									if (rs.next()) {
							%>
							<tr>
								<td width="28%" rowspan="10">
									<div align="center"><img src="images/my_profile_green.png" width="180" height="150" /></div>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><strong>User Name</strong></td>
								<td>:</td>
								<td><input type="text" name="ename"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(1)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Address</strong></td>
								<td>:</td>
								<td><input type="text" name="eadd"
									style="width: 185px; height: 20px; rows: 10; border-radius: 8px;"
									value="<%=rs.getString(2)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Mobile</strong></td>
								<td>:</td>
								<td><input type="text" name="emobile"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(3)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Email</strong></td>
								<td>:</td>
								<td><input type="text" name="eemail"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(4)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Occupation</strong></td>
								<td>:</td>
								<td><input type="text" name="edesignation"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(5)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Name</strong></td>
								<td>:</td>
								<td><input type="text" name="uname"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(6)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>User Password</strong></td>
								<td>:</td>
								<td><input type="text" name="pass"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(7)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>Security Question</strong></td>
								<td>:</td>
								<td><input type="text" name="pass"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(8)%>" disabled></td>
							</tr>
							<tr>
								<td><strong>Answer</strong></td>
								<td>:</td>
								<td><input type="text" name="pass"
									style="width: 185px; height: 20px; border-radius: 8px;"
									value="<%=rs.getString(9)%>" disabled></td>
							</tr>

							<%
								}
							%>
						</table>
					</fieldset>
				</form>

			</div>

			<div id="column">
				<div class="holder">
					
				</div>
			</div>
			<br class="clear" />
		</div><br><br><br><br>
		<div class="wrapper col7">
			<div id="copyright">
				<p class="fl_left">
					Copyright &copy; 2016 - All Rights Reserved.</a>
				</p>
				<br class="clear" />
			</div>
		</div>
		<%
			} else {
				response.sendRedirect("index.jsp");
			}
		%>
	
</body>
</html>
