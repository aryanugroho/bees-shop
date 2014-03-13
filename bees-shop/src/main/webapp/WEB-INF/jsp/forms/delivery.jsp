<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset>
	<legend><fmt:message key="bees.delivery.delivery.charge" /></legend>
	<store:input name="deliveryCharge" type="select">
		<c:forEach var="charge" items="${deliveryCharges}">
			<fmt:formatNumber var="chargePrice" type="currency" value="${charge.charge}" currencySymbol="&pound;" />
			<fmt:message key="bees.checkout.free" var="chargeFree" />
			<c:set var="selected" value="${basket.deliveryCharge.id == charge.id ? 'selected' : ''}" />
			<option ${selected} value="${charge.id}">${charge.name} - ${charge.charge == 0 ? chargeFree : chargePrice}</option>
		</c:forEach>
	</store:input>
</fieldset>