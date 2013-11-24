<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<c:url var="url_Link" value="/admin/${page.url}" />
<c:url var="url_List" value="/admin/${page.url}List" />

<form method="POST" action="${url_List}" class="left-items">
	<h1>${page.type} Set</h1>
	
	<ul class="items">
		<c:forEach var="u" items="${itemList}">
			<li class="status-${u.status} id-${u.id}">
				<div class="check">
					<input type="checkbox" name="update" value="${u.id}" />
				</div>
				<a class="form" href="${url_Link}?id=${u.id}" title="${u.name}">
				<span> ${u.id} - <strong>${page.type == 'user' ? u.name : u.heading}</strong></span>				
				<c:if test="${page.type == 'product'}"><span>From <fmt:formatNumber value="${u.minPrice}" currencySymbol="&pound;" type="currency"/></span></c:if>					
				<c:if test="${page.type == 'variant'}"><span><fmt:formatNumber value="${u.price}" currencySymbol="&pound;" type="currency"/></span></c:if>										
				</a>
			</li>
		</c:forEach>
	</ul>	
	
	<ul class="options">
		<li><a class="form create" href="${url_Link}" title="Add user">Add</a></li>
		<li><a class="parent update" href="#" title="Add user">Update</a>
			<ul class="child left">
				<li><a href="#" class="submit" title="Remove selected">Activate</a></li>
				<li><a href="#" class="submit" title="Remove selected">De-activate</a></li>
				<li><a href="#" class="submit" title="Remove selected">Remove</a></li>
			</ul>
		</li>
		<li><a class="parent" href="#" title="Add user">Sort</a>
			<ul class="child center">
				<li><admin:sortLink link="${url_List}" sortBy="id" title="Order by Id" /></li>
				<li><admin:sortLink link="${url_List}" sortBy="name" title="Order by name" /></li>
				<c:if test="${page.type == 'article'}">
					<li><admin:sortLink link="${url_List}" sortBy="newsPublishDate" title="Order by date" /></li>
				</c:if>
				<c:if test="${page.type == 'user'}">
					<li><admin:sortLink link="${url_List}" sortBy="username" title="Order by username" /></li>
					<li><admin:sortLink link="${url_List}" sortBy="email" title="Order by email" /></li>	
				</c:if>		
			</ul>
		</li>
		<c:if test="${!empty param.sort}"><c:set var="url_List" value="${url_List}?sort=${param.sort}" /></c:if>
		<c:set var="archiveText" value="${param.showArchived == 'true' ? 'Hide' : 'Show'} archived" />
		<li><a class="parent" href="#" title="Options">Options</a>
			<ul class="child right">
				<li><a href="${url_List}${empty param.sort ? '?' : '&amp;'}showArchived=${param.showArchived == 'true' ? '' : 'true'}" title="${archiveText}">${archiveText}</a></li>
			</ul>
		</li>
	</ul>
	
	<input type="hidden" name="return" value="${url.par}" />
	<input type="hidden" name="statusUpdate" id="statusUpdate" value="" />
</form>