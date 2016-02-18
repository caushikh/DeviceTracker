<!DOCTYPE html>
<html><head>
<title>Log in to the Cartracker</title>
<style>
#newacct td {
	padding-top: 10px;
}
#errmsg {
	color: #FF0000;
}

.center {
	margin:auto;
}

.button {
	display:block;
	width: 29%;
	height:100%;
	text-overflow: clip;
	font-size: .1em;
}


</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="jquery.mobile-1.2.0.min.css" />
<script src="jquery-1.8.2.min.js"></script>
<script src="jquery.validate.js"></script>
<script src="jquery.mobile-1.2.0.min.js"></script>
<!--<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"></script>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="jquery.validate.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>-->
<script>
$(function() {
	$("#form").validate();
});
</script>
</head><body>
 
 <div class="center">
 	<a href="#" class="button" data-role="button" data-inline="true">Home</a>
 	<a href="#" class="button" data-role="button" data-inline="true">About</a>
 	<!--<a href="#" class="button" data-role="button" data-inline="true">Sign Up</a>-->
 	<a href="#" class="button" data-role="button" data-inline="true">Login</a>
 </div>
<div class="center"> 
	<h1 style="text-align:center">Log into the Cartracker</h1>
	<form method="post" action="login.jsp" id="form">
	<table class="center">
	<tr><td id="errmsg" class="error" colspan="2"></td></tr>
	<tr><td>Username:</td><td><input name="username" class="required username" id="username"></td></tr>
	<tr><td>Password:</td><td><input name="password" type="password" class="required" id="password"></td></tr>

	<tr><td></td><td><input type="submit" value="Submit"></td></tr>
	<tr><td></td><td>New User? <a href="register.jsp">Register Here</a></td></tr>
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
