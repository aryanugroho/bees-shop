<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>


<%@ attribute name="menuItem" required="true" %>
<%@ attribute name="type" required="true" %>
<%@ attribute name="maxLevel" required="false" %>

<c:set var="activeGroup" value="${!empty menuItem.group && menuItem.group.status == 1}" />
<c:set var="activePage" value="${!empty menuItem.page && menuItem.page.status == 1}" />

<c:if test="${activeGroup || activePage}">
	<${type}>
		<c:choose>
			<c:when test="${activePage}"><a href="/${util:url(menuItem.page.name)}">${menuItem.page.name}</a></c:when>	
			<c:when test="${activeGroup}"><a href="/group/${util:url(menuItem.group.name)}">${menuItem.group.name}</a></c:when>			
		</c:choose>
		<c:if test="${maxLevel > 1}">
			<c:if test="${!empty menuItem.children || parent.menuItem.groups || !empty menuItem.group.categories || !empty menuItem.group.albums}">
				<ul>
					<c:choose>
						<c:when test="${!empty menuItem.children}">				
							<c:forEach var="child" items="${menuItem.children}" varStatus="status">
								<store:menu menuItem="${child}" maxLevel="${maxLevel - 1}" type="${type}" />
							</c:forEach>
						</c:when>
						<c:otherwise>			
							<c:forEach var="child" items="${menuItem.group.groups}" varStatus="status">
								<li class="group"><a href="/group/${util:url(child.name)}">${child.heading}</a></li>
							</c:forEach>			
							<c:forEach var="child" items="${menuItem.group.categories}" varStatus="status">
								<li class="category"><a href="/category/${util:url(child.name)}">${child.heading}</a></li>
							</c:forEach>			
							<c:forEach var="child" items="${menuItem.group.albums}" varStatus="status">
								<li class="album"><a href="/album/${util:url(child.name)}">${child.heading}</a></li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</c:if>
		</c:if>
	</${type}>
</c:if>