<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:if test="${param.minibasket}">	
	<c:set var="basketSize" value="0" />	
	<c:forEach items="${basket.items}" var="item">
		<c:set var="basketSize" value="${basketSize + item.quantity}" />
	</c:forEach>
	<a href="/checkout/basket" title="View basket" class="viewBasket">
		<span><fmt:message key="bees.basket.link">
			<fmt:param>${basketSize}</fmt:param>
		</fmt:message></span>
	</a>
</c:if>

<div class="basket" id="${param.minibasket ? 'minibasket' : 'basket'}">

<h1><fmt:message key="bees.basket.title" /></h1>
	
<store:basket basket="${basket}" editable="true" />

<ul class="action">
	<c:if test="${fn:length(basket.items) < 1}">
		<li class="alert alertWarning"><fmt:message key="bees.basket.min.quantity" /></li>
	</c:if>
	<c:if test="${fn:length(basket.items) > 0 && basket.subTotal < config.minOrderValue}">
		<li class="alert alertWarning">
			<fmt:message key="bees.basket.min.value">
				<fmt:param><fmt:formatNumber value="${config.minOrderValue}" currencySymbol="&pound;" type="currency"/></fmt:param>
			</fmt:message></li>
	</c:if>
	<li>
		<c:choose>
			<c:when test="${param.minibasket}">
				<a class="button advance" href="/checkout/basket"><fmt:message key="bees.basket.view.basket" /></a>
			</c:when>
			<c:when test="${fn:length(basket.items) == 0 || basket.subTotal < config.minOrderValue}">
				<a class="button return" href="/"><fmt:message key="bees.basket.return" /></a>
			</c:when>
			<c:otherwise>	
				<a class="button advance" href="/checkout/delivery"><fmt:message key="bees.basket.checkout" /></a>
			</c:otherwise>
		</c:choose>
	</li>
</ul>
</div>