<!DOCTYPE html>
<html><head>
<title>Log in to the Cartracker</title>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="styles.css"/>
<link rel="stylesheet" href="jquery.mobile-1.2.0.min.css" />
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFSBkXjV3dteXXbZKZbhVzshHNd54ISUY&sensor=true"></script>
<script src="jquery-1.8.2.min.js"></script>
<script src="jquery.validate.js"></script>
<script src="jquery.mobile-1.2.0.min.js"></script>
<script src="prelogin.js"></script>
</head>
<body>
<div data-role="page" id="login2"> 
 	<div class="center">
 		<div data-role="header">
 			<h1>Cartracker</h1>
 		</div>
 		<div data-role="content" class="background">
 			<a href="home.html" class="button" data-role="button" data-inline="true">Home</a>
 			<a href="about.html" class="button" data-role="button" data-inline="true">About</a>
 			<!--<a href="#" class="button" data-role="button" data-inline="true">Sign Up</a>-->
 			<a id="login" class="button" data-role="button" data-inline="true">Login</a>
 		 
			<h1 class="center homeheader">Log into the Cartracker</h1>
			<form method="post" action="login.jsp" id="form">
			<table class="center">
			<tr><td id="errmsg" class="error" colspan="2"></td></tr>
			<tr><td class="logintext">Username:</td><td><input name="username" class="required username" id="username"></td></tr>
			<tr><td class="logintext">Password:</td><td><input name="password" type="password" class="required" id="password"></td></tr>

			<tr><td></td><td><input type="submit" value="Submit"></td></tr>
			<tr><td></td><td class="logintext">New User? <a href="register.jsp" id="register">Register Here</a></td></tr>
			</table>
			</form>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
		<div data-role="footer" data-position="fixed">
			<small>&copy;2016 Cartracker</small>
		</div>
	</div>
</div>




<%@ page import="javax.jdo.*" %>
<%@ page import="com.cartracker2.*" %>
<%@ page import="java.util.regex.*" %> 
<%
	PersistenceManager pm = PMF.getPMF().getPersistenceManager();
	try {
		session.setAttribute("user", null);
		
		String errorMessage = null;
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if (username == null) username = "";
		if (password == null) password = "";
		
		boolean isPost = "POST".equals(request.getMethod());

		String simpleUserRegex = 
				"^[_A-Za-z0-9-\\+]{8,}$";
		if (isPost && username.length() > 0 && !username.matches(simpleUserRegex)) {
			errorMessage = "Invalid username";
		} else if (isPost && username.length() > 0 && password.length() > 0) {
			// try to log in
			User user = User.loadAccount(username, password, pm);
			if (user == null) {
				errorMessage = "Sorry, the username or password has a typo.";
			} else {
				session.setAttribute("user", user.getID());
			}
		} else {
			// this is the first time loading
			// nothing to do here; carry on
		}
		
		out.write("<script>");
		if (session.getAttribute("user") != null) {
			out.write("location = 'homesplash.jsp';");
		} else {
			if (errorMessage != null) 
				out.write("$('#errmsg').text('"+Util.clean(errorMessage)+"');");
			if (username.length() > 0) 
				out.write("$('#username').val('"+Util.clean(username)+"');");
		}					
		out.write("</script>");
		
	} finally {
		pm.close();
	}
%>






</body></html>
