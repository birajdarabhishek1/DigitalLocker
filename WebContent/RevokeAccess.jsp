<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@page import="java.math.BigInteger"%>
<%@page import="com.filesharing.ElGamal"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.connection.MyConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import=" java.io.PrintWriter"%>
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
			<div id="topnav" style="width: 1400px; left-margin: 15px;">
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
					<li><a href="">Welcome&nbsp;<strong><font color="yellow"> <% out.print((String) session.getAttribute("uid")); %></font></strong></a></li>
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
				<center>
					<h3>Select File For Revoke</h3>
				</center>
				<br>
				
				<%
						String user = (String) session.getAttribute("uid");
						ResultSet rs = null;
						PreparedStatement st = null;
						String query = null;
						PrintWriter out1 = null;
						try {
							Connection con = MyConnection.getConnection();
							response.setContentType("text/html;charset=UTF-8");
							out1 = response.getWriter();
							query = "select * from documents where upload_by='" + user + "'";
							st = con.prepareStatement(query);
							rs = st.executeQuery();
							while (rs.next()) {
								String files = rs.getString("filename");
				%>
				<form action="RevokeFile.jsp" name="frm">
					<center>
						<table border="1" width="30%" bgcolor="white">
							<tr>
								<td><input type="radio" name="rad1" value="<%=files%>"><%=files%></td>
							</tr>
							
							<%
								}
									} catch (SQLException e) {

										e.printStackTrace();
									}
							%>
							<tr>
								<td><input type="submit" name="ok" value="Revoke" style="height: 25px; color: white; background-color: #428bca; border-radius: 8px;"></td>
							</tr>
						</table>
						</center>
				</form>
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
		<%
			} else {
				response.sendRedirect("index.jsp");
			}
		%>
	
</body>
</html>
