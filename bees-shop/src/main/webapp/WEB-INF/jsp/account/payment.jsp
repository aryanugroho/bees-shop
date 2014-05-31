<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
	<c:when test="${!empty customer.tenders}">

		<%-- You have placed {0} orders --%>
		<p>
			<fmt:message key="bees.account.tenders.message">
				<fmt:param value="${fn:length(customer.tenders)}" />
			</fmt:message>
		</p>

		<%-- Order list--%>
		<ul class="accountTender">
			<c:forEach var="tender" items="${customer.tenders}">
				<li>
					<div>

						<%-- Order information --%>
						<p>
							<strong><fmt:message key="bees.account.tender.number" /></strong>
							<span>${tender.name}</span>
						</p>
						<p>
							<strong><fmt:message key="bees.account.tender.type" /></strong>
							<span>${tender.cardType}</span>
						</p>
						<c:if test="${!empty tender.startDate}">
							<p>
								<strong><fmt:message key="bees.account.tender.startdate" /></strong>
								<span><fmt:formatDate pattern="MM / YY" value="${tender.startDate}" /></span>
							</p>
						</c:if>
						<c:if test="${!empty tender.expiryDate}">
							<p>
								<strong><fmt:message key="bees.account.tender.expirydate" /></strong>
								<span><fmt:formatDate pattern="MM / YY" value="${tender.expiryDate}" /></span>
							</p>
						</c:if>
						<c:if test="${!empty tender.address}">
							<p>
								<strong><fmt:message key="bees.account.tender.address" /></strong>
								<span><store:address address="${tender.address}" type="span" /></span>
							</p>
						</c:if>

						<%-- Order links --%>
						<ul class="accountActions">
							<li><a class="remove" href="/account/update?removeCard=${paymentOption.id}"><fmt:message key="bees.account.remove" /></a></li>
						</ul>

					</div>
				</li>
			</c:forEach>
		</ul>

	</c:when>
	<c:otherwise>

		<%-- You have not placed any orders yet --%>
		<p class="emptyState"><fmt:message key="bees.account.empty.tenders" /></p>

	</c:otherwise>
</c:choose>