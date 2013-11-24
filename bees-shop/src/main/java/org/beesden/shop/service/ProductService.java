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
}
