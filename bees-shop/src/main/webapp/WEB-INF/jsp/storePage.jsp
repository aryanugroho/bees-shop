<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<c:choose>

	<c:when test="${content.status == 1}">
	
		<c:if test="${!empty content.heading}">
			<h1>${content.heading}</h1>
		</c:if>
	
		<c:if test="${!empty content.description}">
			<div class="pageContTop editable">${content.description}</div>
		</c:if>
	
		<c:if test="${content.contactPanel}">
			<div class="pageContact"><store:contact /></div>
		</c:if>
	
	</c:when>
	
	<c:otherwise>
		<h1><fmt:message key="bees.storepage.not.available" /></h1>
		<p class="element"><fmt:message key="bees.storepage.not.available.message" /></p>
		<p class="element"><a class="button return" href="${url.ref}"><fmt:message key="bees.storepage.return" /></a></p>
	</c:otherwise>

</c:choose>