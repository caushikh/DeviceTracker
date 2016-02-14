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
			System.out.println("got here");
			String route = request.getParameter("datatoget");
			query = pm.newQuery(Locations.class, "owner == :oo && routename == :rr");
			locations = (List<Locations>) query.execute(userid, route);
			Locations routeloc = locations.get(0);
			List<GeoPoint> stops = routeloc.getStops();
			JSONObject jobj;
			for (GeoPoint g: stops) {
				jobj = new JSONObject();
				jobj.put("lat", g.getLat());
				jobj.put("lng", g.getLng());
				jarr.add(jobj);
			}
			out.write(jarr.toString());
	} finally {
		pm.close();
	}
%>