<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:set var="addressForm" value="${basket.deliveryAddress}" scope="request" />

<form action="/checkout/delivery" method="POST">	

	<jsp:include page="../forms/delivery.jsp" />

	<button class="button advance"><fmt:message key="bees.checkout.continue" /></button>
	
</form>