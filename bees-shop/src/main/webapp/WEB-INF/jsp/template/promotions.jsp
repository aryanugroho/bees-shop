<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<section class="promotion">
	
	<h2><fmt:message key="bees.promotions.title" /></h2>
	
	<ul class="grid">
	
	<c:forEach items="${promotions}" var="promo">		
		<c:set var="promo" value="${promo[0]}" />
		<li>
			<a class="image" href="/product/${util:url(promo.name)}">
				<img src="/assets/client/product/small/${util:url(promo.name)}.jpg" alt="${promo.heading}" />
			</a>
			<span class="title"><a href="/product/${util:url(promo.name)}">${promo.heading}</a></span>
			<span class="price">
				<fmt:message key="bees.product.${promo.minPrice < promo.maxPrice ? 'from' : 'price' }">
					<fmt:param><fmt:formatNumber value="${promo.minPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${promo.maxPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
				</fmt:message>
				</span>
		</li>
	</c:forEach>
	
	</ul>

</section>