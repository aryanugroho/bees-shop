<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:if test="${param.ajax}">	
	<c:set var="basketSize" value="0" />	
	<c:forEach items="${basket.items}" var="item">
		<c:set var="basketSize" value="${basketSize + item.quantity}" />
	</c:forEach>
	<a href="/checkout/basket" title="View basket" class="viewBasket"><span><fmt:message key="bees.basket.link" /> (${basketSize})</span></a>
</c:if>

<form:form class="basket" id="${param.ajax ? 'minibasket' : 'basket'}" action="/checkout/basket/update" method="POST" modelAttribute="basket">

<h1><fmt:message key="bees.basket.title" /></h1>
	
<store:basket basket="${basket}" editable="true" />

<ul class="action">
	<c:if test="${fn:length(basket.items) < 1}">
		<li class="warning"><fmt:message key="bees.basket.min.quantity" /></li>
	</c:if>
	<c:if test="${fn:length(basket.items) > 0 && basket.subTotal < config.minOrderValue}">
		<li class="warning">
			<fmt:message key="bees.basket.min.value">
				<fmt:param><fmt:formatNumber value="${config.minOrderValue}" currencySymbol="&pound;" type="currency"/></fmt:param>
			</fmt:message></li>
	</c:if>
	<li>
		<c:choose>
			<c:when test="${!param.ajax}">
				<a class="button return" href="/"><fmt:message key="bees.basket.return" /></a>
				<c:if test="${fn:length(basket.items) != 0 && basket.subTotal >= config.minOrderValue}">
					<a class="button advance" href="/checkout/delivery"><fmt:message key="bees.basket.checkout" /></a>
				</c:if>
			</c:when>
			<c:otherwise>
				<a class="button return" href="/checkout/basket"><fmt:message key="bees.basket.view.basket" /></a>
			</c:otherwise>
		</c:choose>
	</li>
</ul>
</form:form>

<c:if test="${!param.ajax && !empty promotions}">	
	<jsp:include page="../template/promotions.jsp" />
</c:if>