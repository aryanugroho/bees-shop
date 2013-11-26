package org.beesden.shop.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;

public class View extends ViewServices {

	public ModelMap setTitle(ModelMap model, String pageType, String pageTitle) {
		// Set page type and title
		model.addAttribute("pageType", pageType);
		model.addAttribute("pageTitle", pageTitle);
		return model;
	}

	public ModelMap storeTemplate(ModelMap model, HttpServletRequest request) {
		// Add any system messages");
		model.addAttribute("messages", request.getSession().getAttribute("messages"));
		request.getSession().setAttribute("messages", null);
		return model;
	}
}