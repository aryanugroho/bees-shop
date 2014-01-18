package org.beesden.shop.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "bees_variant")
public class Variant extends ModelContent {
	private static final long serialVersionUID = 1L;

	@NotNull
	@Min(0)
	@Column(name = "price")
	private Double price;

	@ManyToOne
	@JoinColumn(name = "productId")
	private Product product;

	@Transient
	private Integer productId;

	@NotNull
	@Column(name = "stock", columnDefinition = "int default -1")
	private Integer stock;

	// Getters and Setters

	public Double getPrice() {
		return price;
	}

	public Product getProduct() {
		return product;
	}

	public Integer getProductId() {
		return productId;
	}

	public Integer getStock() {
		return stock;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}
}
