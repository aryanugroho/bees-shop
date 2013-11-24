package org.beesden.shop.model;

import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "bees_category")
public class Category extends ModelContent {

	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "categories")
	private List<Product> products;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "parent")
	private List<Category> children;

	@ManyToOne(fetch = FetchType.LAZY)
	private Category parent;

	@Column(name = "sortOrder")
	private String sortOrder;
	
	// Getters and Setters

	public List<Product> getProducts() {
		return products;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public Category getParent() {
		return parent;
	}

	public void setParents(Category parent) {
		this.parent = parent;
	}

	public List<Category> getChildren() {
		return children;
	}

	public void setChildren(List<Category> children) {
		this.children = children;
	}

}
