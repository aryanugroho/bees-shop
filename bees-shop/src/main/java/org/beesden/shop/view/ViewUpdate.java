package org.beesden.shop.view;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Address;
import org.beesden.shop.model.Customer;
import org.beesden.shop.model.Tender;
import org.beesden.utils.Utils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class ViewUpdate extends View {

	public Address createAddress(HttpServletRequest request, Address address, boolean includeCustomer) {
		logger.info((address.getId() == null ? "Create a new" : "Edit an existing") + " customer address");
		if (Utils.isNumeric(request.getParameter("editAddressId"))) {
			address.setId(Integer.parseInt(request.getParameter("editAddressId")));
		}
		address.setStatus(1);
		if (includeCustomer) {
			// Customer information
			address.setTitle(request.getParameter("title"));
			address.setFirstname(request.getParameter("firstname"));
			address.setSurname(request.getParameter("surname"));
			address.setTelephone(request.getParameter("telephone"));
			address.setEmail(request.getParameter("email"));
		}
		// Address information;
		address.setAddress1(request.getParameter("address1"));
		address.setAddress2(request.getParameter("address2"));
		address.setAddress3(request.getParameter("address3"));
		address.setCity(request.getParameter("city"));
		address.setRegion(request.getParameter("region"));
		address.setPostalCode(request.getParameter("postalCode"));
		String countryId = (request.getParameter("country"));
		if (countryId != null) {
			address.setCountry(countryService.getCountry(countryId));
		}
		return address;
	}

	public boolean registerCustomer(HttpServletRequest request) {
		// Get form submission values
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("password_confirm");
		// Check password and confirm password match
		if (password != null && !password.equals(passwordConfirm)) {
			return false;
		}
		// Check if the user already exists
		String dbQuery = customerService.getQuery(null, email, null, null);
		if (customerService.count(dbQuery) > 0) {
			return false;
		}
		;
		// Create the new customer
		Customer customer = new Customer();
		// Generate secure password
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncoder.encode(password);
		customer.setPassword(hashedPassword);
		// Create customer and log them in
		customer.setName(email);
		customer.setEmail(email);
		customer.setStatus(1);
		customer.setTitle(request.getParameter("title"));
		customer.setFirstname(request.getParameter("firstname"));
		customer.setSurname(request.getParameter("surname"));
		customer.setTelephone(request.getParameter("telephone"));
		customerService.objectCreate(customer);
		customerAuth(customer);
		return true;
	}

	public Tender setPaymentDetails(HttpServletRequest request, Tender paymentDetails) {
		paymentDetails.setStatus(1);
		// Payment information;
		paymentDetails.setCardType(request.getParameter("cardType"));
		paymentDetails.setCardNumber(request.getParameter("cardNumber"));
		paymentDetails.setSecuriryCode(request.getParameter("securityCode"));
		paymentDetails.setStartDate(Utils.isDate(request.getParameter("startDate"), "yyyy-MM"));
		paymentDetails.setExpiryDate(Utils.isDate(request.getParameter("expiryDate"), "yyyy-MM"));
		if (paymentDetails.getCardNumber() != null) {
			paymentDetails.setName(paymentDetails.getCardNumber().replaceAll("\\s+", "").replaceAll("^.*(.{4})$", "**** **** **** $1"));
		}
		return paymentDetails;
	}
}