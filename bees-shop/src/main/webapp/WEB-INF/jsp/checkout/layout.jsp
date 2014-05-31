<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:set var="basket" value="${!empty order ? order : basket}" scope="request" />

<c:if test="${!empty messages}">
	<ul class="errors">
		<c:forEach var="error" items="${messages}">
			<li><fmt:message key="${error}" /></li>
		</c:forEach>
	</ul>
</c:if>

<c:set var="step"><tiles:getAsString name="step"/></c:set>

<ol class="checkoutNavigation">
	<c:forEach var="location" begin="1" end="5">
		<li class="${step >= location ? step == location ? 'active current' : 'active' : ''}">
			<strong>${location}</strong>
			<span><fmt:message key="bees.checkout.navigation.${location}" /></span>
		</li>
	</c:forEach>
</ol>

<c:set var="basket" value="${!empty orderConfirm ? orderConfirm : basket}" scope="request" />

<div class="checkoutContent" id="checkoutFlow">
	<h1><fmt:message key="bees.${layout}" /></h1>
	<tiles:insertAttribute name="subject" />
</div>

<div class="checkoutSummary basket">
	<h2><fmt:message key="bees.payment.review.your.order" /></h2>
	<store:basket basket="${basket}" checkout="true" editable="false" />
</div>