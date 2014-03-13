<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<datalist id="titleAuto">
	<option label="Mr" value="Mr">
	<option label="Mrs" value="Mrs">
	<option label="Miss" value="Miss">
	<option label="Ms" value="Ms">
	<option label="Dr" value="Dr">
	<option label="Prof" value="Prof">
</datalist>

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.delivery.your.details" /></legend>
	<store:input name="title" list="titleAuto" value="${!empty addressForm.title ? addressForm.title : customer.title}" />
	<store:input name="firstname" value="${!empty addressForm.firstname ? addressForm.firstname : customer.firstname}" />
	<store:input name="surname" value="${!empty addressForm.surname ? addressForm.surname : customer.surname}" />
	<store:input name="telephone" type="tel" value="${!empty addressForm.telephone ? addressForm.telephone : customer.telephone}" />
</fieldset>