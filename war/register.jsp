<!DOCTYPE html>
<html><head>
<title>Register to Use Cartracker</title>
<link rel="stylesheet" href="styles.css"/>
<link rel="stylesheet" href="jquery.mobile-1.2.0.min.css" />
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFSBkXjV3dteXXbZKZbhVzshHNd54ISUY&sensor=true"></script>
<script src="jquery-1.8.2.min.js"></script>
<script src="jquery.validate.js"></script>
<script src="jquery.mobile-1.2.0.min.js"></script>
<script src="prelogin.js"></script>
</head><body>
 
 
 
<div data-role="page" id="register">
	<div class="center">
		<div data-role="header">
			<h1>Cartracker</h1>
		</div>
 		<div data-role="content">
 			<a href="home.html" class="button" data-role="button" data-inline="true">Home</a>
 			<a href="about.html" class="button" data-role="button" data-inline="true">About</a>
 			<a id="login" href="login.html" class="button" data-role="button" data-inline="true">Login</a>
			<h1 class="center">Register to Use Cartracker</h1>
			<form method="post" action="register.jsp" id="form">
			<table class="center">
			<tr><td id="errmsg" class="error" colspan="2"></td></tr>
			<tr><td><b>Note: Username must be an 8-digit alphanumeric string.</b></td></tr>
			<tr><td>Username:</td><td><input name="username" class="required username" id="username"></td></tr>
			<tr><td>Password:</td><td><input name="password" type="password" class="required" id="password"></td></tr>
			<tr><td>Confirm password:</td><td><input name="confirmpassword" type="password"></td></tr>
			<tr><td></td><td><input type="submit" value="Submit"></td></tr>
			</form>
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
		String confirm = request.getParameter("confirmpassword");
		
		if (username == null) username = "";
		if (password == null) password = "";
		if (confirm == null) confirm = "";
		
		boolean isPost = "POST".equals(request.getMethod());

		String simpleUserRegex = 
				"^[_A-Za-z0-9-\\+]{8,}$";
		if (isPost && username.length() > 0 && !username.matches(simpleUserRegex)) {
			errorMessage = "Invalid username";
		} else if (isPost && username.length() > 0 && password.length() > 0 && confirm.length() > 0) {
			// create an account
			if (!confirm.equals(password)) {
				errorMessage = "Sorry, your password has a typo.";
			} else {
				boolean exists = User.usernameExists(username, pm);
				if (exists) {
					errorMessage = "Sorry, that username is taken.";
				} else {
					User user = User.createAccount(username, password);
					pm.makePersistent(user);
					session.setAttribute("user", user.getID());
				}
			}
		}  else {
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

		<div data-role="footer" data-position="fixed">
			<small>&copy;2016 Cartracker</small>
		</div>
	</div>
</div>
</body></html>
