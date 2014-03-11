package org.beesden.shop.view;

import org.apache.log4j.Logger;
import org.beesden.shop.service.AddressService;
import org.beesden.shop.service.BasketService;
import org.beesden.shop.service.CategoryService;
import org.beesden.shop.service.ConfigService;
import org.beesden.shop.service.CustomerService;
import org.beesden.shop.service.MenuService;
import org.beesden.shop.service.PageService;
import org.beesden.shop.service.ProductService;
import org.beesden.shop.service.VariantService;
import org.springframework.beans.factory.annotation.Autowired;

public class ViewServices {

	protected static Logger logger = Logger.getLogger("controller");

	@Autowired
	public AddressService addressService;

	@Autowired
	public BasketService basketService;
	@Autowired
	public CategoryService categoryService;

	@Autowired
	public ConfigService configService;

	@Autowired
	public CustomerService customerService;

	@Autowired
	public MenuService menuService;

	@Autowired
	public PageService pageService;

	@Autowired
	public ProductService productService;

	@Autowired
	public VariantService variantService;

}
