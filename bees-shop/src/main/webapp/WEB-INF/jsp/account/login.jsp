<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h1>Your account</h1>

<form class="accountLogin" id="accountLogin" method="post" action="/account/login.do">	

<h2><fmt:message key="bees.login.log.in" /></h2>	
<ol>	
	<li>
		<label class="label" for="login_email"><fmt:message key="bees.login.email" /></label>
		<input type="text" class="input" name="j_username" id="login_email" autofocus="autofocus" />
	</li>
	<li>
		<label class="label" for="login_password"><fmt:message key="bees.login.password" /></label>
		<input type="password" class="input" name="j_password" id="login_password" />
	</li>
	<%--<li><a href="#"><fmt:message key="bees.login.forgotten.password" /></a></li> --%>
	<li>
		<input type="submit" class="button" name="submit" value="<fmt:message key="bees.login.log.in" />">
	</li>
</ol>		
</form>

<form:form cssClass="accountLogin" modelAttribute="newCustomer" method="POST" action="/account/register">

<h2><fmt:message key="bees.login.register" /></h2>
<ol>
	<li>
		<form:label cssClass="label" path="email"><fmt:message key="bees.login.email" /></form:label>
		<form:input cssClass="input" path="email" />
	</li>
	<li>
		<form:label cssClass="label" path="password"><fmt:message key="bees.login.password" /></form:label>
		<form:input type="password" cssClass="input" path="password" />
	</li>
	<li>
		<label class="label" for="password_confirm"><fmt:message key="bees.login.confirm.password" /></label>
		<input type="password" class="input" id="password_confirm" />
	</li>
	<li>
		<form:button class="button" name="register"><fmt:message key="bees.login.register" /></form:button>
	</li>
</ol>

</form:form>