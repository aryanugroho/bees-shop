<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="object" type="org.beesden.shop.model.Category" required="true" %>

<ul class="grid department" id="department">

	<c:forEach var="category" items="${object.children}" varStatus="status">
	<li>
		<a class="ajax" href="/category/${util:url(category.name)}">
			<span class="title">${category.heading}</span>
			<span class="image"><img src="/assets/client/category/${util:url(category.name)}.jpg" alt="${category.heading}" /></span>			
		</a>
	</li>

	</c:forEach>
</ul>