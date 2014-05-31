<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
	<c:when test="${!empty customer.tenders}">

		<%-- You have saved {0} orders --%>
		<p>
			<fmt:message key="bees.account.address.message">
				<fmt:param value="${fn:length(customer.addresses)}" />
			</fmt:message>
		</p>

		<%-- Address list--%>
		<ul class="accountGrid accountAddress">
			<c:forEach var="address" items="${customer.addresses}">
				<li>
					<div>

						<%-- Display address --%>
						<store:address address="${address}" type="span" />
						<%-- Address actions --%>
						<ul class="accountActions">
							<li><a class="edit" href="/account/address/update?id=${address.id}"><fmt:message key="bees.account.edit" /></a></li>
							<li><a class="remove" href="/account/update?removeAddress=${address.id}"><fmt:message key="bees.account.remove" /></a></li>
						</ul>

					</div>
				</li>
			</c:forEach>
		</ul>

		<%-- Address actions --%>
		<ul class="accountActions">
			<li><a class="button advance create" href="/account/address/update"><fmt:message key="bees.account.create" /></a></li>
		</ul>

	</c:when>
	<c:otherwise>

		<%-- You have not saved any addresses yet --%>
		<p class="emptyState"><fmt:message key="bees.account.empty.addresses" /></p>

	</c:otherwise>
</c:choose>