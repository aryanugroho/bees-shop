package org.beesden.shop.view;

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
*/
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String getLoginPage(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show customer login page");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		// Add customer model to page
		model.addAttribute("newCustomer", new Customer());
		return isAjax(model, request, "account.login", config, start);
	}

	@Autowired
	public CustomerService customerService;
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerCustomer(HttpServletRequest request, @ModelAttribute("newCustomer") Customer customer) {
		logger.info("Received request to register new customer");

		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncoder.encode(customer.getPassword());
		customer.setPassword(hashedPassword);

		customerService.objectCreate(customer);
		logger.info(customer.getEmail() + " registered");

		logger.info("Logging new customer into their account");
		customerAuth(customer);

		return "redirect:/account/home";
	}
	/*

	@RequestMapping(value = "/address", method = RequestMethod.GET)
	public String showAddresses(Model model, HttpServletRequest request) {
		logger.info("Received request to show address section");

		model = storeTemplate(model, request);
		model = setTitle(model, "account-address", "Your Addresses");
		return "account.addresses";
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

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String showDashboard(Model model, HttpServletRequest request) {
		logger.info("Received request to show account dashboard");

		model = storeTemplate(model, request);
		model = setTitle(model, "account-home", "Your Account");
		return "account.home";
	}

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