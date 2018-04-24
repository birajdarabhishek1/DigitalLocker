<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"
	dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="imagetoolbar" content="no" />
<link rel="stylesheet" href="styles/layout.css" type="text/css" />
<script type="text/javascript">
	function validate2() {
		var username = document.myform.uid.value;
		var status = false;
		if (username.length < 1) {
			document.getElementById("nameloc3").innerHTML = "<img src='images/unchecked.gif'/> Enter ur user name ";
			status = false;
		} else {
			document.getElementById("nameloc3").innerHTML = "<img src='images/checked.gif'/>";
			status = true;
		}
	}
	function validate3() {
		var password = document.myform.pass.value;
		var status = false;
		if (password.length<8 || password.length>8) {
			document.getElementById("passloc").innerHTML = "<img src='images/unchecked.gif'/>Enter your correct password";
			status = false;
		} else {
			document.getElementById("passloc").innerHTML = "<img src='images/checked.gif'/>";
			status = true;
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
	<div class="wrapper col2">
		<div id="topbar">
			<div id="topnav">
				<ul>
					<li><a href="index.jsp">Home</a></li>
					<li><a href="adminLogin.jsp">Admin Login</a></li>
				</ul>

			</div>
			<br class="clear" />
		</div>
	</div>

	<div class="wrapper col5">
		<div id="container">
			<div id="content">
				<h2>About Digital Locker</h2>
				<p style="margin-left: 5px; height: 65px;">
					<marquee scrollamount="1" scrolldelay="50" align="justify"
						direction="up" onmouseout="this.start()" onmouseover="this.stop()">
					<strong>Digital Locker</strong> is a free service that allows you to store files online and access them anywhere using the cloud and share them too. It is free web-based applications for storing documents such as Certificates, Passport, SSN, etc.  Verification of documents & certificates in a digital way, thus eliminating the use of physical documents.</marquee>
				</p>
			</div>
			<div id="column">
				<div class="holder">
					<h2>Sign on to Digital Locker</h2>
					<ul id="latestnews">

						<%
							String Sucess = request.getParameter("message");
							if (Sucess != null && Sucess.equalsIgnoreCase("blockuser")) {
								out.println("<font color='green' size='3' >Block User !!!! </font><br/>");
						%>
						<script type="text/javascript">
							alert("You are Block User");
						</script>
						<%
							}
						%>


						<form action="userLogin" method="post" name="myform">
							<fieldset style="width: 450px; height: 100px;">
								<table bgcolor="white">
									<tr>
										<td width="28%" rowspan="4"><div align="center">
												<img src="images/kdmconfig.png" width="150" height="100" />
											</div></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>User Id:</td>
										<td><input type="text" name="uid"  onblur="return validate2()"
											style="height: 20px; border-radius: 8px;"
											placeholder="Enter User Id" ><span id="nameloc3"></span></td>
									</tr>
									<tr>
										<td>Password:</td>
										<td><input type="password" name="pass" onblur="return validate3()"
											style="height: 20px; border-radius: 8px;"
											placeholder="Password"><span id="passloc"></span></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td><input type="submit" value="Login"
											style="height: 30px; color: white; background-color: #428bca; border-radius: 8px;">&nbsp;<input
												type="reset" value="Cancel"
												style="height: 30px; color: white; background-color: #428bca; border-radius: 8px;"></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td><a href="forgetPassword.jsp">Forget User
												Id/Password</a></td>
									</tr>


								</table>
								<a href="UserRegistration.jsp">Click Here to New
									Registration</a>
							</fieldset>
						</form>
					</ul>
				</div>
			</div>
			<br class="clear" />
		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
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
