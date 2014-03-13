package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bees_delivery")
public class DeliveryCharge extends ModelDefault {

	private static final long serialVersionUID = -1238666691315061482L;

	@Column(name = "charge", length = 150)
	private Double charge;

	// Getters and Setters

	public Double getCharge() {
		return charge;
	}

	public void setCharge(Double charge) {
		this.charge = charge;
	}

}
