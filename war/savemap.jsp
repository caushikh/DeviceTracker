<%@ page import="java.util.*" %>
<%@ page import="javax.jdo.*" %>
<%@ page import="com.cartracker2.*" %>
<%@ page import="org.json.simple.*" %>
<%
	PersistenceManager pm = PMF.getPMF().getPersistenceManager();
	try {
		String templat;
		String templng;
		String[] tempval;
		Locations newRoute = new Locations();
		String routename;
		Long userid;
		int numstops;
		
		GeoPoint stop;
		List<GeoPoint> stoplist = new ArrayList<GeoPoint>();
		
		userid = (Long) session.getAttribute("user");
		newRoute.setOwner(userid);
		Map<String,String[]> param = request.getParameterMap();
		Set<String> paramset = param.keySet();
		
		routename = (param.get("name"))[0];
		newRoute.setRouteName(routename);
		
		numstops = (paramset.size() - 1) / 2;
		for (int i = 0; i < numstops; i++) {
			templat = (param.get("locations["+i+"][lat]"))[0];
			templng = (param.get("locations["+i+"][lng]"))[0];
			stop = new GeoPoint(templat,templng);
			stoplist.add(stop);
		}
		newRoute.setStops(stoplist);
		pm.makePersistent(newRoute);
		
	} finally {
		pm.close();
	}
%>