package org.beesden.shop.service;

import org.beesden.shop.model.User;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class UserService extends Service<User> {

	public UserService() {
		super(User.class.getName());
	}
}
