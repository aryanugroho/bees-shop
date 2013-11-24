package org.beesden.shop.service;

import org.beesden.shop.model.Address;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class AddressService extends Service<Address> {

	public AddressService() {
		super("Address");
	}
}
