<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="seoTitle">
	<c:choose>
		<c:when test="${!empty content.seoTitle}">${content.seoTitle}</c:when>
		<c:when test="${!empty content.heading}">${content.heading} ${config.seoTitle}</c:when>
		<c:otherwise><fmt:message key="bees.meta.${layout}" /> ${config.seoTitle}</c:otherwise>
	</c:choose>
</c:set>
<title>${seoTitle}</title>

<c:set var="seoDescription">
	<c:choose>
		<c:when test="${!empty content.seoDescription}">${content.seoDescription}</c:when>
		<c:when test="${!empty config.seoDescription}">${config.seoDescription}</c:when>
	</c:choose>
</c:set>
<meta name="description" content="${seoDescription}" />
<meta name="keywords" content="${config.seoKeywords}" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"> 