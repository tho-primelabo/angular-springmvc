package com.websystique.springmvc.controller;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import com.websystique.springmvc.model.Contact;
import com.websystique.springmvc.service.ContactDAO;

 
@RestController
//@RequestMapping("/info")
public class ContactRestController {
 
    @Autowired
    ContactDAO contactService;  //Service which will do all data retrieval/manipulation work
 
    @RequestMapping("/contacts")
	public String home() {
 		return "ContactManagement";
 	}
    
    //-------------------Retrieve All Contacts--------------------------------------------------------
     
    @RequestMapping(value = "/contact/", method = RequestMethod.GET)
    public ResponseEntity<List<Contact>> listAllContacts() {
    	  System.out.println("Fetching All Contacts ");
        List<Contact> Contacts = contactService.list();
        if(Contacts.isEmpty()){
            return new ResponseEntity<List<Contact>>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
        }
        return new ResponseEntity<List<Contact>>(Contacts, HttpStatus.OK);
    }
 
 
    
    //-------------------Retrieve Single Contact--------------------------------------------------------
     
    @RequestMapping(value = "/contact/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Contact> getContact(@PathVariable("id") int id) {
        System.out.println("Fetching Contact with id " + id);
        Contact contact = contactService.get(id);
        if (contact == null) {
            System.out.println("Contact with id " + id + " not found");
            return new ResponseEntity<Contact>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Contact>(contact, HttpStatus.OK);
    }
 
     
     
    //-------------------Create a Contact--------------------------------------------------------
     
    @RequestMapping(value = "/contact/", method = RequestMethod.POST)
    public ResponseEntity<Void> createContact(@RequestBody Contact contact,    UriComponentsBuilder ucBuilder) {
        System.out.println("Creating Contact " + contact.getName());
 
        if (contactService.get(contact.getId())!= null) {
            System.out.println("A Contact with name " + contact.getName() + " already exist");
            return new ResponseEntity<Void>(HttpStatus.CONFLICT);
        }
 
        contactService.saveOrUpdate(contact);
 
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/contact/{id}").buildAndExpand(contact.getId()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
 
    
     
    //------------------- Update a Contact --------------------------------------------------------
     
    @RequestMapping(value = "/contact/{id}", method = RequestMethod.PUT)
    public ResponseEntity<Contact> updateContact(@PathVariable("id") int id, @RequestBody Contact Contact) {
        System.out.println("Updating Contact " + id);
         
        Contact currentContact = contactService.get(id);
         
        if (currentContact==null) {
            System.out.println("Contact with id " + id + " not found");
            return new ResponseEntity<Contact>(HttpStatus.NOT_FOUND);
        }
 
        currentContact.setName(Contact.getName());
        currentContact.setAddress(Contact.getAddress());
        currentContact.setEmail(Contact.getEmail());
         
        contactService.saveOrUpdate(currentContact);
        return new ResponseEntity<Contact>(currentContact, HttpStatus.OK);
    }
 
    
    
    //------------------- Delete a Contact --------------------------------------------------------
     
    @RequestMapping(value = "/contact/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Contact> deleteContact(@PathVariable("id") int id) {
        System.out.println("Fetching & Deleting Contact with id " + id);
 
        Contact Contact = contactService.get(id);
        if (Contact == null) {
            System.out.println("Unable to delete. Contact with id " + id + " not found");
            return new ResponseEntity<Contact>(HttpStatus.NOT_FOUND);
        }
 
        contactService.delete(id);
        return new ResponseEntity<Contact>(HttpStatus.NO_CONTENT);
    }
 
     
    
    //------------------- Delete All Contacts --------------------------------------------------------
     
    @RequestMapping(value = "/contact/", method = RequestMethod.DELETE)
    public ResponseEntity<Contact> deleteAllContacts() {
        System.out.println("Deleting All Contacts");
 
        contactService.deleteAll();
        return new ResponseEntity<Contact>(HttpStatus.NO_CONTENT);
    }
 
}