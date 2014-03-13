<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="currentDate" pattern="yyyy-MM" value="${currentDate}" />

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.delivery.your.details" /></legend>
	<store:input name="cardType" type="select">		
		<option label="VISA" value="VISA">
		<option label="MasterCard" value="MasterCard">
		<option label="Maestro" value="Maestro">
	</store:input>
	<store:input name="cardNumber" placeholder="xxxx-xxxx-xxxx-xxxx" />
	<store:input name="startDate" type="month" maxDate="${currentDate}" />
	<store:input name="expiryDate" type="month" minDate="${currentDate}" />
	<store:input name="securityCode" />
</fieldset>