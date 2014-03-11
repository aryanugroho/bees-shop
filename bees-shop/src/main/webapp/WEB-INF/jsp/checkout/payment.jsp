<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<form action="/checkout/payment" method="POST">	

	<c:if test="${!empty customer.addresses}">
		<store:input cssClass="formSelect" name="selectAddress" type="radio" id="existingAddress" value="existingAddress" />
		<jsp:include page="../forms/addresses.jsp" />
		<button class="button advance jsHide"><fmt:message key="bees.delivery.continue" /></button>
		<store:input cssClass="formSelect" name="selectAddress" type="radio" id="createAddress" value="createAddress" />
	</c:if>

	<jsp:include page="../forms/customer.jsp">
		<jsp:param name="addressForm" value="${basket.deliveryAddress}" />
	</jsp:include>

	<jsp:include page="../forms/address.jsp">
		<jsp:param name="addressForm" value="${basket.deliveryAddress}" />
	</jsp:include>

	<button class="button advance"><fmt:message key="bees.delivery.continue" /></button>
	
</form>