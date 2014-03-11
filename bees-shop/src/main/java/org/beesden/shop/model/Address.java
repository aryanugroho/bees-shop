package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bees_address")
public class Address extends ModelContact {
	private static final long serialVersionUID = 1L;

	@Column(name = "country", length = 3)
	private String country;

	@ManyToOne
	@JoinColumn(name = "customerId")
	private Customer customer;

	@Column(name = "geoLat")
	private Double geoLat;

	@Column(name = "geoLng")
	private Double geoLng;

	@Column(name = "line1", length = 150)
	private String line1;

	@Column(name = "line2", length = 150)
	private String line2;

	@Column(name = "line3", length = 150)
	private String line3;

	@Column(name = "locality", length = 150)
	private String locality;

	@Column(name = "postalCode", length = 15)
	private String postalCode;

	@Column(name = "region", length = 150)
	private String region;

	// Getters and Setters

	public String getCountry() {
		return country;
	}

	public Customer getCustomer() {
		return customer;
	}

	public Double getGeoLat() {
		return geoLat;
	}

	public Double getGeoLng() {
		return geoLng;
	}

	public String getLine1() {
		return line1;
	}

	public String getLine2() {
		return line2;
	}

	public String getLine3() {
		return line3;
	}

	public String getLocality() {
		return locality;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public String getRegion() {
		return region;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setGeoLat(Double geoLat) {
		this.geoLat = geoLat;
	}

	public void setGeoLng(Double geoLng) {
		this.geoLng = geoLng;
	}

	public void setLine1(String line1) {
		this.line1 = line1;
	}

	public void setLine2(String line2) {
		this.line2 = line2;
	}

	public void setLine3(String line3) {
		this.line3 = line3;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public void setRegion(String region) {
		this.region = region;
	}
}
