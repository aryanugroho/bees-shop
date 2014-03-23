package org.beesden.shop.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public class AdminLoginService implements UserDetailsService {

	protected static Logger logger = Logger.getLogger("service");

	@Autowired
	private UserService userService;

	public Collection<GrantedAuthority> getAuthorities(Integer access) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);
		authList.add(new SimpleGrantedAuthority("ROLE_USER"));
		if (access.compareTo(2) == 0) {
			authList.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		} else if (access.compareTo(1) == 0) {
			authList.add(new SimpleGrantedAuthority("ROLE_MANAGER"));
		}
		return authList;
	}

	@Override
	public UserDetails loadUserByUsername(String username) {

		logger.info("Checking for admin user login");

		UserDetails user = null;

		try {
			String dbQuery = userService.getQuery(null, username, 1, null);
			org.beesden.shop.model.User dbUser = userService.findOne(dbQuery);
			user = new User(dbUser.getName(), dbUser.getPassword(), true, true, true, true, getAuthorities(dbUser.getAuthority()));
		} catch (Exception e) {
			logger.error("Error in retrieving user");
			throw new UsernameNotFoundException("Error in retrieving user");
		}
		return user;
	}
}