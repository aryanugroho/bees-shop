<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="accountMenu.jsp" />

<h1><fmt:message key="bees.account.title" /></h1>

<c:set var="customerName">
	<c:choose>
		<c:when test="${!empty customer.firstname && !empty customer.surname}">${customer.firstname} ${customer.surname}</c:when>
		<c:otherwise><a href="/account/options"><fmt:message key="bees.account.whats.your.name" /></a></c:otherwise>
	</c:choose>
</c:set>

<div class="element accountSection">
	<p><fmt:message key="bees.account.welcome"><fmt:param>${customerName}</fmt:param></fmt:message></p>	
	<p><fmt:message key="bees.account.update.details" /></p>
	<p><fmt:message key="bees.account.login.details" /></p>
</div>

<form:form class="form account" action="/account/options/update" method="POST" modelAttribute="customer">
	<form:hidden path="id" />

	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.account.your.details" /></li>
		<li>
			<form:label cssClass="label" path="firstname"><fmt:message key="bees.address.first.name" /></form:label>
			<form:input cssClass="input" path="firstname" />
		</li>
		<li>
			<form:label cssClass="label" path="surname"><fmt:message key="bees.address.surname" /></form:label>
			<form:input cssClass="input" path="surname" />
		</li>
		<li>
			<form:label cssClass="label" path="telephone"><fmt:message key="bees.address.telephone" /></form:label>
			<form:input cssClass="input" path="telephone" />
		</li>
		<li>
			<form:label cssClass="label" path="email"><fmt:message key="bees.address.email" /></form:label>
			<form:input cssClass="input" path="email" />
		</li>
	</ol>
	
	<div class="section createAddress">
		<form:button class="button advance single"><fmt:message key="bees.account.update.account" /></form:button>
	</div>

</form:form>

<form class="form account" action="/account/password/update" method="POST">

	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.account.update.password" /></li>
		<li>
			<label class="label" for="currentPassword"><fmt:message key="bees.account.current.password" /></label>
			<input type="password" id="currentPassword" name="currentPassword" class="input" />
		</li>
		<li>
			<label class="label" for="newPassword"><fmt:message key="bees.account.new.password" /></label>
			<input type="password" id="newPassword" name="newPassword" class="input" />
		</li>
		<li>
			<label class="label" for="verifyPassword"><fmt:message key="bees.account.verify.password" /></label>
			<input type="password" id="verifyPassword" name="verifyPassword" class="input" />
		</li>
	</ol>
	
	<div class="section createAddress">
		<button class="button advance single"><fmt:message key="bees.account.update.password" /></button>
	</div>
</form>