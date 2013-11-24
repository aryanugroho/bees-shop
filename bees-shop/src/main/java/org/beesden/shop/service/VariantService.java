package org.beesden.shop.service;

import org.beesden.shop.model.Variant;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class VariantService extends Service<Variant> {

	public VariantService() {
		super(Variant.class.getName());
	}
}
