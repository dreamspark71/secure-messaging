package com.securemessaging.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MessageController {

	@RequestMapping("/")
	public String showHome(Model model) {
		
		return "messagepanel";
	}
}
