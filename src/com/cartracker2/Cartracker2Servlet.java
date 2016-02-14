package com.cartracker2;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.*;
import java.util.logging.Logger;


@SuppressWarnings("serial")
public class Cartracker2Servlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		handleRequest(resp);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		handleRequest(resp);
	}
	
	public void handleRequest(HttpServletResponse resp) throws IOException {
		resp.setContentType("text/html");
		
		PersistenceManager pm = PMF.getPMF().getPersistenceManager();
		try {
			Query query = pm.newQuery(Locations.class);
			List<Locations> routes = (List<Locations>) query.execute();
			int numroutes = routes.size();
			Logger.getLogger(Cartracker2Servlet.class.getName()).info(
					"There are " + numroutes + " total routes.");
		} finally {
			pm.close();
		}
		resp.getWriter().println("success");
	}
}
