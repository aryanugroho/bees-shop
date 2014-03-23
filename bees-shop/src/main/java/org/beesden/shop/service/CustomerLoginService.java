package org.beesden.shop.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.beesden.shop.model.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public class CustomerLoginService implements UserDetailsService {

	protected static Logger logger = Logger.getLogger("service");

	@Autowired
	private CustomerService customerService;

	@Override
	public UserDetails loadUserByUsername(String username) {

		logger.info("Checking for customer login");

		UserDetails user = null;

		try {
			Customer customer = customerService.findOne(" WHERE email = '" + username + "'");
			List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);
			authList.add(new SimpleGrantedAuthority("ROLE_CUSTOMER"));
			user = new User(customer.getEmail(), customer.getPassword(), true, true, true, true, authList);
		} catch (Exception e) {
			logger.error("Error in retrieving customer");
			throw new UsernameNotFoundException("Error in retrieving customer");
		}
		return user;
	}
}