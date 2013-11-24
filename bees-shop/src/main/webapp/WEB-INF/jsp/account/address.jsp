<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="accountMenu.jsp" />

<h1><fmt:message key="bees.address.title" /></h1>		

<div class="element accountSection">
	<p><fmt:message key="bees.address.please.update" /></p>
</div>

<form:form class="form account" action="/account/address/update" method="POST" modelAttribute="address">
	<form:hidden path="id" />

	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.address.your.details" /></li>
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
	
	<ol class="section createAddress">
		<li class="title"><fmt:message key="bees.address.delivery.address" /></li>
		<li>
			<form:label cssClass="label" path="line1"><fmt:message key="bees.address.address.1" /></form:label>
			<form:input cssClass="input" path="line1" />
		</li>
		<li>
			<form:label cssClass="label" path="line2"><fmt:message key="bees.address.address.2" /></form:label>
			<form:input cssClass="input" path="line2" />
		</li>
		<li>
			<form:label cssClass="label" path="line3"><fmt:message key="bees.address.address.3" /></form:label>
			<form:input cssClass="input" path="line3" />
		</li>
		<li>
			<form:label cssClass="label" path="town"><fmt:message key="bees.address.town" /></form:label>
			<form:input cssClass="input" path="town" />
		</li>
		<li>
			<form:label cssClass="label" path="county"><fmt:message key="bees.address.county" /></form:label>
			<form:input cssClass="input" path="county" />
		</li>
		<li>
			<form:label cssClass="label" path="postcode"><fmt:message key="bees.address.postcode" /></form:label>
			<form:input cssClass="input" path="postcode" />
		</li>
		<li>
			<form:label cssClass="label" path="country"><fmt:message key="bees.address.country" /></form:label>
			<form:select cssClass="input" path="country">
				<form:option value="" label="Select country" />
				<form:options itemValue="code" itemLabel="name" items="${countries}" />
			</form:select>
		</li>
	</ol>
	
	<div class="section createAddress">
		<a class="button return" href="/account/address"><fmt:message key="bees.address.return" /></a>
		<form:button class="button advance"><fmt:message key="bees.address.${empty address.id ? 'create' : 'update'}.address" /></form:button>
	</div>

</form:form>