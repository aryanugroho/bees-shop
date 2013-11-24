<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
<c:when test="${content.status == 1}">

	<store:product object="${content}" />

	<div id="socialShare">
		<ul>
			<li><div id="fb-root"></div><div class="fb-like" data-width="450" data-layout="button_count" data-show-faces="false" data-send="false"></div></li>
			<li><a href="https://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a></li>
			<li><div class="g-plusone" data-size="medium" data-annotation="none"></div></li>
			<li><a href="//pinterest.com/pin/create/button/?url=http%3A%2F%2Fwww.flickr.com%2Fphotos%2Fkentbrew%2F6851755809%2F&media=http%3A%2F%2Ffarm8.staticflickr.com%2F7027%2F6851755809_df5b2051c9_z.jpg&description=Next%20stop%3A%20Pinterest" data-pin-do="buttonPin" data-pin-config="none">Pin</a></li>
		</ul>
	</div>

</c:when>

<c:otherwise>
	<h1><fmt:message key="bees.storeproduct.not.available" /></h1>
	<p class="element"><fmt:message key="bees.storeproduct.not.available.message" /></p>
	<p class="element"><a class="button return" href="${url.ref}"><fmt:message key="bees.storeproduct.return" /></a></p>
</c:otherwise>
</c:choose>