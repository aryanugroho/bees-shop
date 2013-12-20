package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.Config;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class ConfigAdmin extends Admin {

	@RequestMapping(value = "/configList", method = RequestMethod.GET)
	public String configList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of configs");

		// Check if list requires sorting and archived
		String sort = request.getParameter("sort");
		String dbQuery = " ORDER BY p." + (sort == null ? "name" : sort);

		// Get category list from database
		List<Config> itemList = new ArrayList<Config>();
		itemList = configService.findAll(dbQuery);

		// Update model
		model = adminTemplate(model, request, "admin", "config");
		model.addAttribute("itemList", itemList);
		return "admin.configList";
	}

	@RequestMapping(value = "/config", method = RequestMethod.GET)
	public String configSingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show config form");

		// Get new or existing config if requested
		Config config = new Config();
		if (request.getParameter("id") != null) {
			config = configService.findOne("WHERE id = " + request.getParameter("id"));
		}

		// Update model
		model = adminTemplate(model, request, "admin", "config");
		model.addAttribute("config", config);
		return "admin.formConfig";
	}

	@RequestMapping(value = "/config", method = RequestMethod.POST)
	public String configSingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute("config") Config config, BindingResult result) {
		logger.info("Submitting requested config");

		String message = "An error has occured whislt updating that config";

		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = adminTemplate(model, request, "admin", "config");
			return "admin.formConfig";
		} else {

			// Add / Update config
			if (config.getId() == null) {
				config.setCreatedBy(fetchAdminUser().getName());
				config.setDateCreated(new Date());
				configService.objectCreate(config);
				message = config.getName() + " created";
			} else {
				config.setLastEditedBy(fetchAdminUser().getName());
				config.setLastEdited(new Date());
				configService.objectUpdate(config);
				message = config.getName() + " updated";
			}

			logger.info(message);
			request.getSession().setAttribute("message", message);

			// Redirect to config list page
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/configList";
			}
			return "redirect:" + redirect;
		}
	}

}