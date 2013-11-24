package org.beesden.shop.service;

import org.beesden.shop.model.Page;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class PageService extends Service<Page> {

	public PageService() {
		super(Page.class.getName());
	}
}
