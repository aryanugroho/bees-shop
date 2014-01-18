package org.beesden.shop.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import org.hibernate.validator.constraints.Range;

@Entity
@Table(name = "bees_customer")
public class Customer extends ModelContact {
	private static final long serialVersionUID = 1L;

	@OneToMany(fetch = FetchType.EAGER)
	@OrderBy("id")
	@JoinColumn(name = "addresses")
	private Set<Address> addresses;

	@Range(min = 8, max = 150)
	@Column(name = "password", length = 150)
	private String password;

	// Getters and Setters

	public Set<Address> getAddresses() {
		return addresses;
	}

	public String getPassword() {
		return password;
	}

	public void setAddresses(Set<Address> addresses) {
		this.addresses = addresses;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
