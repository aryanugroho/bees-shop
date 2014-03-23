beesden.forms = function (d) {


	var smoothCheckout = function() {

		var container = d.getElementById('checkoutFlow'),
			response;

		if (!container) {
			return;
		}

		Array.prototype.forEach.call(container.getElementsByTagName('form'), function(el, i) {

			el.addEventListener('submit', function(e) {				
				e.preventDefault();

				beesden.ajax(this.action, function(data) {
					response = new DOMParser().parseFromString(data.response, 'text/html');
					container.innerHTML = response.getElementById('checkoutFlow').innerHTML;
				}, beesden.serialize(this), 'POST');
			});

		});

	},

	 fieldSelect = function() {

		var container,
			fields,
			input;
			
		// Toggles fieldsets with required class
		function showHide(input) {
			Array.prototype.forEach.call(d.querySelectorAll('#checkoutFlow fieldset'), function(el, i) {
				el.style.display = el.className.indexOf(input.value) < 0 ? 'none' : 'block';
			});
		}
		// Loop through the formSelect inputs
		Array.prototype.forEach.call(d.getElementsByClassName('formSelect'), function(el, i) {
			// Get the input and assign the event
			input = el.querySelector('input');
			if (!input) return;
			input.addEventListener('change', function() {
				showHide(this);
			});
			// Reorder inputs and toggle the first (should be 'select')
			if (i < 1) {
				container = d.createElement('div');
				el.parentNode.insertBefore(container, el.nextSibling);
				input.checked = true;
				showHide(input);		
			}
			container.appendChild(el);
		});

	},

	inputTidy = function () {

		Array.prototype.forEach.call(d.getElementsByTagName('input'), function(el, i) {

			if (el.type == 'hidden' || el.type == 'checkbox' || el.type == 'radio') {
				return;
			}

			el.addEventListener('blur', function() {
				this.value = this.value.trim();
			});
		});
		
	}

	return {
		init: function() {
			// smoothCheckout();
			fieldSelect();
			inputTidy();
		}
	};
	
}(document);