<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
	<c:when test="${!empty orderList}">

		<div id="pagination">

			<store:pagination sortKey="orders" pagination="${orderPagination}" summary="true" />			
			<%-- Order list--%>
			<ul class="accountGrid accountOrder">
				<c:forEach var="order" items="${orderList}">
					<li>
						<div>

							<%-- Order information --%>
							<h3><fmt:formatDate pattern="dd MMMM yyyy" value="${order.orderPlaced}" /></h3>
							<p>
								<strong><fmt:message key="bees.account.order.id" /></strong>
								<span>${order.id}</span>
							</p>
							<p>
								<strong><fmt:message key="bees.account.order.status" /></strong>
								<span><fmt:message key="bees.account.order.status.${empty order.orderStatus ? 1 : order.orderStatus}" /></span>
							</p>
							<p class="price"><fmt:formatNumber type="currency" currencySymbol="£" value="${order.total}" /></p>

							<%-- Order links --%>
							<ul class="accountActions">
								<li><a class="view" href="/account/order/${order.id}"><fmt:message key="bees.account.view" /></a></li>
							</ul>

						</div>
					</li>
				</c:forEach>
			</ul>
			<store:pagination sortKey="orders" pagination="${categoryPagination}" />

		</div>

	</c:when>
	<c:otherwise>

		<%-- You have not placed any orders yet --%>
		<p class="emptyState"><fmt:message key="bees.account.empty.orders" /></p>

	</c:otherwise>
</c:choose>