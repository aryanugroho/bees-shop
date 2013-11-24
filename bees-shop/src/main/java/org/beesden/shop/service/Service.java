package org.beesden.shop.service;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
@SuppressWarnings("unchecked")
public class Service<T> {

	@Autowired
	protected SessionFactory sessionFactory;

	public String tableName;

	public Service() {
	}

	public Service(String tableName) {
		this.tableName = tableName;
	}

	public Integer count(String dbQuery) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("SELECT COUNT(*) FROM " + tableName + " p " + dbQuery);
		return (Integer) query.uniqueResult();
	}

	public T findOne(String dbQuery) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM " + tableName + " p " + dbQuery);
		return (T) query.setMaxResults(1).uniqueResult();
	}

	public List<T> findAll(String dbQuery) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("FROM " + tableName + " p " + dbQuery);
		return query.list();
	}

	protected String getStatus(String s, Integer status) {
		s += ".status";
		status = status == null ? -1 : status;
		if (status == 0) {
			s = s + " = 1 OR " + s + " = 2";
		} else if (status > 0) {
			s = s + " = " + status;
		} else {
			s =  s + " > 0";
		}
		return " (" + s + ")" ;
	}

	public void objectCreate(T o) {
		// Create new object
		Session session = sessionFactory.getCurrentSession();
		session.save(o);
		session.flush();
	}

	public void objectRemove(T o) {
		// Delete existing object
		Session session = sessionFactory.getCurrentSession();
		session.delete(o);
	}

	public void objectUpdate(T o) {
		// Update existing object
		Session session = sessionFactory.getCurrentSession();
		session.merge(o);
		session.flush();
	}

	public String getQuery(String id, String name, Integer status, String sort) {
		// Generate dbQuery string
		String dbSearch = " WHERE " + getStatus("p", status);
		if (id != null && !id.isEmpty()) {
			dbSearch += " AND p.id = " + id;
		}
		if (name != null && !name.isEmpty()) {
			dbSearch += " AND p.name = '" + name + "'";
		}
		if (sort != null && !sort.isEmpty()) {
			dbSearch += " ORDER BY p." + sort;
		}
		return dbSearch;
	}
	
	public String getQueryJoin(String dbQuery, String link, String id, Integer status, String sort) {
		String dbSearch = "  LEFT OUTER JOIN p." + link + " c " + dbQuery +  " AND " + getStatus("c", status);
		if (id != null && !id.isEmpty()) {
			dbSearch += " AND c.id = " + id;
		}
		if (sort != null && !sort.isEmpty()) {
			dbSearch += " ORDER BY " + sort;
		}
		return dbSearch;
	}
}
