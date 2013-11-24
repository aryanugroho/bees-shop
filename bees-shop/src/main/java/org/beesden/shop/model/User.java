package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bees_user")
public class User extends ModelDefault {

	@Column(name = "password")
	private String password;

	@Column(name = "authority")
	private Integer authority;
	
	// Getters and Setters

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getAuthority() {
		return authority;
	}

	public void setAuthority(Integer authority) {
		this.authority = authority;
	}
}
