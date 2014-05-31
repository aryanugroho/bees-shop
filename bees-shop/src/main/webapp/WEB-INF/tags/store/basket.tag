	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="basket" type="org.beesden.shop.model.Basket" required="true" %>
<%@ attribute name="editable" type="java.lang.Boolean" %>
<%@ attribute name="checkout" type="java.lang.Boolean" %>

<ul class="items">
	
	<c:forEach var="item" items="${basket.items}" varStatus="status">	
		<li class="row">
		
			<div class="itemInfo">
				<span class="total">
					<fmt:formatNumber value="${item.price * item.quantity}" currencySymbol="&pound;" type="currency"/>
				</span>
				<c:if test="${editable}">
					<span><a class="remove" href="/checkout/basket/update?productId=${fn:toLowerCase(item.variant.name)}&quantity=0" class="remove link"><fmt:message key="bees.basket.remove" /></a></span>
				</c:if>
			</div>
						
			<a class="image" href="/product/${util:url(item.variant.product.name)}">
				<img src="/assets/client/products/small/${util:url(item.variant.product.name)}.jpg" alt="${object.heading}" />
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
	<dl class="totals">
		<dt><fmt:message key="bees.basket.sub.total" /></dt>
		<dd><fmt:formatNumber value="${basket.subTotal}" currencySymbol="&pound;" type="currency"/></dd>

		<c:if test="${checkout || !empty basket.orderPlaced}">
			<c:if test="${!empty basket.deliveryChargePrice}">
				<dt>
					<c:choose>
						<c:when test="${!empty basket.orderPlaced}">${basket.deliveryChargeName}:</c:when>
						<c:otherwise><a class="edit" href="/checkout/delivery">${basket.deliveryCharge.name}</a></c:otherwise>
					</c:choose>
				</dt>
				<dd><fmt:formatNumber value="${basket.deliveryChargePrice}" currencySymbol="&pound;" type="currency"/></dd>
			</c:if>
			<dt><fmt:message key="bees.basket.total" /></dt>
			<dd><fmt:formatNumber value="${basket.total}" currencySymbol="&pound;" type="currency"/></dd>
		</c:if>
	</dl>	
</c:if>

<c:if test="${!empty basket.deliveryAddress}">
	<h3>
		<fmt:message key="bees.basket.delivery.address" />
		<c:if test="${empty basket.orderPlaced}"><a class="edit" href="/checkout/shipping"><fmt:message key="bees.checkout.edit" /></a></c:if>
	</h3>
	<address>
		<store:address address="${basket.deliveryAddress}" type="span" />
	</address>
</c:if>	

<c:if test="${!empty basket.paymentDetails && !empty basket.paymentDetails.address}">
	<h3>
		<fmt:message key="bees.basket.payment.address" />
		<c:if test="${empty basket.orderPlaced}"><a class="edit" href="/checkout/payment"><fmt:message key="bees.checkout.edit" /></a></c:if>
	</h3>
	<address>
		<store:address address="${basket.paymentDetails.address}" type="span" />
	</address>
</c:if>