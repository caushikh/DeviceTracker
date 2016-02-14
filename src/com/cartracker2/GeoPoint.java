package com.cartracker2;

import javax.jdo.annotations.Extension;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable
public class GeoPoint {
	
	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	@Extension(vendorName="datanucleus", key = "gae.encoded-pk", value = "true")
	private String id;
	
	@Persistent
	private String lat;
	
	@Persistent
	private String lng;
	
	public GeoPoint(String latitude, String longitude) {
		this.lat = latitude;
		this.lng = longitude;
	}
	
	public String getLat() {
		return this.lat;
	}
	
	public String getLng() {
		return this.lng;
	}
	
	public void setLat(String latitude) {
		this.lat = latitude;
	}
	
	public void setLng(String longitude) {
		this.lng = longitude;
	}
}
