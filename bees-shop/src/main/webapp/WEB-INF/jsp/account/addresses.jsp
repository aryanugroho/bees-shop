<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<jsp:include page="accountMenu.jsp" />

<h1><fmt:message key="bees.addresses.title" /></h1>

<c:if test="${!empty messages}">
	<ul class="message accountMessage">
		<c:forEach var="message" items="${messages}"><li>${message}</li></c:forEach>
	</ul>
</c:if>

<div class="element accountSection">
	<p><fmt:message key="bees.addresses.view" /></p>
	<p><fmt:message key="bees.addresses.note" /></p>
</div>

<div class="element accountSection">
	<a class="button advance" href="/account/address/manage"><fmt:message key="bees.addresses.add" /></a>
</div>

<ul class="table addressList">
	<c:forEach var="address" items="${customer.addressLink}">
		<li><div>
			<span><strong>${address.firstname} ${address.surname}</strong></span>
			<store:address address="${address}" type="span" />
			<a class="update button link" href="address/manage?id=${address.id}" title="Edit Address"><fmt:message key="bees.addresses.edit" /></a>
			<form class="remove" action="/account/address/remove" method="post">
                <input type="hidden" name="addressId" value="${address.id}">
                <button class="button link"><fmt:message key="bees.addresses.remove" /></button>
            </form>
		</div></li>
	</c:forEach>
</ul>