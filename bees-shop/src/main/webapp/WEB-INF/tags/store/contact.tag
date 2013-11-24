<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
<c:when test="${content.contactPanel == 1}">
	<div id="contactDetails">
		<h2><fmt:message key="bees.contact.title" /></h2>
	
		<c:forEach var="add" items="${addresses}" varStatus="i">
		
			<c:if test="${!i.first}"><hr /></c:if>
	
			<h3><fmt:message key="bees.contact.address" /></h3>
			<p><store:address address="${add}" type="span" /></p>
			<c:if test="${!empty add.telephone}"><p>${add.telephone}<p></c:if>
			<c:if test="${!empty add.email}"><p><a href="mailto:${add.email}">${add.email}</a><p></c:if>
		</c:forEach>
	</div>
</c:when>

<c:when test="${content.contactPanel == 2}">
	
	<form:form cssClass="form contact" modelAttribute="contactForm" method="POST" enctype="multipart/form-data" action="/submitEnquiry">
		<input type="hidden" name="redirect" value=""/>
		<input type="hidden" name="contactType" value="${content.contactPanel}"/>
		
		<ol>
			<li class="title"><fmt:message key="bees.contact.form" /></li>
			<li>
				<form:label cssClass="label" path="name"><fmt:message key="bees.contact.name" /></form:label>
				<form:input cssClass="input" path="name" placeholder="John Doe" />
			</li>
			<li>
				<form:label cssClass="label" path="name"><fmt:message key="bees.contact.email" /></form:label>
				<form:input cssClass="input" path="email" placeholder="example@example.com" />
			</li>
			<li>
				<form:label cssClass="label" path="telephone"><fmt:message key="bees.contact.telephone" /></form:label>
				<form:input cssClass="input" path="email" placeholder="0777 777 7777" />
			</li>
			<li>
				<form:label cssClass="label" path="telephone"><fmt:message key="bees.contact.message" /></form:label>
				<form:textarea cssClass="input" path="message" />
			</li>	
			<li>
				<input class="button advance" type="submit" value="Submit Enquiry" />
			</li>
		</ol>
	
	</form:form>
</c:when>
</c:choose>