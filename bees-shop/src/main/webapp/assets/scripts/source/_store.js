beesden.store = function (d) {


	var basketUpdate = function(update, load) {

		var minibasket = d.getElementById('basketLink'),
			basket = d.getElementById('basket');

		// Update basket html
		beesden.ajax('/checkout/basket?minibasket=true', function(data) {
			minibasket.innerHTML = data.responseText;
			basketLinks(minibasket);
		});

		if (update && basket) {
			beesden.ajax('/checkout/basket', function(data) {
				basket.outerHTML = data.response;
				basketLinks();
			});
		}

	},

	basketLinks = function (basket) {
		var basketLinks,
			basketLink;
		basket = basket || d.getElementById('basket');

		// Check if basket is valid
		if (!basket) {
			return;
		}

		// Check for at least one link
		basketLinks = basket.querySelectorAll('.increase, .decrease, .remove');
		if (!basketLinks) {
			return;
		}

		// Add the ajax request to all links
		for (i = 0; i < basketLinks.length; i++) {
			basketLink = basketLinks[i];
			basketLink.onclick = function() {
				beesden.ajax(this.href, function(data) {
					basketUpdate(true);
				})
				return false;
			}
		}
	}

	return {
		init: function() {
			basketLinks();
			basketLinks(d.getElementById('basketLink'))
		},
		minibasket: basketUpdate
	};
	
}(document);