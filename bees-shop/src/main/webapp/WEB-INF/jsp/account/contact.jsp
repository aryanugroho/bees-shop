<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<p><fmt:message key="bees.account.update.details" /></p>
<p><fmt:message key="bees.account.login.details" /></p>

<form action="/account/update" method="POST">

	<%-- Update customer parameters --%>
	<input type="hidden" name="updateCustomer" value="true" />
	<input type="hidden" name="layout" value="${layout}" />


	<jsp:include page="../forms/customer.jsp" />
	<jsp:include page="../forms/email.jsp" />
	<button class="button advance"><fmt:message key="forms.button.update" /></button>
</form>