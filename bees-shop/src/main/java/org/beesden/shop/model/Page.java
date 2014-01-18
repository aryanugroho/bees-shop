package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "bees_page")
public class Page extends ModelContent {
	private static final long serialVersionUID = 1L;

	@Column(name = "contactPanel", columnDefinition = "BIT", length = 1)
	private Boolean contactPanel;

	// Getters and Setters

	public Boolean getContactPanel() {
		return contactPanel;
	}

	public void setContactPanel(Boolean contactPanel) {
		this.contactPanel = contactPanel;
	}
}
