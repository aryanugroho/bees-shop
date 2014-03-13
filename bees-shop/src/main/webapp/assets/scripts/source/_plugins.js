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
		var carousel = carousel || d.querySelectorAll('.promotion ul')[0],
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