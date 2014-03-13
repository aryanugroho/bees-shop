<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.login.login" /></legend>
	<store:input name="j_username" type="email" label="forms.email" />
	<store:input name="j_password" type="password" label="forms.password" />
	<a href="#"><fmt:message key="bees.login.forgotten.password" /></a>
</fieldset>