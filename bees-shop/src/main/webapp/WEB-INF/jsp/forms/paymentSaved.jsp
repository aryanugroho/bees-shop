<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<jsp:useBean id="currentDate" class="java.util.Date" />
<fmt:formatDate var="currentDate" pattern="yyyy-MM" value="${currentDate}" />

<fieldset class="${param.fieldClass}">
	<legend><fmt:message key="bees.form.saved.payment" /></legend>
	<store:input name="paymentId" type="select">
		<c:forEach var="tender" items="${customer.tenders}">
			<c:set var="selected" value="${tender.id == basket.paymentDetails.id ? 'selected' : ''}" />
			<option ${selected} value="${tender.id}">${tender.name}</option>
		</c:forEach>
	</store:input>
</fieldset>