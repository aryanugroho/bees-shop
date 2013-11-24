package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.Category;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class CategoryAdmin extends Admin {

	@RequestMapping(value = "/category", method = RequestMethod.GET)
	public String categorySingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show category form");
		
		// Get new or existing category if requested
		Category category = new Category();
		if (request.getParameter("id") != null) {
			String dbQuery = categoryService.getQuery(null, request.getParameter("id"), null, null);
			category = categoryService.findOne(dbQuery);
		}
		
		// Update model
		model = fetchPanelData(model, 1, 0, 0, 0);
		model = adminTemplate(model, request, "admin", "category");
		model.addAttribute("category", category);
		return "admin.formCategory";
	}	

	@RequestMapping(value = "/categoryList", method = RequestMethod.GET)
	public String categoryList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of categories");
		
		// Check if list requires sorting and archived
		String archive = request.getParameter("archived");
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "id";
		}
		
		// Get category list from database
		List<Category> itemList = new ArrayList<Category>();
		String dbQuery = categoryService.getQuery(null, null, archive != null ? null : 0, sort);
		itemList = categoryService.findAll(dbQuery);
		
		// Update model
		model = adminTemplate(model, request, "admin", "category");
		model.addAttribute("itemList", itemList);
		return "admin.adminList";
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.POST)
	public String categorySingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute("category") Category category, BindingResult result) {
		logger.info("Submitting requested category");

		String message = "An error has occured whislt updating that category";
		
		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = fetchPanelData(model, 1, 0, 0, 0);
			model = adminTemplate(model, request, "admin", "variant");
			return "admin.formVariant";
		} else {		
			
			// Get promotional category
			if (category.getPromotionId() != null) {
				String dbQuery = categoryService.getQuery(category.getPromotionId().toString(), null, 0, null);
				category.setPromotionList(categoryService.findOne(dbQuery));
			}		
		
			// Add / Update category
			if (category.getId() == null) {
				category.setCreatedBy(fetchAdminUser().getName());
				category.setDateCreated(new Date());
				categoryService.objectCreate(category);
				message = category.getName() + " created";
			} else {
				category.setLastEditedBy(fetchAdminUser().getName());
				category.setLastEdited(new Date());
				categoryService.objectUpdate(category);
				message = category.getName() + " updated";
			}
			logger.info(message);
			request.getSession().setAttribute("message", message);
	
			// Redirect to category list page
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/categoryList";
			}
			return "redirect:" + redirect;
		}
	}

	@RequestMapping(value = "/categoryList", method = RequestMethod.POST)
	public String categoryListUpdate(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to update list of categories");

		String message = "An error has occured";

		// Update selected categories
		String status = request.getParameter("statusUpdate");
		String[] ids = request.getParameterValues("update");
		for (String id : ids) {
			String dbQuery = categoryService.getQuery(id, null, null, null);
			Category category = categoryService.findOne(dbQuery);
			category.setStatus(Integer.parseInt(status));
			categoryService.objectUpdate(category);
			logger.debug("Category " + id + " " + status + "d");
		}
		message = "Selected categories have been updated";

		logger.info(message);
		request.getSession().setAttribute("message", message);

		String redirect = request.getParameter("return");
		if (redirect == null) {
			redirect = "/admin/categoryList";
		}
		return "redirect:" + redirect;
	}

}