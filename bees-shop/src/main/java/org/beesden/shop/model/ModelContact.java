package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

@Entity
@Table(name = "bees_address")
public class ModelContact extends ModelDefault {

	@Email
	@Size(min = 2, max = 35)
	@Column(name = "email", length = 35)
	private String email;

	@Size(min = 2, max = 150)
	@Column(name = "firstname", length = 150)
	private String firstname;

	@Size(min = 2, max = 150)
	@Column(name = "surname", length = 150)
	private String surname;

	@Range(min=9, max=35)
	@Column(name = "telephone", length = 35)
	private String telephone;
	
	@Range(min=2, max=50)	
	@Column(name = "title", length = 50)
	private String title;
	
	// Getters and Setters

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
}
