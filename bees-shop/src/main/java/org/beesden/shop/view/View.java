package org.beesden.shop.view;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Basket;
import org.beesden.shop.model.Category;
import org.beesden.shop.model.Config;
import org.beesden.shop.model.Customer;
import org.beesden.shop.model.Product;
import org.beesden.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;

import com.fasterxml.jackson.databind.ObjectMapper;

public class View extends ViewServices {

	@Autowired
	protected Basket basket;

	public List<String> addError(List<String> errors, String error) {
		errors.add(error);
		return errors;
	}

	public void customerAuth(Customer customer) {
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);
		authList.add(new SimpleGrantedAuthority("ROLE_CUSTOMER"));

		UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(customer.getEmail(), customer.getPassword(), authList);
		SecurityContextHolder.getContext().setAuthentication(auth);
	}

	public Customer fetchCustomer() {
		// Get customer information if logged in
		Customer customer = new Customer();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth.isAuthenticated()) {
			String dbQuery = customerService.getQuery(null, auth.getName(), 1, null);
			customer = customerService.findOne(dbQuery);
		}
		return customer;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getConfig(HttpServletRequest request) {
		// Get site configuration settings
		Map<String, Object> config = new HashMap<String, Object>();
		List<Config> configList = configService.findAll("");
		for (Config configItem : configList) {
			if (configItem.getType() != null && configItem.getType().equals("map")) {
				try {
					HashMap<String, Object> result = new ObjectMapper().readValue(configItem.getValue(), HashMap.class);
					config.put(configItem.getName(), result);
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else if (configItem.getType() != null && configItem.getType().equals("integer")) {
				config.put(configItem.getName(), Integer.parseInt(configItem.getValue()));
			} else {
				config.put(configItem.getName(), configItem.getValue());
			}
		}
		return config;
	}

	public Map<String, Integer> getPagination(HttpServletRequest request, Integer size, Integer results) {
		// Object pagination
		Map<String, Integer> pagination = new HashMap<String, Integer>();
		// Check parameters
		String pageAttr = request.getParameter("page");
		Integer page = Utils.isNumeric(pageAttr) ? Integer.parseInt(pageAttr) : 1;
		String resultsAttr = request.getParameter("results");
		results = Utils.isNumeric(resultsAttr) ? Integer.parseInt(resultsAttr) : results;
		// Calculate pagination
		Integer first = (page - 1) * results;
		first = first < 0 ? 0 : first;
		first = first > size ? 1 : first;
		Integer last = first + results;
		last = last > size ? size : last;
		Integer pages = (int) Math.ceil((double) size / (double) results);
		// Add information to map
		pagination.put("page", page);
		pagination.put("pages", pages.intValue());
		pagination.put("results", results);
		pagination.put("first", first);
		pagination.put("last", last);
		pagination.put("size", size);
		return pagination;
	}

	public ModelMap getPromos(ModelMap model, Category promotion) {
		// Lazy load promotional products if requested
		if (promotion != null) {
			String sort = promotion.getSortOrder() != null && !promotion.getSortOrder().isEmpty() ? promotion.getSortOrder() : "heading";
			String dbQuery = productService.getQueryPaged("categories", promotion.getId().toString(), 1, sort);
			List<Product> promotions = productService.findAll(dbQuery);
			Collections.shuffle(promotions);
			model.addAttribute("promotions", promotions);
		}
		return model;
	}

	public String isAjax(ModelMap model, HttpServletRequest request, String redirect, Map<String, Object> config, long time) {
		// Use ajax layout if requested
		Boolean ajaxRequest = request.getParameter("ajax") != null && request.getParameter("ajax").equals("true");
		redirect = ajaxRequest ? "ajax." + redirect : redirect;
		model.addAttribute("layout", redirect);
		logger.info("Response time: " + (System.currentTimeMillis() - time) + "ms");
		if (!ajaxRequest) {
			model = templateStore(model, request, config);
		} else {
			model.addAttribute("layout", redirect);
			model = templateAjax(model, request, config);
		}
		logger.info("Layout : " + redirect + "\n----------");
		return redirect;
	}

	public String isCheckout(ModelMap model, HttpServletRequest request, String redirect) {
		// Get page defaults
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		List<String> errors = new ArrayList<String>();
		// Prevent going anywhere in the checkout with an empty basket
		if (basket.getItems() == null || basket.getItems().size() < 1) {
			errors = addError(errors, "basket.empty");
			request.getSession().setAttribute("messages", errors);
			return "redirect:/checkout/basket";
		}
		// Get extra basket information
		String dbQuery = deliveryChargeService.getQuery(null, null, 1, "id");
		model.addAttribute("deliveryCharges", deliveryChargeService.findAll(dbQuery));
		dbQuery = countryService.getQuery(null, null, 1, "name");
		model.addAttribute("countries", countryService.findAll(""));
		return isAjax(model, request, redirect, config, start);
	}

	public ModelMap setTitle(ModelMap model, String pageType, String pageTitle) {
		// Set page type and title
		model.addAttribute("pageType", pageType);
		model.addAttribute("pageTitle", pageTitle);
		return model;
	}

	public ModelMap templateAjax(ModelMap model, HttpServletRequest request, Map<String, Object> config) {
		model.addAttribute("config", config);
		// Add basket to page
		model.addAttribute("basket", basket);
		// Empty the basket after order is placed
		if (basket.getOrderPlaced() != null) {
			basket.setPaymentDetails(null);
			basket.setDeliveryAddress(null);
			basket.setItems(null);
			basket.setOrderPlaced(null);
		}
		// Add the currently signed in customer
		model.addAttribute("customer", fetchCustomer());
		// Add any system messages
		model.addAttribute("messages", request.getSession().getAttribute("messages"));
		request.getSession().setAttribute("messages", null);
		return model;
	}

	public ModelMap templateStore(ModelMap model, HttpServletRequest request, Map<String, Object> config) {
		// Get shared ajax view settings
		model = templateAjax(model, request, config);
		// Get site menus
		String dbQuery = menuService.getQuery(null, null, 1, "position");
		model.addAttribute("menu", menuService.findAll(dbQuery));
		// Get customer information if logged in
		model.addAttribute("customer", fetchCustomer());
		return model;
	}
}