package org.beesden.shop.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Product;
import org.beesden.shop.model.User;
import org.beesden.shop.model.Variant;
import org.beesden.shop.service.UserService;
import org.beesden.shop.view.Pagination;
import org.beesden.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

public class Admin extends Pagination {

	@Autowired
	public UserService userService;

	/** Generic admin information, such as url, order count */
	public ModelMap adminTemplate(ModelMap model, HttpServletRequest request, String category, String pageType) {

		// Add current user information to request
		model.addAttribute("adminUser", fetchAdminUser());

		// Add url information to request
		/** TODO move to js logic */
		model.addAttribute("url", Utils.getUrl(request));

		// Add messaging to request
		/** TODO move to session object */
		String message = (String) request.getSession().getAttribute("message");
		model.addAttribute("message", message);
		if (message != null) {
			request.getSession().setAttribute("message", "");
		}

		// Configure admin page information
		/** TODO move to session object */
		Map<String, String> pageMap = new HashMap<String, String>();
		pageMap.put("category", category);
		pageMap.put("type", pageType.toLowerCase());
		pageMap.put("url", pageType.replace(" ", "")); // ?
		model.addAttribute("page", pageMap);

		return model;
	}

	/** Required for form submission */
	@InitBinder
	private void dateBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		CustomDateEditor editor = new CustomDateEditor(dateFormat, true);
		binder.registerCustomEditor(Date.class, editor);
	}

	/** Get current user information */
	public User fetchAdminUser() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User user = new User();
		if (auth.isAuthenticated()) {
			String dbQuery = userService.getQuery(null, auth.getName(), null, null);
			user = userService.findOne(dbQuery);
		}
		logger.debug("Currently logged in user: " + user.getId() + " - " + user.getName());
		return user;
	}

	/** Add additional elements to admin forms if necessary */
	public ModelMap fetchPanelData(ModelMap model, int categories, int products, int pages, int users) {

		// Generic query used to get all items (not archived) and ordered by name
		String dbQuery = categoryService.getQuery(null, null, 0, "name");

		if (categories == 1) {
			logger.debug("Fetching list of unarchived categories");
			model.addAttribute("categoryList", categoryService.findAll(dbQuery));
		}

		if (products == 1) {
			logger.debug("Fetching list of unarchived products");
			model.addAttribute("productList", productService.findAll(dbQuery));
		}

		if (pages == 1) {
			logger.debug("Fetching list of unarchived pages");
			model.addAttribute("pageList", pageService.findAll(dbQuery));
		}

		if (users == 1) {
			logger.debug("Fetching list of unarchived users");
			model.addAttribute("userList", userService.findAll(dbQuery));
		}

		return model;
	}

	/** Get list of variants */
	public List<Variant> getVariants(Product product) {
		logger.debug("Checking product has at least one variant");

		List<Variant> variants = new ArrayList<Variant>();

		// Get existing variants if available
		if (product.getId() != null) {
			String dbQuery = productService.getQuery(product.getId().toString(), null, null, null);
			Product original = productService.findOne(dbQuery);
			if (original != null) {
				variants = original.getVariants();
			}
		}

		// Add variant if list is empty
		if (variants.isEmpty()) {
			Variant variant = new Variant();
			variant.setHeading(product.getHeading());
			variant.setPrice(new Double(4.99));
			variant.setStatus(1);
			variant.setStock(-1);
			variants.add(variant);
			product.setVariants(variants);
		}

		return variants;
	};
}