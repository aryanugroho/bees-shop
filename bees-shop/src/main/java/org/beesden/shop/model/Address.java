package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

@Entity
@Table(name = "bees_address")
public class Address extends ModelContact {

	@NotEmpty
	@Column(name = "country", length = 3)
	private String country;

	@Range(max=150)
	@Column(name = "county", length = 150)
	private String county;

	@Column(name = "geoLat")
	private Double geoLat;

	@Column(name = "geoLng")
	private Double geoLng;

	@Range(min = 2, max = 150)
	@Column(name = "line1", length = 150)
	private String line1;

	@Range(max=150)
	@Column(name = "line2", length = 150)
	private String line2;

	@Range(max=150)
	@Column(name = "line3", length = 150)
	private String line3;

	@Range(max=15)
	@Column(name = "postcode", length = 15)
	private String postcode;

	@Size(min = 2, max = 150)
	@Column(name = "town", length = 150)
	private String town;
	
	// Getters and Setters

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public Double getGeoLat() {
		return geoLat;
	}

	public void setGeoLat(Double geoLat) {
		this.geoLat = geoLat;
	}

	public Double getGeoLng() {
		return geoLng;
	}

	public void setGeoLng(Double geoLng) {
		this.geoLng = geoLng;
	}

	public String getLine1() {
		return line1;
	}

	public void setLine1(String line1) {
		this.line1 = line1;
	}

	public String getLine2() {
		return line2;
	}

	public void setLine2(String line2) {
		this.line2 = line2;
	}

	public String getLine3() {
		return line3;
	}

	public void setLine3(String line3) {
		this.line3 = line3;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getTown() {
		return town;
	}

	public void setTown(String town) {
		this.town = town;
	}
}
