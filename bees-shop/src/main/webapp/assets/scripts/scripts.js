var beesden = beesden || {}, i, j;

// Global Functions - These are used on most pages
beesden.global = function (d) {
	var basketUtil = function (basket) {
		basket = basket || d.getElementById('basket');
		if (basket === null) {
			return;
		}
		// Get the basket buttons
		var updateQty = basket.getElementsByClassName('update');
		// Use AJAX for all basket updates
		basket.onsubmit = function() {
			beesden.xmlRequest(basket.action, function(data) {
				basket.innerHTML = data.responseText;
				basketUtil();
				miniBasketUtil();
			}, beesden.serialize(basket), 'POST');
			return false;
		};
		// Show the update button only for change in value
		for (i = 0; i < updateQty.length; i++) {
			updateQty[i].style.opacity = 0;
			updateQty[i].previousSibling.onchange = function () {
				this.nextSibling.style.transition = '1.2s';
				this.nextSibling.style.opacity = this.value === this.getAttribute('data-value') ? 0 : 1;
			};
			// Remove button resets quantity to 0
			updateQty[i].parentNode.firstChild.onclick = function() {
				this.nextSibling.value = 0;
			}
		}
	},
	formUtil = function (forms) {
		forms = d.getElementsByTagName('form');
		if (forms.length < 1) return
		for (i = 0; i < forms.length; i++) {
			var optionTitles = forms[i].getElementsByClassName('formSelect'),
				optionTitle,
				elementSections;
			// Prevent empty search input
			if (forms[i].id === 'searchForm') {
					forms[i].onsubmit = function (e) {
					input = this.getElementsByClassName('input')[0];
					if (input.value.trim().length < 1) {
						input.focus();
						e.preventDefault();
					}
				}
			};
			// Multiple choice forms
			if (optionTitles.length > 1) {
				// show / hide form sections
				function updateSections() {
					for (var j = 0; j < optionTitles.length; j++) {
						elementSections = forms[i].getElementsByClassName(optionTitles[j].getAttribute('data-select'));
						for (var k = 0; k < elementSections.length; k++)
							elementSections[k].style.display = !optionTitles[j].querySelectorAll('input[type=radio]')[0].checked ? 'none' : 'block';
					}
				};
				// Move form options together
				for (var j = 0; j < optionTitles.length; j++) {
					optionTitle = optionTitles[j];
					optionTitles[0].parentNode.insertBefore(optionTitle, optionTitles[0].nextSibling);
					optionTitle.querySelectorAll('input[type=radio]')[0].onchange = function () {
						updateSections();
					}
				}
				updateSections();
			}
		}
	},
	headerUtil = function (menu) {
		menu = menu || d.querySelectorAll('.menu ol > li > a');
		// Always show header on scroll
		window.onscroll = function () {
			d.body.className = window.pageYOffset > 15 ? 'fixed' : '';
		};
	},
	miniBasketUtil = function (minibasket, display) {
		var basketForm;
		minibasket = minibasket || d.getElementById('basketLink');
		if (minibasket == null) {
			return;
		}
		function showBasket(display) {
			minibasket.className += ' preview';
			setTimeout(function(){
				minibasket.className = minibasket.className.replace(' preview', '');
			 }, display);
		}
		beesden.xmlRequest(minibasket.firstChild.href, function(x) {
			minibasket.innerHTML = x.responseText;
			basketUtil(minibasket.lastChild);
			if (display > 0) showBasket(display);
		});
	},
	init = function () {
		basketUtil();
		formUtil();
		miniBasketUtil();
		headerUtil();
	}
	return {
		init: init,
		minibasket: miniBasketUtil
	};
}(document);

//Custom functions for CMS use
beesden.plugins = function (d) {
	/**
	* Beesden Carousel plugin for grid items
	*
	* @method carousel
	* @param {Object} carousel The target carousel object
	* @param {String} move Max no of children to move at a time
	* @param {Integer} speed How fast the carousel rotates in seconds
	* @param {Integer} minlength Minimum amount of children required
	*/
	var carousel = function (carousel, move, speed, minlength) {
		// collect the slides and the controls
		var carousel = carousel || d.querySelectorAll('.promotion > ul')[0],
			carouselChildren = carousel.childNodes,
			prevButton = d.createElement("span"),
			nextButton = d.createElement("span"),
			slideEnable,
			slideTarget,
			count = 0;
		function moveCarousel(count) {			
			// Do not move by more carousel products than are visible
			if (count > 0) {
				count = carouselChildren[0].offsetWidth * count > carousel.offsetWidth ? Math.round(carousel.offsetWidth / carouselChildren[0].offsetWidth) : count;
				reset(count);
				carousel.style.left = -count * carouselChildren[0].offsetWidth + 'px';
				slideTarget = '0';
			} else {
				count = carouselChildren[0].offsetWidth * count < carousel.offsetWidth ? -Math.round(carousel.offsetWidth / carouselChildren[0].offsetWidth) : count;
				reset();
			}
			// Initialise carousel animation
			slideEnable = false;	
			slideTarget = carousel.offsetLeft < 0 ? 0 : count * carouselChildren[0].offsetWidth + 'px';
			carousel.style.transition = 'left ' + speed + 's ease-in-out';
			carousel.style.left = slideTarget;
		}
		// Reset timer and positions to 0
		function reset(count) {
			// Prepend / append elements if required
			for (i = 0; i < (count < 0 ? -count : count); i++) {
				if (count > 0) {
					carousel.insertBefore(carousel.lastChild, carousel.firstChild);
				} else if (count < 0) {
					carousel.insertBefore(carousel.firstChild, carousel.lastChild.nextSibling);
				}
			}
			carousel.style.transition = 'none';
			carousel.style.left = 0;
			slideEnable = true;
		}
		// Update on completion
		carousel.addEventListener('transitionend', function(){
			reset(carousel.offsetLeft < 0 ? -Math.round(carousel.offsetWidth / carouselChildren[0].offsetWidth) : 0);
		},false);
		// Add carousel controls
		prevButton.className = 'scroll button advance left';
		nextButton.className = 'scroll button advance right';
		prevButton.innerHTML = '&laquo;';
		nextButton.innerHTML = '&raquo;';
		carousel.parentNode.insertBefore(prevButton, carousel);
		carousel.parentNode.insertBefore(nextButton, carousel.nextSibling);		
		// Duplicate elements if not enough to fill carousel
		reset();
		var x = carousel.innerHTML;
		for (i = carouselChildren.length; i < 2 * minlength; i++) {
			carousel.innerHTML += x;
		}
		// Add click events to carousel controls
		prevButton.onclick = function() {
			if (slideEnable) moveCarousel(move);
		};
		nextButton.onclick = function() {
			if (slideEnable) moveCarousel(-move);
		};
	}
	/**
	* Beesden Slider plugin for rotating images etc
	*
	* @method slider
	* @param {Object} slider The target slide container
	* @param {delay} speed How long will the slider wait between auto-rotation
	* @param {Integer} speed How fast the carousel rotates: lower is faster
	*/
	var slider = function (slider, delay, speed) {
		// collect the slides and the controls
		var slider = slider || d.getElementsByClassName('slides')[0],
			slideChildren,
			slideButtons = d.createElement("ol"),
			slideButton,
			slidePrefix = 'bees-slider-',
			slideEnabled = true,
			currentSlideIndex = 1,
			nextSlideIndex = 1,
			transTimeout;
		 // Only create slider for > 1 slide
		if (slider == null || slider.childNodes.length < 2)
			return;
		// Set up slider elements
		slideChildren = slider.childNodes;
		slider.parentNode.appendChild(slideButtons);
		slideButtons.className = 'slide_nav';
		for (i=0; i < slider.childNodes.length; i++) {
			// Add the slider controls
			slideButton = d.createElement("li");
			slideButton.id = slidePrefix + 'control-' + (i+1);
			slideButton.onclick = function(){
				clickSlide(this);
			};
			slideButtons.appendChild(slideButton);	
			// Update slide styles and ids
			if (i < 1) slideChildren[i].style.opacity = 1;
			slideChildren[i].id = slidePrefix + (i + 1);
			slideChildren[i].style.transition = 'opacity ' + speed + 's';
			slideChildren[i].addEventListener('transitionend', function(){
				if (this.style.opacity == 1) {
					currentSlideIndex = nextSlideIndex;
					slideEnabled = true;
					showSlide(nextSlideIndex == slideChildren.length ? 1 : currentSlideIndex + 1);
				}
			},false);
		}
		function showSlide(slideNo, immediate) {
			if (!slideEnabled || currentSlideIndex == slideNo) return;
			// Current / next slides
			nextSlideIndex = slideNo;
			curSlide = d.getElementById(slidePrefix + currentSlideIndex);
			nextSlide = d.getElementById(slidePrefix + nextSlideIndex);
			// Process slide change
			clearTimeout(transTimeout);
			if (immediate == true) {
				transSlide();
			}
			else {
				transTimeout = setTimeout(transSlide, delay);
			}
		}
		function transSlide() {
			slideEnabled = false;
			highlight(nextSlideIndex);
			// fade out the current slide and fade in the next slide
			curSlide.style.opacity = 0;
			nextSlide.style.opacity = 1;
		}
		function clickSlide(control) {
			// Use the next slide
			showSlide(Number(control.id.substr(control.id.lastIndexOf("-") + 1)),true);
		}
		function highlight(currentSlideIndex) {
			//unhighlight all controls
			for (i=0; i < slideChildren.length; i++)
				slideButtons.childNodes[i].className = "";
			// highlight the control for the next slide
			d.getElementById(slidePrefix + 'control-' + currentSlideIndex).className = 'selected';
		}
		highlight(currentSlideIndex);
		showSlide(nextSlideIndex);
	}
	return {
		carousel: carousel,
		slider: slider
	};
}(document);

/** Beesden Category List Functions */
beesden.grids = function(d) {
	/**
	* Beesden Pagination plugin for paginated pages
	*
	* @method pagination
	*/	
	pagination = function () {
		var container = d.getElementsByClassName('summaryContainer'),
			linkList,
			overlay = d.getElementById("overlay"),
			sortOrders,
			link;		
		// Update content and reinitialise scripts
		var updateContent = function(data) {
			d.getElementById('info').innerHTML = data.responseText;
			init();			
		}
		for (i = 0; i < container.length; i++) {
			// Make link elements ajaxable			
			linkList = container[i].getElementsByTagName('a');
			for (var j = 0; j < linkList.length; j++) {
				linkList[j].onclick = function() {
					overlay.style.height = '100%';
					overlay.style.opacity = 1;
					window.history.pushState(null, null, this.href);
					beesden.xmlRequest(this.href, updateContent);
					return false;
				}
			}
			// Make sort order select ajaxable			
			sortOrders = container[i].getElementsByTagName('select');
			for (var j = 0; j < sortOrders.length; j++) {
				sortOrders[j].nextElementSibling.style.display = 'none';
				sortOrders[j].onchange = function() {
					link = this.parentNode.action + beesden.serialize(this.parentNode);
					window.history.pushState(null, document.title, link);			
					beesden.xmlRequest(link, updateContent);
				}
			}
		}
		// Implements history for browser back / forward buttons
		window.onpopstate = function(event){
			beesden.xmlRequest(location.href, updateContent);
		}
	},
	/**
	* Beesden Gridloader plugin for category pages
	*
	* @method preview
	* @param {Object} category Category list to add inline product info to
	*/	
	preview = function (category) {	
		var products = category.childNodes,
			gridLoader = d.createElement("div");
		gridLoader.className = 'gridLoader';
		for (i = 0; i < products.length; i++) {
			products[i].firstChild.onclick = function() {
				var link = this;
				if (this.parentNode.className.indexOf('highlight') > -1) {
					// Hide gridLoader if already active
					this.parentNode.className = this.parentNode.className.replace('highlight', '');					
				} else {
					// Remove highlight from siblings
					for (var j = 0; j < products.length; j++) {
						products[j].className = products[j].className.replace('highlight', '');	
					}
					this.parentNode.className += 'highlight';
					// Fetch product info and insert inline into category
					beesden.xmlRequest(this.href, function(data) {
						gridLoader.innerHTML = data.responseText;
						link.parentNode.insertBefore(gridLoader, link.nextSibling);
						beesden.product.init(gridLoader);
					});
				}
				return false;
			}
		}
	},
	init = function () {
		pagination();
		var category = d.getElementById('category');
		if (category) preview(category);	
	}
	return {
		init: function() {
			init();
		}
	};
}(document);

/** Beesden Product Functions */
beesden.product = function(d) {
	/**
	* Beesden Product Form ajax plugin for product pages
	*
	* @method addToBasket
	* @param {Object} product Adds purchasable product to basket
	* @param {Integer} popup How long the basket shows after submit
	*/
	var addToBasket = function (product, popup) {
		var productForm = product.querySelectorAll('#basketItem')[0],
			xmlhttp = new XMLHttpRequest();		
		productForm.onsubmit = function() {
			// Add new product to basket via AJAX
			beesden.xmlRequest(productForm.action, function(data) {
				beesden.global.minibasket(null, popup);
			}, beesden.serialize(productForm), 'POST');
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
		var productImage = product.querySelectorAll('#productImages .large')[0],
			smallImages = product.querySelectorAll('#productImages .small')[0];
		for (i = 0; i < smallImages.childNodes.length; i++) {
			smallImages.childNodes[i].onclick = function() {
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
	var social = function (socialLinks) {
		function load(url) {
			var script = d.createElement("script"),
				insert = d.getElementsByTagName("body")[0];			
			script.type = "text/javascript";
			script.async = true;
			script.src = url;
			insert.appendChild(script);
		}
		window.___gcfg = {lang:"en-GB"};
		load("//connect.facebook.net/en_GB/all.js#xfbml=1", "social-fb");
		load("//platform.twitter.com/widgets.js", "social-tw");
		load("//apis.google.com/js/plusone.js", "social-gp");
		load("//assets.pinterest.com/js/pinit.js", "social-pi");
		socialLinks.style.display = "block";
	}
	/**
	* Beesden Zoom plugin for product pages
	*
	* @method zoom
	* @param {Object} product The target product page
	*/
	var zoom = function (product) {
		var productImage = product.querySelectorAll('#productImages .large a')[0],
			zoomImage = d.createElement("img"),
			topRatio,
			leftRatio;
		// Prevent multiple zoom images
		if (productImage.querySelectorAll('.zoomImage').length) return;
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
			zoom(product);		
			var social = d.getElementById("socialShare");
			if (social.length) social(social);	
		}
	};
}(document);

// Generic AJAX request function
beesden.xmlRequest = function(link, callback, json, method) {
	var xmlhttp = new XMLHttpRequest();	
	method = method ? method : 'GET';
	// Set ajax parameter to 'true'
	link = link.replace(/[?&]ajax=([^&]*)/, '');
	link = link + (link.indexOf('?') > -1 ? '&' : '?') + 'ajax=true';
	// submit ajax request function
	xmlhttp.onreadystatechange = function () {
		if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
			if (callback && typeof(callback) === "function") {
			 callback(xmlhttp);
		  }
		}
	};
	// ajax request settings
	xmlhttp.open(method, link, true);
	xmlhttp.setRequestHeader("Cache-Control","no-cache");
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(json);
}

//Convert form data into serialized json
beesden.serialize = function(form) {
  var query = [];
  for (i = 0; i < form.elements.length; i++) {
	 j = form.elements[i];
	 if (j.nodeName == 'INPUT' || j.nodeName == 'BUTTON') {
		 if (j.type == 'radio' || j.type == 'checkbox') {
			 if (form.elements[i].checked) query.push(form.elements[i].name + "=" + encodeURIComponent(form.elements[i].value));
		 } else if (j.type != 'submit') {
			 query.push(form.elements[i].name + "=" + encodeURIComponent(form.elements[i].value));
		 }
	 } else if (j.nodeName == 'SELECT') {
		 query.push(form.elements[i].name + "=" + encodeURIComponent(form.elements[i].value));
	 } else if (j.nodeName == 'TEXTAREA') {
		 query.push(form.elements[i].name + "=" + encodeURIComponent(form.elements[i].value));
	 }
  }
  return query.join("&");
}

document.addEventListener('DOMContentLoaded', function() {
	var gridLayout = document.getElementById('updateContent'),
		product = document.getElementById('product'),
		carousel = document.getElementsByClassName('slides')[0],
		promotion = document.querySelectorAll('.promotion > ul')[0];
	beesden.global.init();	
	if (gridLayout != null) beesden.grids.init(gridLayout);
	if (product != null) beesden.product.init(product);
	if (carousel != null) beesden.plugins.slider(carousel, 3000, 1.5);
	if (promotion != null) beesden.plugins.carousel(promotion, 6, 1, 6);	
});