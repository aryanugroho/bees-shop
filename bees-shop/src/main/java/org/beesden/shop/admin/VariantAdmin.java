package org.beesden.shop.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.beesden.shop.model.Variant;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class VariantAdmin extends Admin {

	@RequestMapping(value = "/variantList", method = RequestMethod.GET)
	public String variantList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show list of variants");

		// Check if list requires sorting and archived
		String archive = request.getParameter("archived");
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "id";
		}

		// Get variant list from database
		List<Variant> itemList = new ArrayList<Variant>();
		String dbQuery = variantService.getQuery(null, null, archive != null ? null : 0, sort);
		itemList = variantService.findAll(dbQuery);

		// Update model
		model = adminTemplate(model, request, "admin", "variant");
		model.addAttribute("itemList", itemList);
		return "admin.adminList";
	}

	@RequestMapping(value = "/variantList", method = RequestMethod.POST)
	public String variantListUpdate(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to update list of variants");

		String message = "An error has occured";

		// Update selected variants
		String status = request.getParameter("statusUpdate");
		String[] ids = request.getParameterValues("update");
		for (String id : ids) {
			String dbQuery = variantService.getQuery(id, null, null, null);
			Variant variant = variantService.findOne(dbQuery);
			variant.setStatus(Integer.parseInt(status));
			variantService.objectUpdate(variant);
			logger.debug("Variant " + id + " " + status + "d");
		}
		message = "Selected  variants have been updated";

		logger.info(message);
		request.getSession().setAttribute("message", message);

		String redirect = request.getParameter("return");
		if (redirect == null) {
			redirect = "/admin/variantList";
		}
		return "redirect:" + redirect;
	}

	@RequestMapping(value = "/variant", method = RequestMethod.GET)
	public String variantSingle(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show variant form");

		// Get new or existing variant if requested
		Variant variant = new Variant();
		if (request.getParameter("id") != null) {
			String dbQuery = variantService.getQuery(request.getParameter("id"), null, null, null);
			variant = variantService.findOne(dbQuery);
		}

		// Update model
		model = adminTemplate(model, request, "admin", "variant");
		model = fetchPanelData(model, 1, 1, 0, 0);
		model.addAttribute("variant", variant);
		return "admin.formVariant";
	}

	@RequestMapping(value = "/variant", method = RequestMethod.POST)
	public String variantSingleUpdate(HttpServletRequest request, ModelMap model, @Valid @ModelAttribute Variant variant, BindingResult result) {
		logger.info("Submitting requested variant");

		String message = "An error has occured whislt updating that variant";

		// Return form if not valid
		if (result.hasErrors()) {
			logger.warn("Form submission contains " + result.getErrorCount() + " errors");
			model = adminTemplate(model, request, "admin", "variant");
			model = fetchPanelData(model, 1, 1, 0, 0);
			return "admin.formVariant";
		} else {

			// Get product from productId
			Integer productId = variant.getProductId() == null ? 1 : variant.getProductId();
			String dbQuery = productService.getQuery(productId.toString(), null, 0, null);
			variant.setProduct(productService.findOne(dbQuery));

			// Get promotional category
			if (variant.getPromotionId() != null) {
				dbQuery = categoryService.getQuery(variant.getPromotionId().toString(), null, 0, null);
				variant.setPromotionList(categoryService.findOne(dbQuery));
			}

			// Add / Update variant
			if (variant.getId() == null) {
				variant.setCreatedBy(fetchAdminUser().getName());
				variant.setDateCreated(new Date());
				variantService.objectCreate(variant);
				message = variant.getName() + " created";
			} else {
				variant.setLastEditedBy(fetchAdminUser().getName());
				variant.setLastEdited(new Date());
				variantService.objectUpdate(variant);
				message = variant.getName() + " updated";
			}
			logger.info(message);
			request.getSession().setAttribute("message", message);

			// Redirect to variant list page
			String redirect = request.getParameter("return");
			if (redirect == null) {
				redirect = "/admin/variantList";
			}
			return "redirect:" + redirect;
		}
	}

}