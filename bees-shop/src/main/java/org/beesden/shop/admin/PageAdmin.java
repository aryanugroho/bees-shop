package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class PageAdmin extends Admin {

	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public String pageSingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show page form");
		
		// Get new or existing page if requested
		Page page = new Page();
		if (request.getParameter("id") != null) {
			String dbQuery = pageService.getQuery(request.getParameter("id"), null, null, null);
			page = pageService.findOne(dbQuery);
		}
		
		// Update model
		model = fetchPanelData(model, 1, 0, 0, 0);
		model = adminTemplate(model, request, "admin", "page");
		model.addAttribute("page", page);
		return "admin.formPage";
	}	

	@RequestMapping(value = "/pageList", method = RequestMethod.GET)
	public String pageList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of pages");
		
		// Check if list requires sorting and archived
		String archive = request.getParameter("archived");
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "id";
		}
		
		// Get page list from database
		List<Page> itemList = new ArrayList<Page>();
		String dbQuery = pageService.getQuery(null, null, archive != null ? null : 0, sort);
		itemList = pageService.findAll(dbQuery);
		
		// Update model
		model = adminTemplate(model, request, "admin", "page");
		model.addAttribute("itemList", itemList);
		return "admin.adminList";
	}
	
	@RequestMapping(value = "/page", method = RequestMethod.POST)
	public String pageSingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute("page") Page page, BindingResult result) {
		logger.info("Submitting requested page");

		String message = "An error has occured whislt updating that page";
		
		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = fetchPanelData(model, 1, 0, 0, 0);
			model = adminTemplate(model, request, "admin", "variant");
			return "admin.formVariant";
		} else {
			
			// Get promotional category
			if (page.getPromotionId() != null) {
				String dbQuery = categoryService.getQuery(page.getPromotionId().toString(), null, 0, null);
				page.setPromotionList(categoryService.findOne(dbQuery));
			}		
		
			// Add / Update page
			if (page.getId() == null) {
				page.setCreatedBy(fetchAdminUser().getName());
				page.setDateCreated(new Date());
				pageService.objectCreate(page);
				message = page.getName() + " created";
			} else {
				page.setLastEditedBy(fetchAdminUser().getName());
				page.setLastEdited(new Date());
				pageService.objectUpdate(page);
				message = page.getName() + " updated";
			}
			logger.info(message);
			request.getSession().setAttribute("message", message);
	
			// Redirect to page list page
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/pageList";
			}
			return "redirect:" + redirect;
		}
	}

	@RequestMapping(value = "/pageList", method = RequestMethod.POST)
	public String pageListUpdate(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to update list of pages");

		String message = "An error has occured";

		// Update selected pages
		String status = request.getParameter("statusUpdate");
		String[] ids = request.getParameterValues("update");
		for (String id : ids) {
			String dbQuery = pageService.getQuery(id, null, null, null);
			Page page = pageService.findOne(dbQuery);
			page.setStatus(Integer.parseInt(status));
			pageService.objectUpdate(page);
			logger.debug("Page " + id + " " + status + "d");
		}
		message = "Selected pages have been updated";

		logger.info(message);
		request.getSession().setAttribute("message", message);

		String redirect = request.getParameter("return");
		if (redirect == null) {
			redirect = "/admin/pageList";
		}
		return "redirect:" + redirect;
	}

}