<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:url var="target" value="" />

<h1><fmt:message key="bees.payment.title" /></h1>

<form:form class="form checkout" id="payment" action="/checkout/payment" method="POST" modelAttribute="basket">

	<ol class="section">
		<li class="title"><fmt:message key="bees.payment.card.details" /></li>
	</ol>

	<h2 class="formSelect" data-active="true" data-select="existingAddress">
		<input checked="checked" type="radio" name="selectAddress" id="existingAddress" value="existingAddress" />
		<label for="existingAddress"><fmt:message key="bees.payment.use.existing" /></label>
	</h2>

	<ol class="section existingAddress">
		<li class="title"><fmt:message key="bees.payment.use.existing" /></li>
		<li><form:label path="paymentAddress.id"><fmt:message key="bees.payment.select.address" /></form:label>
		</li>
		<li>
			<form:select cssClass="select input" path="paymentAddress.id">
				<c:forEach var="address" items="${customer.addressLink}">
					<option ${address.id == basket.paymentAddress.id ? 'selected="selected"' : ''} value="${address.id}"><store:address address="${address}" /></option>
				</c:forEach>
			</form:select>
		</li>
	</ol>	
	
	<h2 class="formSelect" data-select="createAddress">
		<input type="radio" name="selectAddress" id="createAddress" value="createAddress" />
		<label for="createAddress"><fmt:message key="bees.payment.create.address" /></label>
	</h2>

	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.payment.payment.address" /></li>
		<li>
			<form:label cssClass="label" path="paymentAddress.line1"><fmt:message key="bees.address.address.1" /></form:label>
			<form:input cssClass="input" path="paymentAddress.line1" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.line2"><fmt:message key="bees.address.address.2" /></form:label>
			<form:input cssClass="input" path="paymentAddress.line2" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.line3"><fmt:message key="bees.address.address.3" /></form:label>
			<form:input cssClass="input" path="paymentAddress.line3" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.town"><fmt:message key="bees.address.town" /></form:label>
			<form:input cssClass="input" path="paymentAddress.town" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.county"><fmt:message key="bees.address.county" /></form:label>
			<form:input cssClass="input" path="paymentAddress.county" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.postcode"><fmt:message key="bees.address.postcode" /></form:label>
			<form:input cssClass="input" path="paymentAddress.postcode" />
		</li>
		<li>
			<form:label cssClass="label" path="paymentAddress.country"><fmt:message key="bees.address.country" /></form:label>
			<form:select cssClass="input" path="paymentAddress.country">
				<form:option value="" label="Select country" />
				<form:options itemValue="code" itemLabel="name" items="${countries}" />
			</form:select>
		</li>
	</ol>
	
	<div class="section">
		<a class="button return" href="/checkout/delivery"><fmt:message key="bees.payment.return" /></a>
		<c:if test="${fn:length(basket.items) != 0 && basket.subTotal >= config.minOrderValue}">
			<form:button value="Continue" class="button advance"><fmt:message key="bees.payment.submit" /></form:button>
		</c:if>
	</div>
		
	<div class="basket section">
		<h2><fmt:message key="bees.payment.review.your.order" /></h2>
		<store:basket basket="${basket}" />
	</div>
	
	<div class="section">
		<a class="button return" href="/checkout/delivery"><fmt:message key="bees.payment.return" /></a>
		<c:if test="${fn:length(basket.items) != 0 && basket.subTotal >= config.minOrderValue}">
			<form:button value="Continue" class="button advance"><fmt:message key="bees.payment.submit" /></form:button>
		</c:if>
	</div>

</form:form>