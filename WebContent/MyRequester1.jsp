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
					<li><a href="">Welcome&nbsp;<strong><font
								color="yellow">
									<%
										out.print((String) session.getAttribute("uid"));
									%>
							</font></strong></a></li>
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
								<font color="#52BE80">Uploaded Documents</font>
							</h2>
							<p>
								<table border="1" cellspacing="1" cellpadding="1">
									<tr bgcolor="#428bca" style="height: 40px;">
										<td><font color="white">Sr.No</font></td>
										<td><font color="white">Document Name</font></td>
										<td><font color="white">Uploaded By</font></td>
										<td><font color="white">File Type</font></td>
										<td><font color="white">Upload Time</font></td>
										<td><font color="white">File Request</font></td>
									</tr>
									<tr>
										<%
											ResultSet rs = MyConnection.getResultFromSqlQuery("select doc_id,filename,type,upload_time, upload_by from documents where upload_by='"+request.getParameter("userReqest")+"'");
												int count = 0;
												while (rs.next()) {
													out.println("<tr bgcolor='white'>" + "<td>" + rs.getString(1) + "</td>" + "<td>" + rs.getString(2)
															+ "</td>" + "<td>" + request.getParameter("userReqest") + "</td>" + "<td>" + rs.getString(3) + "</td>" + "<td>"
															+ rs.getString(4) + "</td>" + "<td><a href='SendRequest.jsp?upload_by_Filename=" + request.getParameter("userReqest")
															+"-"+rs.getString(2)+"'> Send Request </a></td>" + "</tr>");
													count++;
												}
												rs.close();
												MyConnection.CloseConnection();
												if (count == 0) {
													out.println("<tr><td colspan='4'> No File Found..!! </td></tr>");
												}
										%>
									</tr>
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
