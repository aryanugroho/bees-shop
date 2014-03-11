package org.beesden.shop.model;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "bees_customer")
public class Customer extends ModelContact {

	private static final long serialVersionUID = -1238648891315061482L;

	@OneToMany(mappedBy = "customer", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@OrderBy("id")
	private Set<Address> addresses;

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
