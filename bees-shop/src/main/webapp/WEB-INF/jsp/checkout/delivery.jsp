<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<h1><fmt:message key="bees.delivery.title" /></h1>

<form:form class="form checkout" id="delivery" action="/checkout/delivery" method="POST" modelAttribute="basket">
	
	<ol class="section">
		<li class="title"><fmt:message key="bees.delivery.delivery.charge" /></li>
		<li>
			<form:label cssClass="label" path="deliveryCharge.id"><fmt:message key="bees.delivery.delivery.charge" /></form:label>
			<form:select path="deliveryCharge.id" cssClass="input">
				<option value="0"><fmt:message key="bees.delivery.select.a.delivery.charge" /></option>
				<c:forEach items="${deliveryCharges}" var="charge" varStatus="s">
					<fmt:formatNumber var="chargePrice" value="${charge.charge}" currencySymbol="&pound;" type="currency" />
					<option ${charge.id == basket.deliveryCharge.id ? 'selected="selected"' : ''} value="${charge.id}">${charge.name}- ${chargePrice}</option>
				</c:forEach>
			</form:select>
		</li>
	</ol>
	<c:if test="${!empty customer.addressLink}">
		<h2 class="formSelect" data-active="true" data-select="existingAddress">
			<input checked="checked" type="radio" name="selectAddress" id="existingAddress" value="existingAddress" />
			<label for="existingAddress"><fmt:message key="bees.delivery.use.an.existing.address" /></label>
		</h2>
		<ol class="section existingAddress">
			<li class="title"><fmt:message key="bees.delivery.use.an.existing.address" /></li>
			<li>
				<form:label path="deliveryAddress.firstname"><fmt:message key="bees.delivery.delivery.address" /></form:label>
			</li>
			<li>
				<form:select cssClass="select input" path="deliveryAddress.id">
					<c:forEach var="address" items="${customer.addressLink}">
						<option ${address.id == basket.deliveryAddress.id ? 'selected="selected"' : ''} value="${address.id}">
							<store:address address="${address}" />
						</option>
					</c:forEach>
				</form:select>
			</li>
		</ol>
		
		<div class="section existingAddress">
			<a class="button return" href="/checkout/basket"><fmt:message key="bees.delivery.return.to.basket" /></a>
			<c:if test="${fn:length(basket.items) != 0 && basket.subTotal >= config.minOrderValue}">
				<form:button value="Continue" class="button advance"><fmt:message key="bees.delivery.continue.to.payment" /></form:button>
			</c:if>
		</div>
	
		<h2 class="formSelect" data-select="createAddress">
			<input type="radio" name="selectAddress" id="createAddress" value="createAddress" /> 
			<label for="createAddress">
				<fmt:message key="bees.delivery.create.a.new.address" />
			</label>
		</h2>
	</c:if>
	
	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.delivery.your.details" /></li>
		<li>
			<c:set var="defaultValue" value="${!empty basket.deliveryAddress.firstname ? basket.deliveryAddress.firstname : customer.firstname}" />
			<form:label cssClass="label" path="deliveryAddress.firstname"><fmt:message key="bees.address.first.name" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.firstname" value="${defaultValue}" />
		</li>
		<li>
			<c:set var="defaultValue" value="${!empty basket.deliveryAddress.surname ? basket.deliveryAddress.surname : customer.surname}" />
			<form:label cssClass="label" path="deliveryAddress.surname"><fmt:message key="bees.address.surname" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.surname" value="${defaultValue}" />
		</li>
		<li>
			<c:set var="defaultValue" value="${!empty basket.deliveryAddress.telephone ? basket.deliveryAddress.telephone : customer.telephone}" />
			<form:label cssClass="label" path="deliveryAddress.telephone"><fmt:message key="bees.address.telephone" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.telephone" value="${defaultValue}" />
		</li>
		<li>
			<c:set var="defaultValue" value="${!empty basket.deliveryAddress.email ? basket.deliveryAddress.email : customer.email}" />
			<form:label cssClass="label" path="deliveryAddress.email"><fmt:message key="bees.address.email" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.email" value="${defaultValue}" />
		</li>
	</ol>
	
	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.delivery.delivery.address" /></li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.line1"><fmt:message key="bees.address.address.1" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.line1" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.line2"><fmt:message key="bees.address.address.2" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.line2" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.line3"><fmt:message key="bees.address.address.3" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.line3" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.town"><fmt:message key="bees.address.town" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.town" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.county"><fmt:message key="bees.address.county" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.county" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.postcode"><fmt:message key="bees.address.postcode" /></form:label>
			<form:input cssClass="input" path="deliveryAddress.postcode" />
		</li>
		<li>
			<form:label cssClass="label" path="deliveryAddress.country"><fmt:message key="bees.address.country" /></form:label>
			<form:select cssClass="input" path="deliveryAddress.country">
				<form:option value="" label="Select country" />
				<form:options itemValue="code" itemLabel="name" items="${countries}" />
			</form:select>
		</li>
	</ol>
	
	<div class="section createAddress">
		<a class="button return" href="/checkout/basket"><fmt:message key="bees.delivery.return" /></a>
		<c:if test="${fn:length(basket.items) != 0 && basket.subTotal >= config.minOrderValue}">
			<form:button value="Continue" class="button advance"><fmt:message key="bees.delivery.continue" /></form:button>
		</c:if>
	</div>
	
</form:form>