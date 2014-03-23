package org.beesden.shop.service;

import org.beesden.shop.model.Category;
import org.beesden.shop.model.Variant;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CategoryService extends Service<Category> {

	public CategoryService() {
		super(Category.class.getName());
	}

	@Override
	public String getQueryPaged(String link, String id, Integer status, String sort) {
		String dbQuery = " JOIN p.categories c JOIN p.variants v WHERE c.id = " + id + " AND v.product.id = p.id AND " + getStatus("p", status);
		if (sort != null && !sort.isEmpty()) {			
			dbQuery += "ORDER BY " + (sort.startsWith("price") ? "v." : "p.") + sort.replaceAll("_", " ");
		}
		return dbQuery;
	}
}
