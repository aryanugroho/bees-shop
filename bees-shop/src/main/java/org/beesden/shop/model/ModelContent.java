package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import org.hibernate.validator.constraints.NotEmpty;

@MappedSuperclass
public abstract class ModelContent extends ModelDefault {
	private static final long serialVersionUID = 1L;

	@Column(name = "customStyles", columnDefinition = "TEXT")
	private String customStyles;

	@Column(name = "description", columnDefinition = "TEXT")
	private String description;

	@NotEmpty
	@Column(name = "heading", length = 150)
	private String heading;

	@Transient
	private Integer promotionId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "promotionId")
	private Category promotionList;

	@Column(name = "seoDescription", length = 180)
	private String seoDescription;

	@Column(name = "seoTitle", length = 80)
	private String seoTitle;

	// Getters and Setters

	public String getCustomStyles() {
		return customStyles;
	}

	public String getDescription() {
		return description;
	}

	public String getHeading() {
		return heading;
	}

	public Integer getPromotionId() {
		return promotionId;
	}

	public Category getPromotionList() {
		return promotionList;
	}

	public String getSeoDescription() {
		return seoDescription;
	}

	public String getSeoTitle() {
		return seoTitle;
	}

	public void setCustomStyles(String customStyles) {
		this.customStyles = customStyles;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setHeading(String heading) {
		this.heading = heading;
	}

	public void setPromotionId(Integer promotionId) {
		this.promotionId = promotionId;
	}

	public void setPromotionList(Category promotionList) {
		this.promotionList = promotionList;
	}

	public void setSeoDescription(String seoDescription) {
		this.seoDescription = seoDescription;
	}

	public void setSeoTitle(String seoTitle) {
		this.seoTitle = seoTitle;
	}
}
