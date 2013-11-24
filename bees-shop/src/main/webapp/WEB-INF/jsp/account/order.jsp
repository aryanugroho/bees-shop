<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<jsp:include page="accountMenu.jsp" />

<h1><fmt:message key="bees.order.order.number" /></h1>

<ul class="element orderDetail">
	<li><strong><fmt:message key="bees.order.order.number" /></strong> <fmt:message key="bees.order.prefix" />${customerOrder.id}</li>
	<li><strong><fmt:message key="bees.order.date" /></strong> <fmt:formatDate value="${customerOrder.orderPlaced}" pattern="dd/MM/yyyy" /></li>
	<li><strong><fmt:message key="bees.order.order.status" /></strong> ${customerOrder.orderStatus}</li>
	<li><strong><fmt:message key="bees.order.delivery" /></strong> ${customerOrder.deliveryType} - <fmt:formatNumber value="${customerOrder.deliveryChargePrice}" currencySymbol="&pound;" type="currency"/></li>
	<li><strong><fmt:message key="bees.order.total" /></strong> <fmt:formatNumber value="${customerOrder.total}" currencySymbol="&pound;" type="currency"/></li>
</ul>

<div class="basket viewOrder">
	<store:basket basket="${customerOrder}" summary="true" />
</div>