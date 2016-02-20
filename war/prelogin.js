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