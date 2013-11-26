package org.beesden.shop.model;

import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "bees_category")
public class Category extends ModelContent {

	@Transient
	private String categoryChildren;

	@Transient
	private String categoryParents;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "bees_category_hierarchy", joinColumns = @JoinColumn(name = "parentId"), inverseJoinColumns = @JoinColumn(name = "childId"))
	private Set<Category> children;

	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "bees_category_hierarchy", joinColumns = @JoinColumn(name = "childId"), inverseJoinColumns = @JoinColumn(name = "parentId"))
	private Set<Category> parents;

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "categories")
	private List<Product> products;

	@Column(name = "sortOrder")
	private String sortOrder;

	// Getters and Setters

	public String getCategoryChildren() {
		return categoryChildren;
	}

	public String getCategoryParents() {
		return categoryParents;
	}

	public Set<Category> getChildren() {
		return children;
	}

	public Set<Category> getParents() {
		return parents;
	}

	public List<Product> getProducts() {
		return products;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setCategoryChildren(String categoryChildren) {
		this.categoryChildren = categoryChildren;
	}

	public void setCategoryParents(String categoryParents) {
		this.categoryParents = categoryParents;
	}

	public void setChildren(Set<Category> children) {
		this.children = children;
	}

	public void setParents(Set<Category> parents) {
		this.parents = parents;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

}
