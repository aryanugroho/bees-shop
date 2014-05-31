package org.beesden.shop.view;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Address;
import org.beesden.shop.model.Basket;
import org.beesden.shop.model.Customer;
import org.beesden.shop.model.Tender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/account/")
public class AccountView extends ViewUpdate {

	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public String showAddressList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer addresses");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return isAjax(model, request, "account.address", config, start);
	}

	@RequestMapping(value = "/address/update", method = RequestMethod.GET)
	public String showAddressView(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer address form");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		Customer customer = fetchCustomer();
		String addressId = (String) request.getParameter("id");
		if (addressId != null) {
			String dbQuery = addressService.getQueryCustomer(addressId, customer.getId().toString(), null);
			Address address = addressService.findOne(dbQuery);
			model.addAttribute("addressForm", address);
		}
		model.addAttribute("countries", countryService.findAll(""));
		return isAjax(model, request, "account.address.view", config, start);
	}

	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String showContact(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer details");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return isAjax(model, request, "account.contact", config, start);
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String showDashboard(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer dashboard");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return isAjax(model, request, "account.home", config, start);
	}

	@RequestMapping(value = "/order", method = RequestMethod.GET)
	public String showOrderList(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer orders");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String sort = request.getParameter("sort");
		sort = sort == null || sort.equals("") ? "orderPlaced_desc" : sort;
		String dbQuery = basketService.getQueryCustomer(null, fetchCustomer().getId().toString(), sort);
		Map<String, Integer> pagination = getPagination(request, basketService.count(dbQuery).intValue(), (Integer) config.get("ordersDefaultSize"));
		model.addAttribute("orderList", basketService.findPaged(dbQuery, pagination));
		model.addAttribute("orderPagination", pagination);		
		return isAjax(model, request, "account.order", config, start);
	}

	@RequestMapping(value = "/order/{id}", method = RequestMethod.GET)
	public String showOrderView(@PathVariable("id") String id, ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer order view");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		Customer customer = fetchCustomer();
		String dbQuery = basketService.getQueryCustomer(id, customer.getId().toString(), null);
		Basket order = basketService.findOne(dbQuery);
		if (order == null) {
			List<String> errors = new ArrayList<String>();
			errors.add("invalid.order.id");
			request.getSession().setAttribute("messages", errors);
			return "redirect:/account/order";
		}
		model.addAttribute("order", order);
		return isAjax(model, request, "account.order.view", config, start);
	}

	@RequestMapping(value = "/password", method = RequestMethod.GET)
	public String showPassword(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer password form");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return isAjax(model, request, "account.password", config, start);
	}

	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String showPayment(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer payment options");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return isAjax(model, request, "account.payment", config, start);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateCustomer(HttpServletRequest request) {
		logger.info("Received request to update customer");
		Customer customer = fetchCustomer();
		List<String> errors = new ArrayList<String>();
		String dbQuery = "";

		// Update email if provided
		String newEmail = String.valueOf(request.getParameter("email"));
		if (!newEmail.equals("")) {
			String confirmEmail = String.valueOf(request.getParameter("email2"));
			// Check email not already in use
			dbQuery = customerService.getQuery(null, newEmail, null, null);
			if (!newEmail.equals(confirmEmail)) {
				errors = addError(errors, "emails.not.match");
			} else if (customerService.count(dbQuery) > 0) {
				errors = addError(errors, "email.already.in.use");
			} else {
				customer.setEmail(newEmail);
			}
		}

		// Update password if provided
		String newPassword = String.valueOf(request.getParameter("password"));
		if (!newEmail.equals("")) {
			// Get the old password to test against current password
			String oldPassword = String.valueOf(request.getParameter("oldPassword"));
			if (oldPassword.equals("")) {
				errors = addError(errors, "passwords.not.match");
			} else {
				BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
				oldPassword = passwordEncoder.encode(oldPassword);
			}
			// Test the old password and password confirm
			String confirmPassword = String.valueOf(request.getParameter("password2"));
			if (!customer.getPassword().equals(oldPassword)) {
				errors = addError(errors, "password.invalid");
			} else if (!newPassword.equals(confirmPassword)) {
				errors = addError(errors, "passwords.not.match");
			} else {
				customer.setPassword(newPassword);
			}
		}

		// Update customer details
		if (Boolean.valueOf(request.getParameter("updateCustomer"))) {
			customer.setTitle(request.getParameter("title"));
			customer.setFirstname(request.getParameter("firstname"));
			customer.setSurname(request.getParameter("surname"));
			customer.setTelephone(request.getParameter("telephone"));
		}

		// Update saved address
		Boolean createAddress = Boolean.valueOf(request.getParameter("createAddress"));
		Integer updateAddress = Integer.parseInt(request.getParameter("updateAddress"));
		if (updateAddress > 0 || createAddress) {
			Set<Address> customerAddresses = new HashSet<Address>();
			for (Address address : customer.getAddresses()) {
				if (address.getId() == updateAddress) {
					address = createAddress(request, address, true);
					address.setLastEdited(new Date());
					address.setLastEditedBy(customer.getName());
				}
				customerAddresses.add(address);
			}
			if (createAddress) {
				Address address = new Address();
				address = createAddress(request, address, true);
				customerAddresses.add(address);
				address.setDateCreated(new Date());
				address.setCreatedBy(customer.getName());
				address.setLastEdited(new Date());
				address.setLastEditedBy(customer.getName());
			}
			customer.setAddresses(customerAddresses);
		}

		// Remove saved address
		Integer removeAddress = Integer.parseInt(request.getParameter("removeAddress"));
		if (removeAddress > 0) {
			Set<Address> customerAddresses = new HashSet<Address>();
			for (Address address : customer.getAddresses()) {
				if (address.getId() == removeAddress) {
					address.setStatus(3);
					address.setLastEdited(new Date());
					address.setLastEditedBy(customer.getName());
				}
				customerAddresses.add(address);
			}
			customer.setAddresses(customerAddresses);
		}

		// Remove saved card
		Integer removeCard = Integer.parseInt(request.getParameter("removeCard"));
		if (removeCard > 0) {
			Set<Tender> customerCards = new HashSet<Tender>();
			for (Tender tender : customer.getTenders()) {
				if (tender.getId() == removeCard) {
					tender.setStatus(3);
					tender.setLastEdited(new Date());
					tender.setLastEditedBy(customer.getName());
				}
				customerCards.add(tender);
			}
			customer.setTenders(customerCards);
		}

		// Failed request returns to the specified layout
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return String.valueOf(request.getParameter("onError"));
		}
		
		// Update and persist the customer into the db and session
		customer.setLastEdited(new Date());
		customer.setLastEditedBy(customer.getName());
		customerService.objectUpdate(customer);
		customerAuth(customer);

		// Successful updates return to the same uri
		// This is not nice, especially after a failed form submission
		String refererURI = "/account/home";
		try {
			refererURI = new URI(request.getHeader("referer")).getPath();
		} catch (URISyntaxException e) {
			logger.error(e);
		}
		System.out.println(refererURI);
		return "redirect:" + refererURI;
	}
}