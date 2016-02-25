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
	<div data-role="page" id="view">
		<div data-role="header">
			<div><h2>Your Routes</h2></div>
		</div>
		<div data-role="content">
			<ul data-role="listview" id="myroutes">
			</ul>
		</div>
		<div data-role="footer">
			<a href="login.jsp">Logout</a>
		</div>
	</div>
</body>
</html>