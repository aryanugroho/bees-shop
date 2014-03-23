/** Beesden Product Functions */
beesden.product = function(d) {

	/**
	 * @name 	addToBasket
	 * @type	Function
	 * @desc	Add to basket using AJAX. Returns a confirmation message and updates minibasket
	 * @param {Object} product Adds purchasable product to basket
	*/
	var addToBasket = function (product) {
		var productForm = product.querySelector('#productForm'),
			updateConfirm = d.createElement('a'),
			confirmClass = 'product_confirm',
			button;	

		if (!productForm) return;

		updateConfirm.className = confirmClass;
		updateConfirm.href = '/checkout/basket';
		productForm.appendChild(updateConfirm);

		productForm.onsubmit = function() {
			button = productForm.querySelectorAll('button');
			for (var i = 0; i < button.length; i++) {
				button[i].disabled = true;
			}
			// Add new product to basket via AJAX
			beesden.ajax(productForm.action, function(data) {
				data = JSON.parse(data.response);
				updateConfirm.innerHTML = data.message;
				updateConfirm.className = confirmClass + ' update alert alert' + data.status;
				beesden.store.minibasket();
				for (var i = 0; i < button.length; i++) {
					button[i].disabled = false;
				}
			}, null, beesden.serialize(productForm), 'POST');
			return false;
		}
	}

	/**
	* Beesden Alternative Images plugin for product pages
	*
	* @method altImages
	* @param {Object} product The target product page
	*/
	var altImages = function (product) {
		var productImage = product.querySelector('#productImages .large'),
			smallImages = product.querySelector('#productImages .small');
		for (i = 0; i < smallImages.childNodes.length; i++) {
			smallImages.childNodes[i].onclick = function() {
				this.firstChild.src = this.firstChild.src.replace('/small/', '/medium/');
				productImage.appendChild(this);
				smallImages.appendChild(productImage.firstChild);
				altImages(product);
				zoom(product);
				return false;
			}
		}
	}

	/**
	* Beesden Social Media links for product pages
	*
	* @method social
	* @param {Object} socialLinks Social links container element
	*/
	var social = function () {
		var socialLinks = d.getElementById('socialShare');
		if (!socialLinks) {
			return;
		}
		window.___gcfg = {lang:'en-GB'};
		beesden.async('//connect.facebook.net/en_GB/all.js#xfbml=1', 'social-fb');
		beesden.async('//platform.twitter.com/widgets.js', 'social-tw');
		beesden.async('//apis.google.com/js/plusone.js', 'social-gp');
		beesden.async('//assets.pinterest.com/js/pinit.js', 'social-pi');
		socialLinks.style.display = 'block';
	}

	/**
	* Beesden Zoom plugin for product pages
	*
	* @method zoom
	* @param {Object} product The target product page
	*/
	var zoom = function (product) {
		var productImage = product.querySelector('#productImages .large > a'),
			zoomImage = d.createElement('img'),
			topRatio,
			leftRatio;
		// Prevent multiple zoom images
		if (!productImage && productImage.querySelector('.zoomImage')) return;
		zoomImage.className = 'zoomImage';
		zoomImage.src = productImage.href;
		zoomImage.onload = function () {
			productImage.appendChild(zoomImage);
			// Show zoom image on hover
			productImage.onmouseover = function() {
				if (productImage.parentNode.className == 'large') zoomImage.style.opacity = 1;
			}
			// Hide zoom image on mouseout
			productImage.onmouseout = function() {
				zoomImage.style.opacity = 0;
			}
			// Move zoom image with mouse
			productImage.onmousemove = function(event) {
				if (productImage.parentNode.className == 'large') moveImage(event);
			}
			// Move zoom image with touch
			productImage.ontouchmove = function(event) {
				if (productImage.parentNode.className == 'large') moveImage(event);
			}
			// Move image with mouse / touch position
			function moveImage(event) {				
				topRatio = -(zoomImage.offsetHeight - productImage.offsetHeight) / productImage.offsetHeight,
				leftRatio = -(zoomImage.offsetWidth - productImage.offsetWidth) / productImage.offsetWidth;
				zoomImage.style.left = (event.clientX - productImage.getBoundingClientRect().left) * leftRatio + 'px';
				zoomImage.style.top = (event.clientY - productImage.getBoundingClientRect().top) * topRatio + 'px';
			}
		}
		productImage.onclick = function() {
			zoomImage.style.opacity = zoomImage.style.opacity == 1 ? 0 : 1;
			return false;
		}
	}

	return {
		init: function(product) {
			addToBasket(product, 2500);
			altImages(product);				
			social();	
			zoom(product);		
		}
	};
}(document);