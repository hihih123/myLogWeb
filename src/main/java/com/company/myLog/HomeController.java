package com.company.myLog;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "home";
	}
	
	@RequestMapping(value = "/monitor/{macAddr}", method = RequestMethod.GET)
	public String monitor(@PathVariable String macAddr, Model model) {
		
		model.addAttribute("macAddr", macAddr);
		
		return "monitor";
	}
	
}
