<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:set var="addressForm" value="${basket.deliveryAddress}" scope="request" />

<form action="/checkout/shipping" method="POST">	

	<input type="hidden" name="addressType" value="delivery" />
	<c:if test="${empty customer.addresses}">
		<input type="hidden" name="selectAddress" value="createAddress" />
	</c:if>

	<c:if test="${!empty customer.addresses}">
		<store:input cssClass="formSelect" name="selectAddress" type="radio" value="existingAddress" />
		<jsp:include page="../forms/addresses.jsp" />
		<button class="button advance jsHide"><fmt:message key="bees.delivery.continue" /></button>
		<store:input cssClass="formSelect" name="selectAddress" type="radio" value="createAddress" />
	</c:if>

	<jsp:include page="../forms/customer.jsp">
		<jsp:param name="fieldClass" value="createAddress" />
	</jsp:include>

	<jsp:include page="../forms/address.jsp">
		<jsp:param name="fieldClass" value="createAddress" />
	</jsp:include>

	<button class="button advance"><fmt:message key="bees.checkout.continue" /></button>
	
</form>