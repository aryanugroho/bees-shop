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

	public String getQueryCustomer(String addressId, String customerId, Integer status) {
		// Generate dbQuery string
		String dbSearch = " WHERE " + getStatus("p", status);
		if (addressId != null && !addressId.isEmpty()) {
			dbSearch += " AND p.id = " + addressId;
		}
		if (customerId != null && !customerId.isEmpty()) {
			dbSearch += " AND p.customer.id = '" + customerId + "'";
		}
		return dbSearch;
	}
}
