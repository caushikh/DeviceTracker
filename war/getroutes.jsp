<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.cartracker2.*" %>
<%
	PersistenceManager pm = PMF.getPMF().getPersistenceManager();
	try {
		Long userid = (Long) session.getAttribute("user");
		List<Locations> locations; 
		JSONArray jarr = new JSONArray();
		Query query;
		if (request.getParameter("datatoget").equals("names")) {
			
			locations = Locations.loadLocations(userid, pm);
			for (Locations i: locations) {
				jarr.add(i.getRouteName());
			}
			out.write(jarr.toString());
		}
		else {
			String route = request.getParameter("datatoget");
			query = pm.newQuery(Locations.class, "routename == :rr");
			locations = (List<Locations>) query.execute(route);
			Locations routeloc = locations.get(0);
			List<GeoPoint> stops = routeloc.getStops();
			JSONObject jobj;
			for (GeoPoint g: stops) {
				jobj = new JSONObject();
				jobj.put("lat", g.getLat());
				jobj.put("lng", g.getLng());
				jarr.add(jobj);
			}
			out.write("<script>");
			out.write("location = 'showmap.jsp';");
			out.write("</script>");
			out.write(jarr.toString());
			query.closeAll();
		}
		
	} finally {
		pm.close();
	}
%>