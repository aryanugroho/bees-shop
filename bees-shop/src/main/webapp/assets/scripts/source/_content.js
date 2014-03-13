beesden.content = function(d) {

	/*
	 * @name	pagination
	 * @type	Function
	 * @desc	Paginate through results using AJAX instead of full page refreshes
	*/	
	pagination = function () {
		var container = d.querySelectorAll('.resultsContainer'),
			popped = ('state' in window.history && window.history.state !== null),
			initialUrl = location.href,
			linkList,
			overlay = d.getElementById("contentOverlay"),
			sortOrders,
			link;

		if (!container.length) {
			return
		}

		// Set up the overlay if it does not exist
		if (!overlay) {
			overlay = overlay || d.createElement("div");
			overlay.id = 'contentOverlay';
			container[0].parentNode.appendChild(overlay);
		}

		// Insert new content and reinitialise scripts
		 insertContent

		// Run ajax request for updated content
		function updateContent(link) {
			popped = true;
			overlay.className += (' reveal');
			beesden.ajax(location.href, function(data) {
				d.getElementById('info').innerHTML = data.responseText;
				overlay.className.replace(' reveal', '');
				pagination();			
			});		
		}

		for (i = 0; i < container.length; i++) {
			// Make link elements ajaxable			
			linkList = container[i].getElementsByTagName('a');
			for (var j = 0; j < linkList.length; j++) {
				linkList[j].onclick = function() {
					window.history.pushState(null, null, this.href);
					updateContent(link);
					return false;
				}
			}
			// Make sort order select ajaxable			
			sortOrders = container[i].getElementsByTagName('select');
			for (var j = 0; j < sortOrders.length; j++) {
				sortOrders[j].onchange = function() {
					link = this.parentNode.action + beesden.serialize(this.parentNode);
					window.history.pushState(null, document.title, link);	
					updateContent(link);		
				}
			}
		}
		// Implements history for browser back / forward buttons
		window.onpopstate = function(event){
			// Prevent reload on initial page load
			if (location.href == initialUrl && !popped) {
				return;
			}
			updateContent(link);			
		}
	}

	return {
		init: function() {
			pagination();
		}
	};
}(document);