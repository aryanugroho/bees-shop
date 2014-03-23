package org.beesden.shop.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.shop.model.Basket;
import org.beesden.shop.model.BasketItem;
import org.beesden.shop.model.Category;
import org.beesden.shop.model.Variant;
import org.beesden.shop.service.BasketService;
import org.beesden.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class BasketView extends View {

	@Autowired
	protected Basket basket;

	@RequestMapping(value = "/checkout/basket/add", method = RequestMethod.POST)
	public String addToBasket(HttpServletRequest request, ModelMap model) {
		logger.info("Updating shopping basket");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		// Create a new basket item
		BasketItem basketItem = new BasketItem();
		String variantId = request.getParameter("variantId");
		String quantity = request.getParameter("quantity");
		String dbQuery = variantService.getQuery(variantId, null, 1, null);
		Variant addItem = variantService.findOne(dbQuery);
		// Add item to the basket
		if (addItem != null) {
			basketItem.setQuantity(Utils.isNumeric(quantity) && Integer.parseInt(quantity) > 0 ? Integer.parseInt(quantity) : 1);
			basketItem.setVariant(addItem);
			basket = basketService.addProduct(request, basket, basketItem);
		}
		return isAjax(model, request, "checkout.updatebasket", config, start);
	}

	@RequestMapping(value = "/checkout/basket", method = RequestMethod.GET)
	public String showBasket(HttpServletRequest request, ModelMap model) {
		logger.info("Shopping basket requested");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		// Add basket and cross sale items to model
		String crossSale = config.get("crossSaleId").toString();
		if (!Boolean.parseBoolean(request.getParameter("ajax")) && Utils.isNumeric(crossSale)) {
			String dbQuery = categoryService.getQuery(crossSale, null, 1, null);
			Category promotions = categoryService.findOne(dbQuery);
			model = getPromos(model, promotions);
		}
		return isAjax(model, request, "checkout.basket", config, start);
	}

	@RequestMapping(value = "/checkout/basket/update")
	public String updateBasket(HttpServletRequest request, ModelMap model) {
		logger.info("Updating shopping basket");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		// Update basket item
		basket = BasketService.updateBasket(request, basket);
		return isAjax(model, request, "checkout.updatebasket", config, start);
	}
}