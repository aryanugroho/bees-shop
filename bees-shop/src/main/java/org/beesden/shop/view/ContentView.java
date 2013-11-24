package org.beesden.shop.view;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class ContentView extends Pagination {

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String showPage(HttpServletRequest request, ModelMap model) {
		// Show home page
		return showPage("", request, model);
	}

	@RequestMapping(value = { "/{name}" }, method = RequestMethod.GET)
	public String showPage(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Page request: " + (name.equals("") ? "default home page" : name));
		String dbQuery = pageService.getQuery(null, name, 1, null);
		Page page = pageService.findOne(dbQuery);
		if (page != null) {
			model.addAttribute("content", page);
			model = setTitle(model, "content-page", page.getName());
		}
		model = storeTemplate(model, request);
		return "webpage";
	}/**

	@RequestMapping(value = { "/category/{name}" }, method = RequestMethod.GET)
	public String showPgCategory(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Category request: " + name);
		Category category = categoryService.get(name, 1);
		model = pagedCategory(request, model, category);

		String ajaxRequest = request.getParameter("ajax");
		if (ajaxRequest == null || !ajaxRequest.equals("true")) {
			model = storeTemplate(model, request);
			return "category";
		} else {
			model = basicTemplate(model, request, true);
			return "ajax.category";
		}
	}

	@RequestMapping(value = { "/search" }, method = RequestMethod.GET)
	public String showPgSearchResults(HttpServletRequest request, ModelMap model) {
		logger.info("Get Search Results page");
		Category category = new Category();
		model = pagedSearch(request, model, category, request.getParameter("keywords"));

		String ajaxRequest = request.getParameter("ajax");
		if (ajaxRequest == null || !ajaxRequest.equals("true")) {
			model = storeTemplate(model, request);
			return "search";
		} else {
			model = basicTemplate(model, request, true);
			return "ajax.search";
		}
	}

	@RequestMapping(value = { "/product/{name}" }, method = RequestMethod.GET)
	public String showProduct(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Product request: " + name);
		Product product = productService.get(name, 1);
		if (product != null) {
			model.addAttribute("content", product);
			model = setTitle(model, "content-product", product.getName());
		}
		model.addAttribute("basketItem", new BasketItem());

		String ajaxRequest = request.getParameter("ajax");
		if (ajaxRequest == null || !ajaxRequest.equals("true")) {
			model = storeTemplate(model, request);
			return "product";
		} else {
			model = basicTemplate(model, request, true);
			return "ajax.product";
		}
	}

	@RequestMapping(value = { "/enquiry/submit" }, method = RequestMethod.POST)
	public String submitEnquiry(@ModelAttribute("contactForm") Enquiry submit, HttpServletRequest request, ModelMap model) {
		logger.info("Enquiry form submitted");
		String redirect = "/";
		if (request.getParameter("redirect") != null) {
			redirect = request.getParameter("redirect");
		}
		if (submit != null) {
			submit.setDate(new Date());
			enquiryService.objectCreate(submit);
			String subject = "New website enquiry";
			String message = submit.getMessage();
			if (message == null) {
				message = "No message provided";
			}
			ClassPathXmlApplicationContext context = null;
			try {
				context = new ClassPathXmlApplicationContext("../email-context.xml");
				MailService mailService = (MailService) context.getBean("mailService");
				mailService.sendMail(subject, message);
			} finally {
				if (context != null) {
					context.close();
				}
			}
		}
		return "redirect:" + redirect;
	}
	*/
}