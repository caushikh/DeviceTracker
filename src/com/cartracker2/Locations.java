package com.cartracker2;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.annotations.Element;
import javax.jdo.annotations.Extension;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class Locations {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	@Extension(vendorName="datanucleus", key = "gae.encoded-pk", value = "true")
	private String id;

	
	@Element(dependent="true")
	private List<GeoPoint> stops;
	
	@Persistent
	private String routename;
	
	@Persistent
	private Long owner;

	public String getID() {
		return id;
	}

	public List<GeoPoint> getStops() {
		return stops;
	}

	public void setStops(List<GeoPoint> newstops) {
		this.stops = newstops;
	}

	public Long getOwner() {
		return owner;
	}

	public void setOwner(Long owner) {
		this.owner = owner;
	}

	public void setRouteName(String route) {
		this.routename = route;
	}
	
	public String getRouteName() {
		return this.routename;
	}
	
	@SuppressWarnings("unchecked")
	public static List<Locations> loadLocations(Long owner, PersistenceManager pm) {
		Query query;
		List<Locations> rv;
		if (owner == null) {
			query = pm.newQuery(Locations.class);
			rv = (List<Locations>) query.execute();
		} else {
			query = pm.newQuery(Locations.class, "owner == :oo");
			rv = (List<Locations>) query.execute(owner);
		}
		query.closeAll();
		return rv;
	}

}
