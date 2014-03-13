package org.beesden.shop.service;

import org.beesden.shop.model.Tender;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class TenderService extends Service<Tender> {

	public TenderService() {
		super(Tender.class.getName());
	}

	public String getQueryCustomer(String tenderId, String customerId, Integer status) {
		// Generate dbQuery string
		String dbSearch = " WHERE " + getStatus("p", status);
		if (tenderId != null && !tenderId.isEmpty()) {
			dbSearch += " AND p.id = " + tenderId;
		}
		if (customerId != null && !customerId.isEmpty()) {
			dbSearch += " AND p.customer.id = '" + customerId + "'";
		}
		return dbSearch;
	}
}
