window.onload = function() {

	// Initiate scripts for header, menu and footer
	if (beesden.layout) {
		beesden.layout.init();
	}

	// Initiate scripts for content, e.g. pagination
	if (beesden.content) {
		beesden.content.init();
	}

	// Initiate scripts for product pages
	var product = document.getElementById('product');
	if (beesden.product && product) {
		beesden.product.init(product);
	}

	// Store related functions, e.g. basket
	if (beesden.store) {
		beesden.store.init();
	}

	// Form plugins for the account / checkout
	if (beesden.forms) {
		beesden.forms.init();
	}

	// Generic javascript plugins e.g. CMS
	if (beesden.plugins) {
		beesden.plugins.init();
	}

	// Allow JS-specific css styles
	document.body.className += ' js';	

};