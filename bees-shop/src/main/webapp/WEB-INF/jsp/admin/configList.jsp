<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<c:url var="url_Link" value="/admin/${page.url}" />
<c:url var="url_List" value="/admin/${page.url}List" />

<form method="POST" action="${url_List}" class="left-items">
	<h1>Configuration Options</h1>
	
	<ul class="items">
		<c:forEach var="config" items="${itemList}">
			<li>
				<a class="form" href="${url_Link}?id=${config.id}" title="${config.name}">
					<span><strong>${config.name}</strong></span>				
					<span class="config">${config.value}</span>								
				</a>
			</li>
		</c:forEach>
	</ul>	
	
	<ul class="options">
		<li><a class="form create" href="${url_Link}" title="Add user">Add</a></li>
		<li><a class="parent" href="#" title="Sort">Sort</a>
			<ul class="child center">
				<li><admin:sortLink link="${url_List}" sortBy="id" title="Order by Id" /></li>
				<li><admin:sortLink link="${url_List}" sortBy="name" title="Order by key" /></li>
			</ul>
		</li>
	</ul>
	
	<input type="hidden" name="return" value="${url.par}" />
	<input type="hidden" name="statusUpdate" id="statusUpdate" value="" />
</form>