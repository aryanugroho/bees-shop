package org.beesden.shop.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.BasketItem;
import org.beesden.shop.model.Category;
import org.beesden.shop.model.Page;
import org.beesden.shop.model.Product;
import org.beesden.shop.service.MailService;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class ContentView extends View {

	@RequestMapping(value = { "/category/{name}" }, method = RequestMethod.GET)
	public String showCategory(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Category request: " + name);
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String dbQuery = categoryService.getQuery(null, name, 1, null);
		Category category = categoryService.findOne(dbQuery);
		if (category != null) {
			// Get paged category products
			String sort = category.getSortOrder();
			sort = request.getParameter("sort") == null ? sort == null || sort.isEmpty() ? "id" : sort : request.getParameter("sort");
			dbQuery = categoryService.getQueryPaged("categories", category.getId().toString(), 1, sort);
			Map<String, Integer> pagination = getPagination(request, productService.count(dbQuery).intValue(), (Integer) config.get("categoryDefaultSize"));
			category.setProducts(productService.findPaged(dbQuery, pagination));
			// Add category and pagination to model
			model.addAttribute("content", category);
			model.addAttribute("pagination", pagination);
			model = setTitle(model, "content-category", category.getName());
			model = getPromos(model, category.getPromotionList());
		}
		return isAjax(model, request, "category", config, start);
	}

	@RequestMapping(value = { "/" }, method = RequestMethod.GET)
	public String showPage(HttpServletRequest request, ModelMap model) {
		// Redirect to home page
		return showPage("", request, model);
	}

	@RequestMapping(value = { "/{name}" }, method = RequestMethod.GET)
	public String showPage(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Page request: " + (name.equals("") ? "default home page" : name));
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String dbQuery = pageService.getQuery(null, name, 1, null);
		Page page = pageService.findOne(dbQuery);
		if (page != null) {
			// Add page to model
			model.addAttribute("content", page);
			model = setTitle(model, "content-page", page.getName());
			model = getPromos(model, page.getPromotionList());
		}
		return isAjax(model, request, "webpage", config, start);
	}

	@RequestMapping(value = { "/product/{name}" }, method = RequestMethod.GET)
	public String showProduct(@PathVariable("name") String name, HttpServletRequest request, ModelMap model) {
		logger.info("Product request: " + name);
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String dbQuery = productService.getQuery(null, name, 1, null);
		Product product = productService.findOne(dbQuery);
		if (product != null) {
			// Add product to model
			model.addAttribute("content", product);
			model = setTitle(model, "content-product", product.getName());
			model = getPromos(model, product.getPromotionList());
		}
		return isAjax(model, request, "product", config, start);
	}

	@RequestMapping(value = { "/search" }, method = RequestMethod.GET)
	public String showSearch(HttpServletRequest request, ModelMap model) {
		String keywords = request.getParameter("keywords");
		logger.info("Search request: " + keywords);
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		Category category = new Category();
		if (category != null && keywords != null) {
			// Get paged category products
			String sort = request.getParameter("sort") == null ? "id" : request.getParameter("sort");
			String dbQuery = productService.getQuerySearch(keywords, sort);
			Map<String, Integer> pagination = getPagination(request, productService.count(dbQuery).intValue(), (Integer) config.get("categoryDefaultSize"));
			category.setProducts(productService.findPaged(dbQuery, pagination));
			// Add category and pagination to model
			model.addAttribute("content", category);
			model.addAttribute("pagination", pagination);
			model = setTitle(model, "content-search", "Search Results");
		}
		return isAjax(model, request, "search", config, start);
	}

	@RequestMapping(value = { "/enquiry/submit" }, method = RequestMethod.POST)
	public String submitEnquiry(HttpServletRequest request, ModelMap model) {
		logger.info("Enquiry form submitted");
		Map<String, Object> config = getConfig(request);
		// Get enquiry message and create email body
		String subject = "New website enquiry";
		String message = "<strong>Name</strong>: " + request.getParameter("name") + "<br /><strong>Email</strong>: " + request.getParameter("email") + "<br /><strong>Tel</strong>: " + request.getParameter("telephone") + "<br /><strong>Message</strong>: " + request.getParameter("message");
		// Send mail
		ClassPathXmlApplicationContext context = null;
		try {
			context = new ClassPathXmlApplicationContext("./email-context.xml");
			MailService mailService = (MailService) context.getBean("mailService");
			mailService.sendMail(config, subject, message);
		} finally {
			if (context != null) {
				context.close();
			}
		}
		return "redirect:/";
	}
}