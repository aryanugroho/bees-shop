package org.beesden.shop.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class DashboardAdmin extends Admin {

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String showDashboard(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show administration dashboard");
		model = adminTemplate(model, request, "admin", "dashboard");
		return "admin.adminHome";
	}
	
}