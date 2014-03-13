beesden.layout = function (d) {

	/*
	 * @name	menu
	 * @type	Function
	 * @desc	Adds functionality to the responsive menu
	*/	
	menu = function () {
		menuToggle = d.querySelectorAll('label.menuToggle');
		overlay = d.createElement("div");

		overlay.id = 'menuOverlay';
		d.body.appendChild(overlay);

		// Use JS events instead of checkbox as toggle for menu
		for (i = 0; i < menuToggle.length; i++) {
			menuToggle[i].onclick = function() {
				if (d.body.className.indexOf('showMenu') < 0) {
					d.body.className += ' showMenu';
				} else {
					d.body.className = d.body.className.replace(' showMenu', '')
				}
				return false;
			};
		};

		// Hide menu on outside click
		overlay.onclick = function() {
			d.body.className = d.body.className.replace(' showMenu', '');
		}
	}

	return {
		init: function () {
			menu();
		}
	};
}(document);