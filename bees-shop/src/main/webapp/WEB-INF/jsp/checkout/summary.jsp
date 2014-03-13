<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:set var="addressForm" value="${basket.paymentDetails.address}" scope="request" />

<form action="/checkout/submit" method="POST">	

	<h2>Payment information:</h2>
	<p><strong>Payment card:</strong> ${basket.paymentDetails.name}</p>

	<fieldset>
		<store:input type="checkbox" name="termsAgree" value="true" />
	</fieldset>

	<button class="button advance"><fmt:message key="bees.checkout.place.order" /></button>
	
</form>