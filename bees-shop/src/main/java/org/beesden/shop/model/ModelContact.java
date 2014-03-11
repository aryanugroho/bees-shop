package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import org.hibernate.validator.constraints.Email;

@MappedSuperclass
public abstract class ModelContact extends ModelDefault {
	private static final long serialVersionUID = 1L;

	@Email
	@Column(name = "email", length = 35)
	private String email;

	@Column(name = "firstname", length = 150)
	private String firstname;

	@Column(name = "surname", length = 150)
	private String surname;

	@Column(name = "telephone", length = 35)
	private String telephone;

	@Column(name = "title", length = 50)
	private String title;

	// Getters and Setters

	public String getEmail() {
		return email;
	}

	public String getFirstname() {
		return firstname;
	}

	public String getSurname() {
		return surname;
	}

	public String getTelephone() {
		return telephone;
	}

	public String getTitle() {
		return title;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
