<html>
<head>
	<title>Home Splash</title>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta charset="utf-8">
	<style>
		html, body, #home{
			height: 100%;
			padding: 0px;
		}
		#mapcanvas {
			height: 100%;
			width: 100%;
			margin: 0 auto;
		}
		#title, #update {
			text-align: center;
		}
	</style>
	<link rel="stylesheet" href="jquery.mobile-1.2.0.min.css" />
	<script src="jquery-1.8.2.min.js"></script>
	<script src="jquery.mobile-1.2.0.min.js"></script>
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
	<div data-role="page">
		<div data-role="header">
			<div><h2>Welcome User!</h2></div>
		</div>
		<div data-role="content">
			<ul data-role="listview">
				<li><a href="track.html" data-ajax="false">Track New Route</a></li>
				<li><a href="view.jsp" data-ajax="false">View My Routes</a></li>
			</ul>
		</div>
		<div data-role="footer">
			<a href="login.jsp">Logout</a>
		</div>
	</div>
</body>
</html>