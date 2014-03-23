package org.beesden.shop.view;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Customer;
import org.beesden.shop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/account/")
public class AccountView extends View {
/**
	@RequestMapping(value = "/address/remove", method = RequestMethod.POST)
	public String addressRemove(HttpServletRequest request) {
		logger.info("Removing customer address");

		List<String> messages = new ArrayList<String>();
		String addressId = request.getParameter("addressId");
		Customer customer = new Customer();

		if (customer != null && Utils.isNumeric(addressId)) {
			logger.debug("Checking the address belongs to the customer");
			Address checkAddress = addressService.get(customer.getId(), Integer.parseInt(addressId));
			if (checkAddress != null) {
				addressService.objectRemove(checkAddress);
				messages.add("Your address has been successfully removed.");
			} else {
				messages.add("An error has occured whilst trying to remove your address");
			}
		}
		request.getSession().setAttribute("messages", messages);

		return "redirect:/account/address";
	}

	@RequestMapping(value = "/address/update", method = RequestMethod.POST)
	public String addressUpdate(HttpServletRequest request, @ModelAttribute("address") Address updateAddress) {
		logger.info("Updating customer address");

		List<String> messages = new ArrayList<String>();
		Customer customer = fetchCustomerInfo();
		updateAddress.setAddressLink(customer.getId());

		if (customer != null && updateAddress.getId() != null) {
			logger.debug("Checking the address belongs to the customer");
			Address checkAddress = addressService.get(customer.getId(), updateAddress.getId());
			if (checkAddress == null) {
				updateAddress.setId(null);
				messages.add("We are unable to update your address. We have created a new address instead.");
			}
		}

		if (updateAddress.getId() == null) {
			addressService.objectCreate(updateAddress);
			messages.add("A new address has been added to your account.");
		} else {
			addressService.objectUpdate(updateAddress);
			messages.add("Your address has been updated.");
		}
		request.getSession().setAttribute("messages", messages);

		return "redirect:/account/address";
	}

	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public String showOrders(Model model, HttpServletRequest request) {
		logger.info("Received request to show order section");

		Customer customer = fetchCustomerInfo();

		String pageAttr = (String) request.getSession().getAttribute("page");
		Integer page = Utils.isNumeric(pageAttr) ? Integer.parseInt(pageAttr) : 1;

		List<Order> orders = orderService.getAll(page, 30, customer.getId());
		model.addAttribute("orderList", orders);

		model = storeTemplate(model, request);
		model = setTitle(model, "account-order", "Your Orders");
		return "account.orders";
	}

	@RequestMapping(value = "/address/manage", method = RequestMethod.GET)
	public String showAddressManager(Model model, HttpServletRequest request) {
		logger.info("Received request to manage an address");

		String addressId = request.getParameter("id");
		Customer customer = fetchCustomerInfo();
		Address address = addressId == null ? new Address() : addressService.get(customer.getId(), Integer.parseInt(addressId));
		address = address == null ? new Address() : address;
		model.addAttribute("address", address);
		model.addAttribute("countries", CountryList.countries());

		model = storeTemplate(model, request);
		model = setTitle(model, "account-address", "View Address");
		return "account.address";
	}
*/

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String showDashboard(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer dashboard");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.home", config, start));
	}

	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String showContact(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer details");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.contact", config, start));
	}

	@RequestMapping(value = "/password", method = RequestMethod.GET)
	public String showPassword(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer password form");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.password", config, start));
	}

	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public String showOrders(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer orders");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.orders", config, start));
	}

	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String showPayment(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer payment options");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.payment", config, start));
	}

	@RequestMapping(value = "/addresses", method = RequestMethod.GET)
	public String showAddresses(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer addresses");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		return (isAjax(model, request, "account.addresses", config, start));
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateCustomer(HttpServletRequest request) {
		logger.info("Received request to update customer");
		Customer customer = fetchCustomer();
		List<String> errors = new ArrayList<String>();
		
		// Update email if provided
		String newEmail = String.valueOf(request.getParameter("email"));
		if (!newEmail.equals("")) {
			String confirmEmail = String.valueOf(request.getParameter("email2"));
			if (!newEmail.equals(confirmEmail)) {
				errors = addError(errors, "emails.not.match");
			} else {
				customer.setEmail(newEmail);
			}
		}
		
		// Update customer details
		if ( Boolean.valueOf(request.getParameter("updateCustomer"))) {
			customer.setTitle(request.getParameter("title"));
			customer.setFirstname(request.getParameter("firstname"));
			customer.setSurname(request.getParameter("surname"));
			customer.setTelephone(request.getParameter("telephone"));
		}
		
		// Failed request returns to the specified layout
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return String.valueOf(request.getParameter("onError"));
		}

		// Successful updates return to the same uri
		String refererURI = "/account/home";		
		try {
			refererURI = new URI(request.getHeader("referer")).getPath();
		} catch (URISyntaxException e) {
			logger.error(e);
		}
		System.out.println(refererURI);
		return "redirect:" + refererURI;
	}
	
	/**

	@RequestMapping(value = "/order/view", method = RequestMethod.GET)
	public String showOrderManager(Model model, HttpServletRequest request) {
		logger.info("Received request to view a specific order order");

		List<String> messages = new ArrayList<String>();
		String orderId = request.getParameter("id");
		Boolean success = false;
		if (Utils.isNumeric(orderId)) {
			Customer customer = fetchCustomerInfo();
			Order order = orderService.get(Integer.parseInt(orderId), customer.getId());
			if (order != null) {
				model.addAttribute("customerOrder", order);
				success = true;
			}
		}

		if (!success) {
			messages.add("There has been an error in fetching your order.");
			return "redirect:/account/orders";
		}

		request.getSession().setAttribute("messages", messages);
		model = storeTemplate(model, request);
		model = setTitle(model, "account-order", "View Order");
		return "account.order";
	}

	@RequestMapping(value = "/orders", method = RequestMethod.GET)
	public String showOrders(Model model, HttpServletRequest request) {
		logger.info("Received request to show order section");

		Customer customer = fetchCustomerInfo();

		String pageAttr = (String) request.getSession().getAttribute("page");
		Integer page = Utils.isNumeric(pageAttr) ? Integer.parseInt(pageAttr) : 1;

		List<Order> orders = orderService.getAll(page, 30, customer.getId());
		model.addAttribute("orderList", orders);

		model = storeTemplate(model, request);
		model = setTitle(model, "account-order", "Your Orders");
		return "account.orders";
	}

	@RequestMapping(value = "/options/update", method = RequestMethod.POST)
	public String updateAccount(HttpServletRequest request, @ModelAttribute("customer") Customer update) {
		logger.info("Updating customer options");

		List<String> messages = new ArrayList<String>();

		Customer customer = fetchCustomerInfo();
		customer.setFirstname(update.getFirstname());
		customer.setSurname(update.getSurname());
		customer.setTelephone(update.getTelephone());
		customer.setEmail(update.getEmail());
		customerService.objectUpdate(customer);

		customerAuth(customer);
		messages.add("Your account has been successfully updated");
		request.getSession().setAttribute("messages", messages);

		return "redirect:/account/options";
	}

	@RequestMapping(value = "/password/update", method = RequestMethod.POST)
	public String updatePassword(HttpServletRequest request) {
		logger.info("Updating customer password");

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		Customer customer = fetchCustomerInfo();
		String newPass = request.getParameter("newPassword");
		List<String> messages = new ArrayList<String>();

		if (passwordEncoder.matches(request.getParameter("currentPassword"), customer.getPassword())) {
			if (newPass.equals(request.getParameter("verifyPassword"))) {
				newPass = passwordEncoder.encode(newPass);
				customer.setPassword(newPass);
				customerService.objectUpdate(customer);
				messages.add("Your password has been successfully updated");
			} else {
				messages.add("Entered passwords do not match");
			}
		} else {
			messages.add("Your current password is incorrect, please check and re-try");
		}

		request.getSession().setAttribute("messages", messages);
		return "redirect:/account/options";
	}
	*/
}