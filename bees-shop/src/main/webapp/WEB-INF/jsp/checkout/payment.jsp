<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:set var="addressForm" value="${basket.paymentDetails.address}" scope="request" />

<form action="/checkout/payment" method="POST">	

	<input type="hidden" name="addressType" value="payment" />
	<c:if test="${empty customer.tenders}">
		<input type="hidden" name="updatePayment" value="newTender" />		
	</c:if>
	<c:if test="${empty customer.addresses}">
		<input type="hidden" name="selectAddress" value="createAddress" />		
	</c:if>

	<%-- Saved payment method --%>
	<c:if test="${!empty customer.tenders}">
		<store:input cssClass="formSelect" name="updatePayment" type="radio" value="savedTender" />
		<store:input cssClass="formSelect" name="updatePayment" type="radio" value="newTender" />

		<%-- Saved card --%>
		<jsp:include page="../forms/paymentSaved.jsp">
			<jsp:param name="fieldClass" value="savedTender" />
		</jsp:include>
	</c:if>

	<%-- New card --%>
	<jsp:include page="../forms/paymentNew.jsp">
		<jsp:param name="fieldClass" value="createAddress existingAddress newTender" />
	</jsp:include>

	<%-- Address toggle options --%>
	<c:if test="${!empty customer.addresses}">
		<store:input cssClass="formSelect" name="selectAddress" type="radio" value="existingAddress" />
		<store:input cssClass="formSelect" name="selectAddress" type="radio" value="createAddress" />

		<%-- Saved address --%>
		<jsp:include page="../forms/addresses.jsp">
			<jsp:param name="fieldClass" value="existingAddress newTender" />
		</jsp:include>
	</c:if>

	<%-- New Address --%>
	<jsp:include page="../forms/customer.jsp">
		<jsp:param name="fieldClass" value="createAddress newTender" />
	</jsp:include>

	<jsp:include page="../forms/address.jsp">
		<jsp:param name="fieldClass" value="createAddress newTender" />
	</jsp:include>

	<button class="button advance"><fmt:message key="bees.checkout.continue" /></button>
	
</form>