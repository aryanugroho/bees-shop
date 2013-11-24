package org.beesden.shop.service;

import org.beesden.shop.model.Customer;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class CustomerService extends Service<Customer> {

	public CustomerService() {
		super(Customer.class.getName());
	}
}
