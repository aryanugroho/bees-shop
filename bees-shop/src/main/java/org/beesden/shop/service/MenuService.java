package org.beesden.shop.service;

import org.beesden.shop.model.Menu;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class MenuService extends Service<Menu> {

	public MenuService() {
		super(Menu.class.getName());
	}
}
