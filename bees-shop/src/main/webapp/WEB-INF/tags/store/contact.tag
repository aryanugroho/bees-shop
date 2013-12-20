<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<form class="form contact" method="POST" action="enquiry/submit">
	<ol>
		<li class="title"><fmt:message key="bees.contact.form" /></li>
		<li>
			<label class="label" for="enquiry-name"><fmt:message key="bees.contact.name" /></label>
			<input class="input" id="enquiry-name" name="name" placeholder="John Doe" value="${param.name}" />
		</li>
		<li>
			<label class="label" for="enquiry-email"><fmt:message key="bees.contact.email" /></label>
			<input class="input" id="enquiry-email" name="email" placeholder="example@example.com" value="${param.email}" />
		</li>
		<li>
			<label class="label" for="enquiry-telephone"><fmt:message key="bees.contact.telephone" /></label>
			<input class="input" id="enquiry-telephone" name="telephone" placeholder="0777 777 7777" value="${param.telephone}" />
		</li>
		<li>
			<label class="label" for="enquiry-message"><fmt:message key="bees.contact.message" /></label>
			<textarea class="input" id="enquiry-message" name="message">${param.message}</textarea>
		</li>	
		<li>
			<input class="button advance" type="submit" value="Submit Enquiry" />
		</li>
	</ol>
</form>