<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.login.register" /></legend>
	<store:input name="email" type="email" />
	<store:input name="password" type="password" />
	<store:input name="password_confirm" type="password" />
</fieldset>