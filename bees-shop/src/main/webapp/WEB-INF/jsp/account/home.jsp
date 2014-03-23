<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="customerName">
	<c:choose>
		<c:when test="${!empty customer.firstname && !empty customer.surname}">${customer.firstname} ${customer.surname}</c:when>
		<c:otherwise><a href="/account/options"><fmt:message key="bees.account.whats.your.name" /></a></c:otherwise>
	</c:choose>
</c:set>

<p><fmt:message key="bees.account.welcome"><fmt:param>${customerName}</fmt:param></fmt:message></p>	
<p><fmt:message key="bees.account.update.details" /></p>
<p><fmt:message key="bees.account.login.details" /></p>