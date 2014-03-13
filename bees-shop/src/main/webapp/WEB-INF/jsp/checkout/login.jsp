<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<ol class="formSelect">
	<li><a class="formSelect" href="#checkoutLogin"><fmt:message key="bees.login.log.in" /></a></li>
	<li><a class="formSelect" href="#checkoutRegister"><fmt:message key="bees.login.register" /></a></li>
</ol>

<%-- Login form --%>
<form id="checkoutLogin" method="POST" action="/account/login.do">

	<jsp:include page="../forms/login.jsp">
		<jsp:param name="fieldClass" value="createCustomer" />
	</jsp:include>

	<button class="button advance" name="login"><fmt:message key="bees.login.log.in" /></button>
	
</form>

<%-- Register form --%>
<form id="checkoutRegister" method="POST" action="/checkout/register">

	<jsp:include page="../forms/register.jsp">
		<jsp:param name="fieldClass" value="createCustomer" />
	</jsp:include>

	<jsp:include page="../forms/customer.jsp">
		<jsp:param name="fieldClass" value="createCustomer" />
	</jsp:include>

	<button class="button advance" name="register"><fmt:message key="bees.login.register" /></button>
	
</form>