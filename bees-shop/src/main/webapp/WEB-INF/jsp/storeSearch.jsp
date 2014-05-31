<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
			
<div id="pagination">

	<store:filters category="${content}" />

	<div class="categoryResults">

		<h1>Search Results</h1>
			
		<c:choose>
			<c:when test="${pagination.size > 0}">
				<store:pagination sortKey="products" pagination="${categoryPagination}" summary="true" />
				<store:category object="${content.products}" />
				<store:pagination sortKey="products" pagination="${categoryPagination}" />
			</c:when>
			<c:when test="${!empty param.keywords}">
				<fmt:message key="bees.storesearch.no.results">
					<fmt:param>${param.keywords}</fmt:param>
				</fmt:message>
			</c:when>
			<c:otherwise>
				<fmt:message key="bees.storesearch.form" />
			</c:otherwise>
		</c:choose>
		<div id="overlay" class="overlay"></div>

	</div>

	<form class="form advancedSearch" action="/search">

		<fieldset>
			<legend><fmt:message key="bees.storesearch.advanced.search" /></legend>
			<store:input name="keywords" />
		</fieldset>
		<button class="button advance"><fmt:message key="bees.button.search" /></button>
		
	</form>
</div>