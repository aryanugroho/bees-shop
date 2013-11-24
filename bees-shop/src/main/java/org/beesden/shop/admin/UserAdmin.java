package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.User;
import org.beesden.utils.Utils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class UserAdmin extends Admin {

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show administrator login page");

		logger.debug("Getting url information");
		model.addAttribute("url", Utils.getUrl(request));

		return "admin.login";
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String userSingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show user form");
		
		// Get new or existing user if requested
		User user = new User();
		if (request.getParameter("id") != null) {
			String dbQuery = userService.getQuery(request.getParameter("id"), null, null, null);
			user = userService.findOne(dbQuery);
		}
		
		// Update model
		model = adminTemplate(model, request, "admin", "user");
		model.addAttribute("user", user);
		return "admin.formUser";
	}	

	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of users");
		
		// Check if list requires sorting and archived
		String archive = request.getParameter("archived");
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "id";
		}
		
		// Get user list from database
		List<User> itemList = new ArrayList<User>();
		String dbQuery = userService.getQuery(null, null, archive != null ? null : 0, sort);
		itemList = userService.findAll(dbQuery);
		
		// Update model
		model = adminTemplate(model, request, "admin", "user");
		model.addAttribute("itemList", itemList);
		return "admin.adminList";
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.POST)
	public String userSingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute("user") User user, BindingResult result) {
		logger.info("Submitting requested user");

		String message = "An error has occured whislt updating that user";
		
		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = adminTemplate(model, request, "admin", "variant");
			return "admin.formVariant";
		} else {		
			
			// Store the password securely in the database
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			String hashedPassword = passwordEncoder.encode(user.getPassword());
			user.setPassword(hashedPassword);
			
			// Add / Update user
			if (user.getId() == null) {
				user.setCreatedBy(fetchAdminUser().getName());
				user.setDateCreated(new Date());
				userService.objectCreate(user);
				message = user.getName() + " created";
			} else {
				user.setLastEditedBy(fetchAdminUser().getName());
				user.setLastEdited(new Date());
				userService.objectUpdate(user);
				message = user.getName() + " updated";
			}
			logger.info(message);
			request.getSession().setAttribute("message", message);
	
			// Redirect to user list user
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/userList";
			}
			return "redirect:" + redirect;
		}
	}

	@RequestMapping(value = "/userList", method = RequestMethod.POST)
	public String userListUpdate(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to update list of users");

		String message = "An error has occured";

		// Update selected users
		String status = request.getParameter("statusUpdate");
		String[] ids = request.getParameterValues("update");
		for (String id : ids) {
			String dbQuery = userService.getQuery(id, null, null, null);
			User user = userService.findOne(dbQuery);
			user.setStatus(Integer.parseInt(status));
			userService.objectUpdate(user);
			logger.debug("User " + id + " " + status + "d");
		}
		message = "Selected users have been updated";

		logger.info(message);
		request.getSession().setAttribute("message", message);

		String redirect = request.getParameter("return");
		if (redirect == null) {
			redirect = "/admin/userList";
		}
		return "redirect:" + redirect;
	}

}