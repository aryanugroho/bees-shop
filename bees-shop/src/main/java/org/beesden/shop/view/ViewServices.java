package org.beesden.shop.view;

import org.apache.log4j.Logger;
import org.beesden.shop.service.CategoryService;
import org.beesden.shop.service.PageService;
import org.beesden.shop.service.ProductService;
import org.beesden.shop.service.VariantService;
import org.springframework.beans.factory.annotation.Autowired;

public class ViewServices {

	protected static Logger logger = Logger.getLogger("controller");

	@Autowired
	public CategoryService categoryService;

	@Autowired
	public PageService pageService;

	@Autowired
	public ProductService productService;

	@Autowired
	public VariantService variantService;

}
