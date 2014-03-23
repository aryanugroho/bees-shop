package org.beesden.shop.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "bees_tender")
public class Tender extends ModelDefault {
	private static final long serialVersionUID = 1L;

	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name = "addressId")
	private Address address;

	@Transient
	private String cardNumber;

	@Column(name = "cardType", length = 25)
	private String cardType;

	@ManyToOne
	@JoinColumn(name = "customerId")
	private Customer customer;

	@Column(name = "expiryDate")
	private Date expiryDate;

	@Transient
	private String securiryCode;

	@Column(name = "startDate")
	private Date startDate;

	// Getters and Setters

	public Address getAddress() {
		return address;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public String getCardType() {
		return cardType;
	}

	public Customer getCustomer() {
		return customer;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public String getSecuriryCode() {
		return securiryCode;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public void setCardType(String cardType) {
		this.cardType = cardType;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public void setSecuriryCode(String securiryCode) {
		this.securiryCode = securiryCode;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
}
