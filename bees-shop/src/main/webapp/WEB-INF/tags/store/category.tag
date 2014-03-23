<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="object" type="java.lang.Object" required="true" %>
<%@ attribute name="display" type="java.lang.String" required="false" %>

<c:set var="display" value="${!empty display ? display : 'list'}" />

<ul class="category ${display}" id="category">
	<c:forEach var="product" items="${object}" varStatus="status">
		<c:set var="product" value="${product[0]}" />
		<li>
			<%-- Product Image --%>
			<a class="image" href="/product/${util:url(product.name)}">
				<img src="/assets/client/products/${display == 'list' ? 'small' : 'medium'}/${util:url(product.name)}.jpg" alt="${product.heading}" />
			</a>
			<%-- Product Information --%>				
			<div class="info">
				<%-- Product Title --%>
				<div class="summary">
					<a class="title" href="/product/${util:url(product.name)}">${product.heading}</a>
					<c:if test="${display == 'list'}"><span class="code">Quick link: <strong>${product.name}</strong></span></c:if>
				</div>
				<div class="feature">
					<span class="price">
						<fmt:message key="bees.product.${product.minPrice < product.maxPrice ? 'from' : 'price' }">
							<fmt:param><fmt:formatNumber value="${product.minPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${product.maxPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
						</fmt:message>
					</span>
					<c:if test="${display == 'list'}">
						<span class="stock"><fmt:message key="bees.product.stock.${product.stock > 0}" /></span>
					</c:if>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>