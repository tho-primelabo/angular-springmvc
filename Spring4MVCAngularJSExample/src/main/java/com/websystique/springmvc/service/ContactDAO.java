package com.websystique.springmvc.service;

import java.util.List;

import com.websystique.springmvc.model.Contact;

/**
 * Defines DAO operations for the contact model.
 * @author www.codejava.net
 *
 */
public interface ContactDAO {
	
	void saveOrUpdate(Contact contact);
	
	void delete(int contactId);
	void deleteAll();
	
	Contact get(int contactId);
	
	List<Contact> list();
}
