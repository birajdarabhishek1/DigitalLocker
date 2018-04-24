<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Random"%>
<%@page import="com.connection.MyConnection"%>
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
	<div class="wrapper col1">
		<div id="header">
			<div id="logo">
				<h1>Digital Locker</h1>
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
					<li><a href="">Contact</a></li>
					<li><a href="">Welcome&nbsp;<strong><font color="yellow"> <%out.print((String) session.getAttribute("uid"));%></font></strong></a></li>
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

					<%
						HttpSession hs = request.getSession();
							if (request.getParameter("Filename") != null) {
								hs.setAttribute("Filename", request.getParameter("Filename"));

							}
					%>

					<br>
							<h2>
								<font color="#52BE80">Key For the File --><%=hs.getAttribute("Filename")%></font>
							</h2>
							<p>
								<form name="frmKey" onSubmit="return validate();" action="passwordcheckServlet" method="post">
									<fieldset style="width: 450px; height: 250px;">
										<table bgcolor="white" style="width: 300px;height:150px;border-radius:8px;">
											<%
											
												String Sucess = request.getParameter("message");
													if (Sucess != null && Sucess.equalsIgnoreCase("wrong")) {
														out.println("<font color='red' size='3' >Incorrect Key !!!! </font><br/>");

														Connection conn = MyConnection.getConnection();
														Statement st = conn.createStatement();
														ResultSet rs = st.executeQuery("select * from blockuser where user='" + session.getAttribute("uid") + "'");
														if (rs.next()) {
															if (rs.getInt(2) == 4) {
																st.executeUpdate("update blockuser set times=times+1 where user='"+ session.getAttribute("uid") + "'");
																response.sendRedirect("index.jsp?message=blockuser");
															} else {
																st.executeUpdate("update blockuser set times=times+1 where user='"+ session.getAttribute("uid") + "'");
															}
														} else {
															st.executeUpdate("insert into blockuser values('" + session.getAttribute("uid") + "','1')");
														}
											%>
											<script type="text/javascript">
												alert("Wrong Key");
											</script>
											<%
												}
											%>

											<tr>
												<td><strong>Enter Key</strong></td>
												<td>:</td>
												<td><input type="text" name="key"
													style="width: 180px; height: 20px; border-radius: 8px;"></input></td>
											</tr>

											<tr>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td><input type="submit" value="Download"
													style="height: 30px; color: white; background-color: #73C6B6; border-radius: 8px;">&nbsp;<input
														type="reset" value="Cancel"
														style="height: 30px; color: white; background-color: #73C6B6; border-radius: 8px;"></td>
											</tr>
										</table>
									</fieldset>
								</form>
							</p>
			</div>
			<div id="column">
				<div class="holder"></div>
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
