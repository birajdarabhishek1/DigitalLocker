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
							<h2>
								<font color="#52BE80">Uploaded Documents</font>
							</h2>
							<p>
								<table border="1" cellspacing="1" cellpadding="1">
									<tr bgcolor="#428bca" style="height: 40px;">
										
										<td><font color="white">Document Name</font></td>
										<td><font color="white">Uploaded By</font></td>
										<td><font color="white">File Type</font></td>
										<td><font color="white">Upload Time</font></td>
										<td><font color="white">Status</font></td>
										<td><font color="white">Download</font></td>
									</tr>
									<tr>
										<%
											ResultSet rs = MyConnection.getResultFromSqlQuery("select doc_id,filename,type,upload_time, upload_by,status from documents where upload_by='"+session.getAttribute("uid")+"'");
												int count = 0;
												while (rs.next()) {
													out.println("<tr bgcolor='white'>" + "<td>" + rs.getString(2)
															+ "</td>" + "<td>" + session.getAttribute("uid") + "</td>" + "<td>" + rs.getString(3) + "</td>" + "<td>"
															+ rs.getString(4) + "</td>" +"<td>" + rs.getString(6) + "</td>"+ "<td><a href='download.jsp?Doc_id=" + rs.getInt(1)
															+ "'> Download </a></td>" + "</tr>");
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
					<h2>
						<font color="#52BE80">Upload Documents</font>
					</h2>
					<ul id="latestnews">
						<form enctype="multipart/form-data" action="uploadfile.jsp"
							method="post" onsubmit="return verify()">
							<fieldset style="width: 550px; height: 250px;">
								<table bgcolor="white" style="width: 550px; height: 350px;">
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td><font color="red">Remember you can upload only
												MS-word, MS-Excel, txt , PDF files and Images </font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>Upload Documents:</td>
										<td><input type="file" name="filename" id="filename"
											accept=".txt, application/pdf, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msword"></td>
												
									</tr>
									<tr>
									<td>&nbsp;</td>
										<td>Description :</td>
									<td><textarea rows="6" cols="" name="description" style="width:180px;border-radius: 8px;"></textarea></td>
										
									</tr>
									<tr>
									<td>&nbsp;</td>
									<td>Issuing Authority :</td>
									<td><input type="text" name="issuing_Authority" style="width:180px;height: 20px;border-radius: 8px;"></input></td>
									</tr>
									
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td><input type="submit" value="Upload"
											style="height: 30px; color: white; background-color: #73C6B6; border-radius: 8px;">&nbsp;<input
												type="reset" value="Cancel"
												style="height: 30px; color: white; background-color: #73C6B6; border-radius: 8px;"></td>
									</tr>
								</table>
							</fieldset>
						</form>
					</ul>
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
