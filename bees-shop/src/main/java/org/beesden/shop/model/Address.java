package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bees_address")
public class Address extends ModelContact {
	private static final long serialVersionUID = 1L;

	@Column(name = "address1", length = 150)
	private String address1;

	@Column(name = "address2", length = 150)
	private String address2;

	@Column(name = "address3", length = 150)
	private String address3;

	@Column(name = "city", length = 150)
	private String city;

	@OneToOne
	@JoinColumn(name = "country", referencedColumnName = "iso3")	
	private Country country;

	@ManyToOne
	@JoinColumn(name = "customerId")
	private Customer customer;

	@Column(name = "geoLat")
	private Double geoLat;

	@Column(name = "geoLng")
	private Double geoLng;

	@Column(name = "postalCode", length = 15)
	private String postalCode;

	@Column(name = "region", length = 150)
	private String region;

	// Getters and Setters

	public String getAddress1() {
		return address1;
	}

	public String getAddress2() {
		return address2;
	}

	public String getAddress3() {
		return address3;
	}

	public String getCity() {
		return city;
	}

	public Country getCountry() {
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

	public String getPostalCode() {
		return postalCode;
	}

	public String getRegion() {
		return region;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public void setAddress3(String address3) {
		this.address3 = address3;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public void setCountry(Country country) {
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

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public void setRegion(String region) {
		this.region = region;
	}
}
