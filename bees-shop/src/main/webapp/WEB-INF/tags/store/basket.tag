<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="basket" type="org.beesden.model.Order" required="true" %>
<%@ attribute name="editable" type="java.lang.Boolean" %>
<%@ attribute name="summary" type="java.lang.Boolean" %>

<c:if test="${summary}">
	<ul class="table orderAddress">
		<li><div>
			<h2><fmt:message key="bees.basket.delivery.address" /></h2>
			<span><strong>${basket.deliveryAddress.firstname} ${basket.deliveryAddress.surname}</strong></span>
			<store:address address="${basket.deliveryAddress}" type="span" />
		</div></li>
		<li><div>
			<h2><fmt:message key="bees.basket.billing.address" /></h2>
			<span><strong>${basket.paymentAddress.firstname} ${basket.paymentAddress.surname}</strong></span>
			<store:address address="${basket.paymentAddress}" type="span" />
		</div></li>
		<li><div>
			<h2><fmt:message key="bees.basket.payment.details" /></h2>
			<span>Good Karma</span>
		</div></li>
	</ul>
</c:if>

<ul class="items">
	<c:if test="${fn:length(basket.items) == 0}">
		<li class="row empty"><fmt:message key="bees.basket.payment.details" /></li>
	</c:if>
	
	<c:forEach var="item" items="${basket.items}" varStatus="status">	
		<li class="row">
		
			<div class="lineInfo">
				<div class="quantity">
					<c:choose>
						<c:when test="${editable}">
							<form:button type="remove" name="remove-${status.index}" class="remove"><fmt:message key="bees.basket.remove" /></form:button>
							<form:input data-value="${item.quantity}" class="input number" type="number" min="0" step="1" path="items[${status.index}].quantity" />
							<form:button type="update" name="update" class="link update"><fmt:message key="bees.basket.update" /></form:button>
						</c:when>
						<c:otherwise><span class="number"><fmt:message key="bees.basket.quantity" /> ${item.quantity}</span></c:otherwise>
					</c:choose>
				</div>
				<span class="total"><fmt:formatNumber value="${item.price * item.quantity}" currencySymbol="&pound;" type="currency"/></span>
			</div>
						
			<a class="image" href="/product/${util:url(item.product.name)}">
				<img src="/assets/client/product/small/${util:url(item.product.name)}.jpg" alt="${object.heading}" />
			</a>
			<div class="information">
				<span class="name">${item.product.heading}</span>
				<span class="variant">${item.variant.heading}</span>
				<span class="price"><fmt:formatNumber value="${item.price}" currencySymbol="&pound;" type="currency"/></span>
			</div>
		</li>
	</c:forEach>
</ul>

<c:if test="${fn:length(basket.items) > 0}">	
	<ul class="totals">
		<li class="row">
			<span class="title"><fmt:message key="bees.basket.sub.total" /></span>
			<span class="total"><fmt:formatNumber value="${basket.subTotal}" currencySymbol="&pound;" type="currency"/></span>
		</li>
		<c:if test="${!empty basket.deliveryCharge}">
			<li class="row">
				<span class="title">${basket.deliveryCharge.name}:</span>
				<span class="total"><fmt:formatNumber value="${basket.deliveryCharge.charge}" currencySymbol="&pound;" type="currency"/></span>
			</li>
		</c:if>
		<c:if test="${basket.subTotal != basket.total}">
			<li class="row">
				<span class="title"><fmt:message key="bees.basket.total" /></span>
				<span class="total strong"><fmt:formatNumber value="${basket.total}" currencySymbol="&pound;" type="currency"/></span>
			</li>
		</c:if>
	</ul>	

	<c:if test="${pageType == 'checkout-payment' && !empty basket.deliveryAddress}">
		<div class="address">
			<ul>
				<li><strong><fmt:message key="bees.basket.delivery.address" /></strong>
				<store:address address="${basket.deliveryAddress}" type="li" />
			</ul>
		</div>
	</c:if>
</c:if>