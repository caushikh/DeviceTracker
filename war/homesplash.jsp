<!DOCTYPE html>
<html>
<head>
	<title>Home Splash</title>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta charset="utf-8">
	<link rel="stylesheet" href="styles.css"/>
	<link rel="stylesheet" href="jquery.mobile-1.2.0.min.css" />
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCFSBkXjV3dteXXbZKZbhVzshHNd54ISUY&sensor=true"></script>
	<script src="jquery-1.8.2.min.js"></script>
	<script src="jquery.validate.js"></script>
	<script src="jquery.mobile-1.2.0.min.js"></script>
	<script src="prelogin.js"></script>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.*" %>
<%@ page import="com.cartracker2.*" %>
<%
	PersistenceManager pm = PMF.getPMF().getPersistenceManager();
	try {
		Long userId = (Long)session.getAttribute("user");
		out.write("<script>");
		if (userId == null) {
			out.write("location = 'login.jsp';");
		} 
		out.write("</script>");
		
		
	} finally {
		pm.close();
	}
%>
	<div data-role="page" id="homesplash">
		<div data-role="header">
			<div id="title"><h2>Welcome User!</h2></div>
		</div>
		<div data-role="content">
			<ul data-role="listview">
				<li><a href="track.html" data-ajax="false">Track New Route</a></li>
				<li><a href="view.jsp" data-ajax="false">View My Routes</a></li>
				<li><a href="delete.jsp" data-ajax="false">Delete Routes</a></li>
			</ul>
		</div>
		<div data-role="footer" class="navigation">
			<a href="login.jsp">Logout</a>
		</div>
	</div>
</body>
</html>