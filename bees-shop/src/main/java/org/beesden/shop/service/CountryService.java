package org.beesden.shop.service;

import org.beesden.shop.model.Country;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@SuppressWarnings("unchecked")
@Repository
@Transactional
public class CountryService extends Service<Country> {

	public CountryService() {
		super(Country.class.getName());
	}

	public Country getCountry(String code) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM " + tableName + " WHERE iso2 = '" + code + "'");
		return (Country) query.setMaxResults(1).uniqueResult();
	}
}
