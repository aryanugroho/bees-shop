<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<p><fmt:message key="bees.address.please.update" /></p>

<form action="/account/update" method="POST">

	<input type="hidden" name="${empty addressForm.id ? 'createAddress' : 'updateAddress'}" value="${empty addressForm.id ? true : addressForm.id}" />
	
	<jsp:include page="../forms/customer.jsp" />
	<jsp:include page="../forms/address.jsp" />
	
	<button class="button advance"><fmt:message key="bees.address.${empty address.id ? 'create' : 'update'}.address" /></button>
	
</form>