<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="menuItem" type="org.beesden.shop.model.Menu" required="true" %>
<%@ attribute name="type" required="true" %>
<%@ attribute name="maxLevel" required="false" %>

<c:if test="${maxLevel > 1 && (!empty menuItem.category || !empty menuItem.page)}">
	<${type}>
		<c:choose>
			<c:when test="${!empty menuItem.category}">
				<a href="/category/${util:url(menuItem.category.name)}">${menuItem.category.heading}</a>				
				<c:if test="${maxLevel > 2 && !empty menuItem.category.children}">
					<ul>
						<c:forEach var="child" items="${menuItem.category.children}" varStatus="status">
							<li><a href="/category/${util:url(child.name)}">${child.heading}</a></li>
						</c:forEach>
					</ul>
				</c:if>
			</c:when>
			<c:when test="${!empty menuItem.page}">
				<a href="/${menuItem.page.name == 'home' ? '' : util:url(menuItem.page.name)}">${menuItem.page.heading}</a>				
			</c:when>
		</c:choose>
	</${type}>
</c:if>