package org.beesden.shop.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name = "bees_menu")
public class Menu extends ModelDefault {

	@OneToOne
	@JoinColumn(name = "categoryId")
	private Category category;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "menu")
	@OrderBy("position")
	private Set<Menu> children;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "parentId")
	private Menu menu;

	@OneToOne
	@JoinColumn(name = "pageId")
	private Page page;

	@Column(name = "position")
	private Integer position;

	public Category getCategory() {
		return category;
	}

	public Set<Menu> getChildren() {
		return children;
	}

	public Menu getMenu() {
		return menu;
	}

	public Page getPage() {
		return page;
	}

	public Integer getPosition() {
		return position;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public void setChildren(Set<Menu> children) {
		this.children = children;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public void setPosition(Integer position) {
		this.position = position;
	}

}