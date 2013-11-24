<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ attribute name="pagination" type="java.util.HashMap" required="true" %>
<%@ attribute name="sortKey" required="false" %>
<%@ attribute name="summary" type="java.lang.Boolean" required="false" %>

<div class="element summaryContainer">

	<c:if test="${pagination.pages > 1}">
	
		<c:set var="x" value="${!empty config.paginationSize ? config.paginationSize : 2}" />
		<c:set var="first" value="${(pagination.pages - pagination.page) > x ? pagination.page - x : pagination.pages - (2 * x)}" />	
		<c:set var="first" value="${first < 1 ? 1 : first}" />	
		<c:set var="last" value="${pagination.page <= x ? (2 * x + 2) - first : pagination.page + x}" />
		<c:set var="last" value="${last > pagination.pages ? pagination.pages : last}" />	
	
		<c:set var="pageUrl" value="${url.uri}?" />
		<c:if test="${!empty param.keywords}">
			<c:set var="pageUrl" value="${pageUrl}keywords=${param.keywords}&amp;" />
		</c:if>
		<c:if test="${!empty param.sort}">
			<c:set var="pageUrl" value="${pageUrl}sort=${param.sort}&amp;" />
		</c:if>
		<c:if test="${!empty param.results}">
			<c:set var="pageUrl" value="${pageUrl}results=${param.results}&amp;" />
		</c:if>
	
		<ol class="pagination">
			<li>
				<c:choose>
					<c:when test="${pagination.page <= 1}"><em><fmt:message key="bees.pagination.prev" /></em></c:when>
					<c:otherwise><a href="${pageUrl}page=${pagination.page - 1}"><fmt:message key="bees.pagination.prev" /></a></c:otherwise>		
				</c:choose>
			</li>
			
			<c:forEach varStatus="page" begin="${first}" end="${last}">
				<li>
					<c:choose>
						<c:when test="${pagination.page == page.index}"><span>${page.index}</span></c:when>
						<c:otherwise><a href="${pageUrl}page=${page.index}">${page.index}</a></c:otherwise>
					</c:choose>
				</li>
			</c:forEach>
			<li>
				<c:choose>
					<c:when test="${pagination.page == pagination.pages}"><em><fmt:message key="bees.pagination.next" /></em></c:when>
					<c:otherwise><a href="${pageUrl}page=${pagination.page + 1}"><fmt:message key="bees.pagination.next" /></a></c:otherwise>		
				</c:choose>
			</li>
		</ol>
	
	</c:if>

	<c:if test="${!empty sortKey}">
		<form class="sortOrder" action="${url.uri}?" method="GET">
			<c:if test="${!empty param.page}"><input type="hidden" name="page" value="${param.page}" /></c:if>
			<c:if test="${!empty param.results}"><input type="hidden" name="results" value="${param.results}" /></c:if>
			<c:if test="${!empty param.keywords}"><input type="hidden" name="keywords" value="${param.keywords}" /></c:if>
			<select class="input sort" name="sort">
				<option value=""><fmt:message key="bees.pagination.sort" /></option>			
				<c:forEach var="sort" items="${config.sortOrders[sortKey]}">
					<option ${param.sort == sort.value ? 'selected="selected" ' : ''}value="${sort.value}">${sort.key}</option>
				</c:forEach>
			</select>	 
			<input class="button return" type="submit" value="&raquo;" />
		</form>
	</c:if>

	<c:if test="${summary}">
		<span class="summary">
			<fmt:message key="bees.pagination.summary.${!empty sortKey ? sortKey : 'generic'}.${pagination.size > 1 ? 'results' : 'empty'}${pagination.pages > 1 ? 'paginate' : ''}">
				<fmt:param value="${pagination.page}" />
				<fmt:param value="${pagination.pages}" />
				<fmt:param value="${pagination.first}" />
				<fmt:param value="${pagination.last}" />
				<fmt:param value="${pagination.size}" />
			</fmt:message>
		</span>
	</c:if>
	
</div>
