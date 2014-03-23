package org.beesden.shop.service;

import org.beesden.shop.model.Product;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class ProductService extends Service<Product> {

	public ProductService() {
		super(Product.class.getName());
	}

	public String getQuerySearch(String keywords, String sort) {
		String dbQuery = " JOIN p.variants v WHERE (";
		String[] searches = keywords.split("[ _-]");
		for (int i = 0; i < searches.length; i++) {
			dbQuery += (i == 0 ? "" : " OR ") + "p.heading LIKE '%" + searches[i] + "%' OR v.name LIKE '%" + searches[i] + "%'";
		}
		dbQuery += ") AND " + getStatus("p", 1);
		if (sort != null && !sort.isEmpty()) {
			dbQuery += " ORDER BY " + (sort.startsWith("price") ? "v." : "p.") + sort.replaceAll("_", " ");
		}
		return dbQuery;
	}
}
