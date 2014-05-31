package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bees_country")
public class Country extends ModelDefault {
	private static final long serialVersionUID = 1L;

	@Column(name = "iso2")
	private String iso2;

	@Column(name = "iso3")
	private String iso3;

	@Column(name = "m49")
	private String m49;

	@Column(name = "zone")
	private String zone;

	// Getters and Setters

	public String getIso2() {
		return iso2;
	}

	public String getIso3() {
		return iso3;
	}

	public String getM49() {
		return m49;
	}

	public String getZone() {
		return zone;
	}

	public void setIso2(String iso2) {
		this.iso2 = iso2;
	}

	public void setIso3(String iso3) {
		this.iso3 = iso3;
	}

	public void setM49(String m49) {
		this.m49 = m49;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

}
