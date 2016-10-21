package com.websystique.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class IndexController {

	  @RequestMapping(value="/users", method = RequestMethod.GET)
	    public String getUserPage() {
	        return "UserManagement";
	    }
	  
	  @RequestMapping(value="/contacts", method = RequestMethod.GET)
	    public String getContactPage() {
	        return "ContactManagement";
	    }

}