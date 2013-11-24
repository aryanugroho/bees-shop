<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="object" type="org.beesden.model.Category" required="true" %>

<store:pagination sortKey="products" pagination="${categoryPagination}" summary="true" />

<ul class="grid category" id="category">

	<c:forEach var="product" items="${content.products}" varStatus="status">

	<li>
		<a class="ajax" href="/product/${util:url(product.name)}">
			<span class="image"><img src="/assets/client/product/small/${util:url(product.name)}.jpg" alt="${product.heading}" /></span>
			<c:if test="${product.availability=='2'}"><span class="offer"><fmt:message key="bees.product.special.offer" /></span></c:if>
			<c:if test="${product.availability=='3'}"><span class="offer"><fmt:message key="bees.product.sold.out" /></span></c:if>
			<span class="title">${product.heading}</span>
			<span class="price">
				<fmt:message key="bees.product.from">
					<fmt:param><fmt:formatNumber value="${product.minPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
				</fmt:message>
			</span>
		</a>
	</li>

	</c:forEach>
</ul>

<store:pagination sortKey="products" pagination="${categoryPagination}" />