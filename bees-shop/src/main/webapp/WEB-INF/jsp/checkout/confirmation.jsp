<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<h1><fmt:message key="bees.confirmation.title" /></h1>
<p class="element message">
	<fmt:message key="bees.confirmation.message">
		<fmt:param><fmt:message key="bees.order.prefix" />${order.id}</fmt:param>
	</fmt:message>
</p>

<h2><fmt:message key="bees.confirmation.summary" /></h2>
<div class="basket checkout">
	<store:basket basket="${order}" summary="true" />
</div>