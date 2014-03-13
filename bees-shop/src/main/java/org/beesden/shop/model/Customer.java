package org.beesden.shop.model;

import java.util.Set;

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

	@OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
	@OrderBy("id")
	private Set<Address> addresses;

	@Column(name = "password", length = 150)
	private String password;

	@OneToMany(mappedBy = "customer", fetch = FetchType.EAGER)
	@OrderBy("id")
	private Set<Tender> tenders;

	// Getters and Setters

	public Set<Address> getAddresses() {
		return addresses;
	}

	public String getPassword() {
		return password;
	}

	public Set<Tender> getTenders() {
		return tenders;
	}

	public void setAddresses(Set<Address> addresses) {
		this.addresses = addresses;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setTenders(Set<Tender> tenders) {
		this.tenders = tenders;
	}

}
