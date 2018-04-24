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
	<div class="wrapper col1"
		style="background-color: white; height: 180px;">
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
					<li><a href="">Welcome&nbsp;<strong><font color="yellow"> <%out.print((String) session.getAttribute("uid")); %></font></strong></a></li>
					<li><a href="Logout.jsp"><font color="yellow">Logout</font></a></li>
				</ul>

			</div>
			<br class="clear" />
		</div>
	</div>

	<div class="wrapper col5">
		<div id="container">
		<h2>Contact Us</h2>
			<div id="content" style="height:200px;border:15px;align:center;border-color:blue;cellpadding:4; cellspacing:0; background-color:black;">
				<p style="margin-left: 5px; height: 65px;">
					<marquee height="180" width="900" ID="MARQUEE1"  scrolldelay="100" direction="up" ONMOUSEOVER="MARQUEE1.stop();" ONMOUSEOUT="MARQUEE1.start();">
						<font color="white" face="sand" size=5>HEARTLY WELCOME TO ALL</font>
						<br><br>
						<br><font color="white" size="2">Name:&nbsp;Tejashri Rade</font> <br>
							<font color="white" size="2">Mobile:&nbsp;+1(321)616-0600</font><br>
							<font color="white" size="2">Email-Id:&nbsp;rade.tejashri3@gmail.com</font> <br>	
					</marquee>
				</p>	
			</div>
			<div id="column">
				<div class="holder"></div>
			</div>
			<br class="clear" />
		</div>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br> <br> <br> <br>
		
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
</body>
</html>




