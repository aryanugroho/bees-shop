package org.beesden.shop.view;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/customer/")
public class CustomerView extends ViewUpdate {

	private String getRedirectUrl(HttpServletRequest request, HttpServletResponse response) {
		SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
		if (savedRequest != null) {
			return savedRequest.getRedirectUrl();
		}
		return request.getContextPath() + "/";
	}

	@RequestMapping(value = "/loginfailed", method = RequestMethod.GET)
	public String loginerror(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("Error logging in");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String layout = "account.login";
		// Get the url from the spring cache
		try {
			URL redirect = new URL(getRedirectUrl(request, response));
			layout = redirect.getPath().replaceFirst("^/([^/]+).*$", "$1\\.login");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		if (layout.equals("checkout.login")) {
			return isCheckout(model, request, layout);
		}

		List<String> errors = new ArrayList<String>();
		errors = addError(errors, "login.error");
		request.getSession().setAttribute("messages", errors);

		return isAjax(model, request, layout, config, start);

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerCustomer(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("Received request to register new customer");
		return "redirect:" + (registerCustomer(request) ? getRedirectUrl(request, response) : "/checkout/login");
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLogin(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		logger.info("Received request to show login page");
		Long start = System.currentTimeMillis();
		Map<String, Object> config = getConfig(request);
		String layout = "account.login";
		// Get the url from the spring cache
		try {
			URL redirect = new URL(getRedirectUrl(request, response));
			layout = redirect.getPath().replaceFirst("^/([^/]+).*$", "$1\\.login");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
		// Add 3rd party URLs
		if (layout.equals("checkout.login")) {
			return isCheckout(model, request, layout);
		}
		return isAjax(model, request, layout, config, start);
	}

}