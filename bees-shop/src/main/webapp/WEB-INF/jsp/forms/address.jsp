<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<store:input type="hidden" name="editAddressId" value="${addressForm.id}" />

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.delivery.your.address" /></legend>
	<store:input name="address1" value="${addressForm.address1}" />
	<store:input name="address2" value="${addressForm.address2}" />
	<store:input name="address3" value="${addressForm.address3}" />
	<store:input name="city" value="${addressForm.city}" />
	<store:input name="region" value="${addressForm.region}" />
	<store:input name="postalCode" value="${addressForm.postalCode}" />
	<store:input name="country" type="select">
		<c:forEach var="country" items="${countries}">
			<option label="${country.name}" value="${country.iso2}" />
		</c:forEach>
	</store:input>
</fieldset>