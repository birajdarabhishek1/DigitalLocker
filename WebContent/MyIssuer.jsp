<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"
	dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
<script>
	function verify() {
		if (document.getElementById('filename').value == "") {
			alert('Please select the file');
			return false;
		} else {
			return true;
		}
	}
</script>
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
	<%
	Connection con=MyConnection.getConnection();
	Statement st=con.createStatement();
	ResultSet rs=st.executeQuery("select count(*) as rowcount from access where touser='"+session.getAttribute("uid")+"' and status='Pending'");
	rs.next();
	int count = rs.getInt("rowcount");
	%>
	<div class="wrapper col2" style="left-margin: 10px;">
		<div id="topbar" style="width: 1300px; left-margin: 10px;">
			<div id="topnav" style="width: 1400px; left-margin: 15px;">
				<ul>
					<li><a href="MyProfile.jsp">My Profile</a></li>
					<li><a href="EditProfile.jsp">Edit Profile</a></li>
					<li><a href="DocumentsUploadingAndDownloading.jsp">My Certificate</a></li>
					<li><a href="MyIssuer.jsp">Notification<font color="yellow">(<%=count%>)</font></a></li>
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
				
				<p>
							<h2>
								<font color="#52BE80">All Request</font>
							</h2>
							<p>
							
							<table><table border="1" cellspacing="1" cellpadding="1">
									<tr bgcolor="#428bca" style="height: 40px;">
										<td><font color="white">Request From</font></td>
										<td><font color="white">Email-Id</font></td>
										<td><font color="white">Document Name</font></td>
										<td><font color="white">To User</font></td>
										<td><font color="white">Action</font></td>
										
									</tr>
								<%
									Statement st1=con.createStatement();
									ResultSet rs1=st1.executeQuery("select fromuser,email,fillename,touser from access where touser='"+session.getAttribute("uid")+"' and status='Pending'");
									while(rs1.next())
									{%>
										<form action="EmailSendingServlet" method="post">
										<tr>
											<td><input type="text" name="name" value="<%=rs1.getString(1)%>" style="height: 25px; width: 150px; background-color: white; border-radius: 8px;"></td>
											<td><input type="text" name="email" value="<%=rs1.getString(2)%>" style="height: 25px; width: 150px; background-color: white; border-radius: 8px;"></td>
											<td><input type="text" name="dname" value="<%=rs1.getString(3)%>" style="height: 25px; width: 150px; background-color: white; border-radius: 8px;"></td>
											<td><input type="text" name="toUser" value="<%=rs1.getString(4)%>" style="height: 25px; width: 150px; background-color: white; border-radius: 8px;"></td>
											<td><input type="submit" value="Accept" style="height: 25px; color: white; background-color: #428bca; border-radius: 8px;"><input type="reset" value="Decline" style="height: 25px; color: white; background-color: #428bca; border-radius: 8px;"></td>
										</tr>
										</form>
									<%}
								%>
								</table>
							</p>
			</div>
			<div id="column">
				<div class="holder">
					
				</div>
			</div>
			<br class="clear" />
		</div>
		<br><br><br><br><br><br>
	</div>
	<br class="clear" />
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
