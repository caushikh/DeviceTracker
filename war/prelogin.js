$(document).on("pageinit", "#login1", function() {
	$("#form").validate();
	
	//var loginfunc = function() {
	//	window.location = "login.jsp?cb=" + (new Date()).getTime();
	//}
	//var login = document.getElementById('login');
	//if (login){
	//	login.addEventListener("click", loginfunc, false);
	//}
	//$("#login").("click", function() {
		window.location = "login.jsp?cb=" + (new Date()).getTime();
	//});
	//$("#login").href = "login.jsp?cb=" + (new Date()).getTime();
});

$(document).on("pageinit", "#track", function() {
	var stops = [];
	var map;
	var poly;
	var loctimer;
	function initialize(lat,lng) {
		// create map with following map parameters
		var pos = new google.maps.LatLng(lat,lng);
		stops.push(pos);
		var mapOptions = {
			zoom: 15,
			center: pos
		};
		
		map = new google.maps.Map(document.getElementById('mapcanvas'), mapOptions);
		
		var marker = new google.maps.Marker({
			position: pos,
			map: map
		});

		poly = new google.maps.Polyline({
			path: stops,
			strokeColor: '#FF0000',
			strokeWeight: 1,
			map: map
		});
		
	}
	function success(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		$("#date").text(Date());
		google.maps.event.addDomListener(window,'load',initialize(lat,lng));
	}
	function error(error) {
		$("#mapcanvas").append("error code: "+error.code+"<br>error message: "+error.message);
	}
	function updatePosition(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		$("#date").text(Date());
		var newPos = new google.maps.LatLng(lat,lng);
		stops.push(newPos);
		var marker = new google.maps.Marker({
			position: newPos,
			map: map
		});
		map.setCenter(newPos);
		poly.setPath(stops);
	}
	function getLocation(success,error) {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(success,error);
		}
		else {
			$("#mapcanvas").append("Geolocation is not supported by your browser.");
		}
	}
	
	getLocation(success,error);
	loctimer = setInterval(function() { getLocation(updatePosition,error) }, 60000);

function save() {
		if ($("#save").val() == "") {
			$("#save").append("Please enter the name of this route:<br><input type=\"text\" id=\"name\">");
			$("#save").append("<button onclick=\"upload()\">Submit</button>");
		}
}
function upload() {
		if ($("#name").val() == "") {
			$("#save").empty();
			$("#save").append("Route name not entered. Please enter the name of this route:<br><input type=\"text\" id=\"name\">");
			$("#save").append("<button onclick=\"upload()\">Submit</button>");
		}
		else {
			var stopsjson = [];
			$("#save").hide();
			var routename = $("#name").val();
			stopsjson = stopsJson(stops);
			var test = ["test","test2"]
			$.ajax({
				method: "POST",
				contentType: "application/json",
				url: "savemap.jsp",
				data: {
					"locations": stopsjson,
					"name": routename
				},
				success: function(data) {
					console.log(data)
					$("#msg").empty();
					$("#msg").append("Map saved successfully. <a href=\"homesplash.jsp\">Click Here </a>to go back.");
				},
				error: function(a,b,c) {
					$("#msg").empty();
					$("#msg").append("Map could not be saved. Try again or <a href=\"homesplash.jsp\">click Here </a>to go back.");
				}
			});
		}
	}
	function stopsJson(stops) {
		var i;
		var stopsjson = []
		var tmplat;
		var tmplng;
		var loc = {};
		for (i = 0; i < stops.length; i++) {
			tmplat = stops[i].lat();
			tmplng = stops[i].lng();
			loc = {
				"lat": tmplat,
				"lng": tmplng
			};
			stopsjson.push(loc);
		}
		return stopsjson;
	}
});

$(document).on("pageinit", "#view", function() {
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
});	