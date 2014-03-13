<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<p class="element message">
	<fmt:message key="bees.confirmation.message">
		<fmt:param><fmt:message key="bees.order.prefix" />${order.id}</fmt:param>
	</fmt:message>
</p>