package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.Category;
import org.beesden.shop.model.Product;
import org.beesden.utils.Utils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class ProductAdmin extends Admin {

	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of products");

		// Check if list requires sorting and archived
		String archive = request.getParameter("archived");
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "id";
		}

		// Get product list from database
		List<Product> itemList = new ArrayList<Product>();
		String dbQuery = productService.getQuery(null, null, archive != null ? null : 0, sort);
		itemList = productService.findAll(dbQuery);

		// Update model
		model = adminTemplate(model, request, "admin", "product");
		model.addAttribute("itemList", itemList);
		return "admin.adminList";
	}

	@RequestMapping(value = "/productList", method = RequestMethod.POST)
	public String productListUpdate(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to update list of products");

		String message = "An error has occured";

		// Update selected products
		String status = request.getParameter("statusUpdate");
		String[] ids = request.getParameterValues("update");
		for (String id : ids) {
			String dbQuery = productService.getQuery(id, null, null, null);
			Product product = productService.findOne(dbQuery);
			product.setStatus(Integer.parseInt(status));
			productService.objectUpdate(product);
			logger.debug("Product " + id + " " + status + "d");
		}
		message = "Selected products have been updated";

		logger.info(message);
		request.getSession().setAttribute("message", message);

		String redirect = request.getParameter("return");
		if (redirect == null) {
			redirect = "/admin/productList";
		}
		return "redirect:" + redirect;
	}

	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public String productSingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show product form");

		// Get new or existing product if requested
		Product product = new Product();
		if (request.getParameter("id") != null) {
			String dbQuery = productService.getQuery(request.getParameter("id"), null, null, null);
			product = productService.findOne(dbQuery);
		}

		// Update model
		model = fetchPanelData(model, 1, 0, 0, 0);
		model = adminTemplate(model, request, "admin", "product");
		model.addAttribute("product", product);
		return "admin.formProduct";
	}

	@RequestMapping(value = "/product", method = RequestMethod.POST)
	public String productSingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute("product") Product product, BindingResult result) {
		logger.info("Submitting requested product");

		// Update child variants
		product.setVariants(getVariants(product));

		String message = "An error has occured whislt updating that product";

		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = adminTemplate(model, request, "admin", "variant");
			return "admin.formVariant";
		} else {

			// Set product categories
			if (product.getCategorySave() != null) {
				Set<Category> categories = new HashSet<Category>();
				for (String categoryId : product.getCategorySave().split(",")) {
					if (Utils.isNumeric(categoryId)) {
						String dbQuery = categoryService.getQuery(categoryId, null, 0, null);
						categories.add(categoryService.findOne(dbQuery));
					}
				}
				product.setCategories(categories);
			}

			// Get promotional category
			if (product.getPromotionId() != null) {
				String dbQuery = categoryService.getQuery(product.getPromotionId().toString(), null, 0, null);
				product.setPromotionList(categoryService.findOne(dbQuery));
			}

			// Add / Update product
			if (product.getId() == null) {
				product.setCreatedBy(fetchAdminUser().getName());
				product.setDateCreated(new Date());
				productService.objectCreate(product);
				message = product.getName() + " created";
			} else {
				product.setLastEditedBy(fetchAdminUser().getName());
				product.setLastEdited(new Date());
				productService.objectUpdate(product);
				message = product.getName() + " updated";
			}
			logger.info(message);
			request.getSession().setAttribute("message", message);

			// Redirect to product list page
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/productList";
			}
			return "redirect:" + redirect;
		}
	}

}