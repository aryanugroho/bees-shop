<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="panel" tagdir="/WEB-INF/tags/panels" %>

<%@ attribute name="sortBy" required="true" %>
<%@ attribute name="link" required="true" %>
<%@ attribute name="title" required="true" %>

<c:set var="link" value="${link}?sort=${sortBy}" />
<c:if test="${param.showArchived == 'true'}">
	<c:set var="link" value="${link}&amp;showArchived=${param.showArchived}" />
</c:if>

<a href="${link}" title="${title}">${title}</a>