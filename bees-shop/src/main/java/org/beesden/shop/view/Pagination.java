package org.beesden.shop.view;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.beesden.utils.Utils;

public class Pagination extends View {

	public Map<String, Object> getPagination(HttpServletRequest request, Integer size, Integer results, String sortDefault) {
		logger.debug("Fetching pagination information");
	
		Map<String, Object> pagination = new HashMap<String, Object>();

		String pageAttr = request.getParameter("page");
		Integer page = Utils.isNumeric(pageAttr) ? Integer.parseInt(pageAttr) : 1;
		String resultsAttr = request.getParameter("results");
		results = Utils.isNumeric(resultsAttr) ? Integer.parseInt(resultsAttr) : results;

		Integer first = (page - 1) * results + 1;
		first = first < 1 ? 1 : first;
		first = first > size ? 1 : first;
		Integer last = first + results - 1;
		last = last > size ? size : last;
		Integer pages = (int) Math.ceil((double) size / (double) results);
		
		String sort = request.getParameter("sort");
		sort = sort == null ? sortDefault : sort.replace("_", " ").toLowerCase();
		
		pagination.put("page", page);
		pagination.put("pages", pages.intValue());
		pagination.put("results", results);
		pagination.put("first", first);
		pagination.put("last", last);
		pagination.put("size", size);
		pagination.put("sortOrder", sort);

		logger.debug("Pagination: " + pagination);

		return pagination;
	}
/*
	

	public ModelMap pagedCategory(HttpServletRequest request, ModelMap model, Category category) {

		if (category != null) {

			logger.debug("Getting the category pagination as required");
			String sort = request.getParameter("sort");
			sort = sort == null ? category.getSortOrder() : sort.replace("_", " ").toLowerCase();
			String dbSearch = productService.paginationQuery(sort, category.getId());
			Map<String, Integer> pagination = getPagination(request, productService.count(dbSearch).intValue(), 30);

			logger.debug("Getting the category products");
			List<Product> categoryProducts = productService.getAll(dbSearch, pagination.get("first") - 1, pagination.get("results"));
			category.setProducts(categoryProducts);
			model.addAttribute("categoryPagination", pagination);

			model.addAttribute("content", category);
			model = setTitle(model, "content-category", category.getName());
		}

		return model;
	}

	public ModelMap pagedSearch(HttpServletRequest request, ModelMap model, Category category, String keywords) {

		if (keywords != null && keywords.length() > 0) {

			logger.debug("Getting the search results pagination as required");
			String sort = request.getParameter("sort");
			sort = sort == null ? category.getSortOrder() : sort.replace("_", " ").toLowerCase();
			String dbSearch = productService.searchQuery(sort, keywords);
			Map<String, Integer> pagination = getPagination(request, productService.count(dbSearch).intValue(), 30);

			logger.debug("Getting the search results");
			List<Product> categoryProducts = productService.getAll(dbSearch, pagination.get("first") - 1, pagination.get("results"));
			category.setProducts(categoryProducts);
			model.addAttribute("categoryPagination", pagination);

			model.addAttribute("content", category);
			model = setTitle(model, "content-search", "Search Results");
		}

		return model;
	}
*/
}
