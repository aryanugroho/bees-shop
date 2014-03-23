package org.beesden.shop.view;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Address;
import org.beesden.shop.model.Basket;
import org.beesden.shop.model.Customer;
import org.beesden.shop.model.DeliveryCharge;
import org.beesden.shop.model.Tender;
import org.beesden.shop.service.BasketService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/checkout/")
public class CheckoutView extends ViewUpdate {

	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public String placeOrder(HttpServletRequest request, ModelMap model) {
		logger.info("Placing order");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		// Don't process if the basket is empty
		if (basket.getItems() == null || basket.getItems().size() < 1) {
			return "redirect:/checkout/basket";
		}
		List<String> errors = updateBasket(request);
		errors = validateOrder(request, errors);
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return "redirect:/checkout/summary";
		}
		// Finalise the order attributes
		Basket order = basketService.assembleOrder(basket, fetchCustomer());
		order = basketService.objectCreate(order);
		model.addAttribute("order", order);
		basket.setOrderPlaced(new Date());
		return isAjax(model, request, "checkout.confirmation", config, start);
	}

	@RequestMapping(value = "/delivery", method = RequestMethod.GET)
	public String showDeliveryOptions(HttpServletRequest request, ModelMap model) {
		logger.info("Delivery options page requested");
		return isCheckout(model, request, "checkout.delivery");
	}

	@RequestMapping(value = "/confirmation", method = RequestMethod.GET)
	public String showOrderConfirmation(HttpServletRequest request, ModelMap model) {
		logger.info("Order confirmation page requested");
		return "redirect:/checkout/basket";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public String showPayment(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show checkout summary");
		return isCheckout(model, request, "checkout.payment");
	}

	@RequestMapping(value = "/shipping", method = RequestMethod.GET)
	public String showShipping(HttpServletRequest request, ModelMap model) {
		logger.info("Shipping address page requested");
		return isCheckout(model, request, "checkout.shipping");
	}

	@RequestMapping(value = "/summary", method = RequestMethod.GET)
	public String showSummary(ModelMap model, HttpServletRequest request) {
		logger.info("Received request to show checkout summary");
		return isCheckout(model, request, "checkout.summary");
	}

	public List<String> updateBasket(HttpServletRequest request) {
		logger.info("Updating checkout details");
		List<String> errors = new ArrayList<String>();
		Customer customer = fetchCustomer();

		// Check for terms and conditions acceptance
		Boolean termsAgree = Boolean.parseBoolean(request.getParameter("termsAgree"));
		basket.setTermsAgree(termsAgree);

		// Select a delivery option
		String deliveryChargeId = request.getParameter("deliveryCharge");
		if (deliveryChargeId != null) {
			logger.info("Updating delivery charge");
			String dbQuery = deliveryChargeService.getQuery(deliveryChargeId, null, 1, null);
			DeliveryCharge charge = deliveryChargeService.findOne(dbQuery);
			if (charge != null) {
				basket.setDeliveryCharge(charge);
			}
		}

		// Generate initial address variables
		Address address = new Address();
		String selectAddress = request.getParameter("selectAddress");
		String addressId = request.getParameter("selectAddressId");
		String addressType = request.getParameter("addressType");
		// Create / update an address
		if (selectAddress != null) {
			if (selectAddress.equals("existingAddress")) {
				logger.info("Select a saved " + addressType + " address: " + addressId);
				String dbQuery = addressService.getQueryCustomer(addressId, customer.getId().toString(), 1);
				address = addressService.findOne(dbQuery);
				if (address == null) {
					errors = addError(errors, "invalid.address.id");
				}
			} else {
				logger.info("Create a new " + addressType + "address");
				address = createAddress(request, address, true);
				address.setCreatedBy(customer.getName());
				address.setDateCreated(new Date());
				// Link the address to the customer
				address.setCustomer(customer);
				addressService.objectUpdate(address);
			}
			// Attach address to basket if delivery
			if (addressType.equals("delivery")) {
				logger.info("Set delivery address");
				basket.setDeliveryAddress(address);
			}
		}

		// Generate initial payment details variables
		Tender paymentDetails = new Tender();
		if (basket.getPaymentDetails() != null) {
			paymentDetails = basket.getPaymentDetails();
		}
		String updatePayment = request.getParameter("updatePayment");
		String tenderId = request.getParameter("paymentId");

		if (updatePayment != null) {
			if (updatePayment.equals("savedTender") && tenderId != null) {
				logger.info("Select a saved payment card: " + tenderId);
				String dbQuery = tenderService.getQueryCustomer(tenderId, customer.getId().toString(), 1);
				paymentDetails = tenderService.findOne(dbQuery);
				if (paymentDetails == null) {
					errors = addError(errors, "invalid.tender.id");
				}
			} else if (updatePayment.equals("newTender")) {
				logger.info("Create a new payment card");
				paymentDetails = setPaymentDetails(request, paymentDetails);
				paymentDetails.setCustomer(customer);
				paymentDetails.setCreatedBy(customer.getName());
				paymentDetails.setDateCreated(new Date());
				tenderService.objectUpdate(paymentDetails);
			}

			// Attach address to order tender if payment
			if (addressType.equals("payment") && !updatePayment.equals("savedTender")) {
				logger.info("Set payment address");
				paymentDetails.setAddress(address);
			}
			;
			basket.setPaymentDetails(paymentDetails);
		}

		// Update the basket totals
		basket = BasketService.setTotals(basket);
		return errors;
	}

	@RequestMapping(value = "/delivery", method = RequestMethod.POST)
	public String updateDelivery(HttpServletRequest request, ModelMap model) {
		logger.info("Updating shipping address");
		List<String> errors = updateBasket(request);
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return "redirect:/checkout/delivery";
		}
		return "redirect:/checkout/payment";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String updatePayment(HttpServletRequest request, ModelMap model) {
		logger.info("Updating payment details");
		List<String> errors = updateBasket(request);
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return "redirect:/checkout/payment";
		}
		return "redirect:/checkout/summary";
	}

	@RequestMapping(value = "/shipping", method = RequestMethod.POST)
	public String updateShipping(HttpServletRequest request, ModelMap model) {
		logger.info("Updating shipping address");
		List<String> errors = updateBasket(request);
		if (errors.size() > 0) {
			request.getSession().setAttribute("messages", errors);
			return "redirect:/checkout/shipping";
		}
		return "redirect:/checkout/delivery";
	}

	public List<String> validateOrder(HttpServletRequest request, List<String> errors) {
		if (!basket.getTermsAgree()) {
			errors = addError(errors, "order.terms.agree");
		}
		if (basket.getDeliveryCharge() == null) {
			errors = addError(errors, "order.delivery.charge");
		}
		return errors;
	}
}