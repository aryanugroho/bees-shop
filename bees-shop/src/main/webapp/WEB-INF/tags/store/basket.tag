<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="basket" type="org.beesden.shop.model.Basket" required="true" %>
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
	
	<c:forEach var="item" items="${basket.items}" varStatus="status">	
		<li class="row">
		
			<div class="itemInfo">
				<span class="total">
					<fmt:formatNumber value="${item.price * item.quantity}" currencySymbol="&pound;" type="currency"/>
				</span>
				<span><a class="remove" href="/checkout/basket/update?productId=${fn:toLowerCase(item.variant.name)}&quantity=0" class="remove link"><fmt:message key="bees.basket.remove" /></a></span>
			</div>
						
			<a class="image" href="/product/${util:url(item.variant.product.name)}">
				<img src="/assets/client/product/small/${util:url(item.variant.product.name)}.jpg" alt="${object.heading}" />
			</a>
			<div class="productInfo">
				<a href="/product/${util:url(item.variant.product.name)}" class="name">${item.variant.heading}</a>
				<span class="code">
					<fmt:message key="bees.basket.code">
						<fmt:param>${item.variant.name}</fmt:param>
					</fmt:message>
				</span>

				<div class="quantity">
					<c:if test="${editable}">
						<a class="decrease" href="/checkout/basket/update?productId=${fn:toLowerCase(item.variant.name)}&quantity=${item.quantity - 1}">
							<em><fmt:message key="bees.basket.quantity.decrease" /></em>
						</a>
					</c:if>
					<c:if test="${!editable}">
						<fmt:message key="bees.basket.quantity" />
					</c:if>
					<span class="${editable ? 'editable' : 'number'}">${item.quantity}</span>
					<c:if test="${editable}">
						<a class="increase" href="/checkout/basket/update?productId=${fn:toLowerCase(item.variant.name)}&quantity=${item.quantity + 1}">
							<em><fmt:message key="bees.basket.quantity.increase" /></em>
						</a>
					</c:if>
				</div>
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