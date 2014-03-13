<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<fieldset class="existingAddress">
	<legend><fmt:message key="bees.delivery.use.an.existing.address" /></legend>
	<store:input name="selectAddressId" type="select">
		<c:forEach var="address" items="${customer.addresses}">
			<c:set var="selected" value="${addressForm.id == address.id ? 'selected' : ''}" />
			<option ${selected} value="${address.id}"><store:address address="${address}" /></option>
		</c:forEach>
	</store:input>
</fieldset>