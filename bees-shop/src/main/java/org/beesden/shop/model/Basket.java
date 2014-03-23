package org.beesden.shop.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "bees_basket")
public class Basket implements Serializable {

	private static final long serialVersionUID = 3465391201648368058L;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "customerId")
	private Customer customer;

	@OneToOne(cascade=CascadeType.ALL)
	@JoinColumn(name = "deliveryAddress")
	private Address deliveryAddress;

	@Transient
	private DeliveryCharge deliveryCharge;

	@Column(name = "deliveryChargeName")
	private String deliveryChargeName;

	@Column(name = "deliveryChargePrice")
	private double deliveryChargePrice;

	@Column(name = "deliveryType", length = 150)
	private String deliveryType;

	@Id
	@Column(name = "ID")
	@GeneratedValue
	private Integer id;

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name = "basketId")
	private List<BasketItem> items;

	@Column(name = "orderPlaced")
	private Date orderPlaced;

	@Column(name = "orderStatus", length = 150)
	private String orderStatus;

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name = "paymentDetails")
	private Tender paymentDetails;

	@Column(name = "subTotal")
	private Double subTotal;

	@Transient
	private Boolean termsAgree;

	@Column(name = "total")
	private Double total;

	// Getters and Setters

	public Customer getCustomer() {
		return customer;
	}

	public Address getDeliveryAddress() {
		return deliveryAddress;
	}

	public DeliveryCharge getDeliveryCharge() {
		return deliveryCharge;
	}

	public String getDeliveryChargeName() {
		return deliveryChargeName;
	}

	public double getDeliveryChargePrice() {
		return deliveryChargePrice;
	}

	public String getDeliveryType() {
		return deliveryType;
	}

	public Integer getId() {
		return id;
	}

	public List<BasketItem> getItems() {
		return items;
	}

	public Date getOrderPlaced() {
		return orderPlaced;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public Tender getPaymentDetails() {
		return paymentDetails;
	}

	public Double getSubTotal() {
		return subTotal;
	}

	public Boolean getTermsAgree() {
		return termsAgree;
	}

	public Double getTotal() {
		return total;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public void setDeliveryAddress(Address deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}

	public void setDeliveryCharge(DeliveryCharge deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
	}

	public void setDeliveryChargeName(String deliveryChargeName) {
		this.deliveryChargeName = deliveryChargeName;
	}

	public void setDeliveryChargePrice(double deliveryChargePrice) {
		this.deliveryChargePrice = deliveryChargePrice;
	}

	public void setDeliveryType(String deliveryType) {
		this.deliveryType = deliveryType;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setItems(List<BasketItem> items) {
		this.items = items;
	}

	public void setOrderPlaced(Date orderPlaced) {
		this.orderPlaced = orderPlaced;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public void setPaymentDetails(Tender paymentDetails) {
		this.paymentDetails = paymentDetails;
	}

	public void setSubTotal(Double subTotal) {
		this.subTotal = subTotal;
	}

	public void setTermsAgree(Boolean termsAgree) {
		this.termsAgree = termsAgree;
	}

	public void setTotal(Double total) {
		this.total = total;
	}
}
