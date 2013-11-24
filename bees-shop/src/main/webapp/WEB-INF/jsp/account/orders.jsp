<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="accountMenu.jsp" />

<h1><fmt:message key="bees.orders.title" /></h1>

<c:if test="${!empty messages}">
	<ul class="message accountMessage">
		<c:forEach var="message" items="${messages}"><li>${message}</li></c:forEach>
	</ul>
</c:if>

<div class="element accountSection">
	<p><fmt:message key="bees.orders.view.below" /></p>
	<p><fmt:message key="bees.orders.status" /></p>
</div>

<div class="element">
	<table class="accountOrders">
		<tr>
			<th><fmt:message key="bees.orders.order.date" /></th>
			<th><fmt:message key="bees.orders.order.number" /></th>
			<th><fmt:message key="bees.orders.order.status" /></th>
			<th><fmt:message key="bees.orders.order.value" /></th>
			<th><fmt:message key="bees.orders.order.update" /></th>
		</tr>
		<c:forEach var="order" items="${orderList}">
			<tr>
				<td><fmt:formatDate value="${order.orderPlaced}" pattern="dd/MM/yyyy" /></td>
				<td><fmt:message key="bees.order.prefix" />${order.id}</td>
				<td>${order.orderStatus}</td>
				<td class="total"><fmt:formatNumber value="${order.total}" currencySymbol="&pound;" type="currency"/></td>
				<td><a class="button advance" href="/account/order/view?id=${order.id}"><fmt:message key="bees.orders.view.order" /></a></td>
			</tr>
		</c:forEach>
	</table>
</div>