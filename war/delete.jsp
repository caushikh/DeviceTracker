<html>
<head>
	<title>View Routes</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no" />
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
	<div data-role="page" id="delete">
		<div data-role="header">
			<div id="title"><h2>Delete Routes</h2></div>
		</div>
		<div data-role="content">
			<ul data-role="listview" id="deleteroutes">
			</ul>
			<div data-role="popup" id="deletepopup">
				<div data-role="header">
					<h1>Delete Route</h1>
				</div>
				
				<div data-role="content">
					Are you sure you want to delete this route?<br>
					<a onclick="deleteRoute()" data-rel="back" id="deletelink" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">Yes</a>
					<a data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-b">No</a>
				</div>
			</div>
		</div>
		<div data-role="footer" class="navigation">
			<a href="homesplash.jsp">Back</a>
			<a href="login.jsp">Logout</a>
		</div>
	</div>
</body>
</html>

<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.*" %>
<%@ page import="com.cartracker2.*" %>
<%@ page import="org.json.simple.*" %>
<%
	PersistenceManager pm = PMF.getPMF().getPersistenceManager();
	Transaction tx = pm.currentTransaction();
	try {
		tx.begin();
		
		Long userid;
		String routename;
		List<Locations> locations;
		Query query;
		
		userid = (Long) session.getAttribute("user");
		routename = request.getParameter("name");
		query = pm.newQuery(Locations.class, "owner == :oo && routename == :rr");
		locations = (List<Locations>) query.execute(userid, routename);
		if (locations.size() > 0) {
			System.out.println("there is a location to delete");
			Locations routeloc = locations.get(0);
			pm.deletePersistent(routeloc);
			tx.commit();
		}
	}
	finally {
		if (tx.isActive()) {
			// Error occurred so rollback the transaction
			tx.rollback();
		}
		pm.close();
	}
%>