<html>
<head>
	<title>View Routes</title>
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
	<script>
		$(document).ready(function() {
			$.ajax({
				method: "GET",
				contentType: "application/json",
				url: "getroutes.jsp",
				data: {
					"datatoget": "names"
				},
				dataType: "json",
				success: function(routes) {
					var i;
					for (i = 0; i < routes.length; i++) {
						$("#myroutes").append("<li><a href=\"showmap.html?datatoget="+routes[i]+"\"data-ajax=\"false\">"+routes[i]+"</a></li>").listview('refresh');
					}
				},
				error: function(a,b,c) {
						$("#myroutes").append("You have no saved routes.");
				}
			});
		});
		function showmap(route) {
			$.ajax({
				method: "GET",
				contentType: "application/json",
				data: {
					"datatoget": route
				},
				url: "getroutes.jsp",
				dataType: "json",
				success: function(routes) {

				},
				error: function(a,b,c) {
						$("#myroutes").append("For some reason, this route could not be viewed.");
				}
			});
		}	
	</script>
</head>
<body>
	<div data-role="page">
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