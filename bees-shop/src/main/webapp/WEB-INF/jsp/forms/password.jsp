<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.delivery.password" /></legend>
	<store:input name="oldPassword" type="password" />
	<store:input name="password" type="password" />
	<store:input name="password2" type="password" />
</fieldset>