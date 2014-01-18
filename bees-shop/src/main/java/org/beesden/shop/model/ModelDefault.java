package org.beesden.shop.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;

@MappedSuperclass
public class ModelDefault implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "createdBy")
	private String createdBy;

	@Column(name = "dateCreated")
	private Date dateCreated;

	@Id
	@Column(name = "ID")
	@GeneratedValue
	private Integer id;

	@Column(name = "lastEdited")
	private Date lastEdited;

	@Column(name = "lastEditedBy")
	private String lastEditedBy;

	@Column(name = "name")
	private String name;

	@NotNull
	@Column(name = "status")
	private Integer status;

	// Getters and Setters

	public String getCreatedBy() {
		return createdBy;
	}

	public Date getDateCreated() {
		return dateCreated;
	}

	public Integer getId() {
		return id;
	}

	public Date getLastEdited() {
		return lastEdited;
	}

	public String getLastEditedBy() {
		return lastEditedBy;
	}

	public String getName() {
		return name;
	}

	public Integer getStatus() {
		return status;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setLastEdited(Date lastEdited) {
		this.lastEdited = lastEdited;
	}

	public void setLastEditedBy(String lastEditedBy) {
		this.lastEditedBy = lastEditedBy;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
}
