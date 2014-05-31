package org.beesden.shop.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Basket;
import org.beesden.shop.model.BasketItem;
import org.beesden.shop.model.Customer;
import org.beesden.shop.model.DeliveryCharge;
import org.beesden.utils.Utils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class BasketService extends Service<Basket> {

	public static Basket setTotals(Basket basket) {
		Double total = new Double(0);
		// Calculate the item sub-total
		if (basket.getItems() != null) {
			for (BasketItem item : basket.getItems()) {
				total = total + item.getPrice() * item.getQuantity();
			}
		}
		basket.setSubTotal(total);
		// Add the delivery charge
		if (basket.getDeliveryCharge() != null) {
			double delivery = basket.getDeliveryCharge().getCharge();
			if (delivery > 0) {
				total = total + delivery;
			}
		}
		// Set the total basket price
		basket.setTotal(total);
		return basket;
	}

	public static Basket updateBasket(HttpServletRequest request, Basket basket) {
		// Get the parameters and check they're valid
		String targetItem = request.getParameter("productId");
		String quantity = request.getParameter("quantity");
		if (!Utils.isNumeric(quantity) || targetItem.equals("") || quantity.equals("")) {
			return basket;
		}
		;
		// Get the basket items and update the requested item
		List<BasketItem> currentItems = basket.getItems(), updateItems = new ArrayList<BasketItem>();
		for (BasketItem item : currentItems) {
			if (item.getVariant().getName().toLowerCase().equals(targetItem.toLowerCase())) {
				Integer quant = Integer.parseInt(quantity);
				if (quant > 0) {
					item.setQuantity(quant);
					updateItems.add(item);
				}
			} else {
				updateItems.add(item);
			}
		}
		// Update the basket and recalculate the totals
		basket.setItems(updateItems);
		basket = setTotals(basket);
		return basket;
	}

	public BasketService() {
		super(Basket.class.getName());
	}

	public Basket addProduct(HttpServletRequest request, Basket basket, BasketItem basketItem) {
		// Adding item to basket
		List<BasketItem> items = basket.getItems();
		BasketItem match = null;
		if (items == null) {
			items = new ArrayList<BasketItem>();
		} else {
			for (BasketItem item : items) {
				if (item.getVariant().getId().equals(basketItem.getVariant().getId())) {
					match = item;
				}
			}
		}
		if (!items.contains(match)) {
			basketItem.setPrice(basketItem.getVariant().getPrice());
			items.add(basketItem);
		} else {
			items.remove(match);
			match.setQuantity(basketItem.getQuantity() + match.getQuantity());
			items.add(match);
		}
		basket.setItems(items);
		basket = setTotals(basket);
		return basket;
	}

	public Basket assembleOrder(Basket basket, Customer customer) {
		Basket order = new Basket();
		DeliveryCharge charge = basket.getDeliveryCharge();
		// Customer information
		order.setCustomer(customer);
		order.setDeliveryAddress(basket.getDeliveryAddress());
		order.setPaymentDetails(basket.getPaymentDetails());
		// Delivery charge information
		if (charge != null) {
			order.setDeliveryChargePrice(charge.getCharge());
			order.setDeliveryChargeName(charge.getName());
		}
		// Basket items
		order.setItems(basket.getItems());
		order.setOrderPlaced(new Date());
		order.setSubTotal(basket.getSubTotal());
		order.setTotal(basket.getTotal());
		return order;
	}

	public String getQueryCustomer(String orderId, String customerId, String sort) {
		// Generate dbQuery string
		String dbQuery = " WHERE p.customer.id = " + customerId;
		if (orderId != null && !orderId.isEmpty()) {
			dbQuery += " AND p.id = '" + orderId + "'";
		}
		if (sort != null && !sort.isEmpty()) {
			dbQuery += " ORDER BY p." + sort.replaceAll("_", " ");
		}
		return dbQuery;
	}
}
