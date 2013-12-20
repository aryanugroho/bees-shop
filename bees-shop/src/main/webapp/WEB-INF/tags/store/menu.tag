<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="menuItem" type="org.beesden.shop.model.Menu" required="true" %>
<%@ attribute name="type" required="true" %>
<%@ attribute name="maxLevel" required="false" %>

<c:if test="${maxLevel > 1 && (!empty menuItem.category || !empty menuItem.page)}">
	<${type}>
		<c:choose>
			<c:when test="${!empty menuItem.children}">
				<ul>
					<c:forEach var="child" items="${menuItem.children}" varStatus="status">
						<store:menu menuItem="${child}" maxLevel="${maxLevel - 1}" type="${type}" />
					</c:forEach>
				</ul>
			</c:when>
			<c:when test="${!empty menuItem.category}">
				<a href="/category/${util:url(menuItem.category.name)}">${menuItem.category.heading}</a>
			</c:when>
			<c:when test="${!empty menuItem.page}">
				<a href="/${menuItem.page.name == 'home' ? '' : util:url(menuItem.page.name)}">${menuItem.page.heading}</a>				
			</c:when>
		</c:choose>
	</${type}>
</c:if>