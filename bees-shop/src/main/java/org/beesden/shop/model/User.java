package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bees_user")
public class User extends ModelDefault {
	private static final long serialVersionUID = 1L;

	@Column(name = "authority")
	private Integer authority;

	@Column(name = "password")
	private String password;

	// Getters and Setters

	public Integer getAuthority() {
		return authority;
	}

	public String getPassword() {
		return password;
	}

	public void setAuthority(Integer authority) {
		this.authority = authority;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
