<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.delivery.your.email" /></legend>	
	<store:input name="currentEmail" disabled="true" value="${!empty addressForm.email ? addressForm.email : customer.email}" />
	<store:input name="email" type="email" />
	<store:input name="email2" type="email" />
</fieldset>