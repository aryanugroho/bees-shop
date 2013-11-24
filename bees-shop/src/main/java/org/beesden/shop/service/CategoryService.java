package org.beesden.shop.service;

import org.beesden.shop.model.Category;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CategoryService extends Service<Category> {

	public CategoryService() {
		super(Category.class.getName());
	}
}
