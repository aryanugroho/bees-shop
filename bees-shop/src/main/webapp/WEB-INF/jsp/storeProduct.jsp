<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>
<c:when test="${content.status == 1}">

	<store:product object="${content}" />

</c:when>

<c:otherwise>
	<h1><fmt:message key="bees.storeproduct.not.available" /></h1>
	<p class="element"><fmt:message key="bees.storeproduct.not.available.message" /></p>
	<p class="element"><a class="button return" href="${url.ref}"><fmt:message key="bees.storeproduct.return" /></a></p>
</c:otherwise>
</c:choose>