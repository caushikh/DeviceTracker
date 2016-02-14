package com.cartracker2;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Blob;

@PersistenceCapable
public class Item {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long id;

	@Persistent
	private Blob photo;
	@Persistent
	private String caption;
	@Persistent
	private Long owner;

	public Long getID() {
		return id;
	}

	public byte[] getPhoto() {
		return photo != null ? photo.getBytes() : new byte[0];
	}

	public void setPhoto(byte[] photo) {
		this.photo = new Blob(photo != null ? photo : new byte[0]);
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public Long getOwner() {
		return owner;
	}

	public void setOwner(Long owner) {
		this.owner = owner;
	}

	@SuppressWarnings("unchecked")
	public static List<Item> loadItems(Long owner, PersistenceManager pm) {
		Query query;
		List<Item> rv;
		if (owner == null) {
			query = pm.newQuery(Item.class);
			rv = (List<Item>) query.execute();
		} else {
			query = pm.newQuery(Item.class, "owner == :oo");
			rv = (List<Item>) query.execute(owner);
		}
		query.closeAll();
		return rv;
	}

}
