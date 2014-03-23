<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<%@ attribute name="menuItem" type="org.beesden.shop.model.Menu" required="true" %>
<%@ attribute name="type" required="true" %>
<%@ attribute name="maxLevel" required="false" %>

<c:if test="${maxLevel > 1 && (!empty menuItem.category || !empty menuItem.page) && menuItem.status == 1}">
	<${type}>
		<c:choose>
			<c:when test="${!empty menuItem.category}">

				<%-- Toggle for menu children --%>
				<c:if test="${maxLevel > 2 && !empty menuItem.category.children}">
					<label class="menuChild" for="menu_${menuItem.category.name}"><span><fmt:message key="beesden.menu.more" /></span></label>
				</c:if>				
					
				<%-- Straight menu link --%>
				<a href="/category/${util:url(menuItem.category.name)}">${menuItem.category.heading}</a>				

				<%-- Menu category children --%>
				<c:if test="${maxLevel > 2 && !empty menuItem.category.children}">
					<input type="radio" name="showMenu" id="menu_${menuItem.category.name}" class="menuChildToggle" />

					<ul id="menu_${menuItem.category.name}">
						<li><label for="menu_hideChildren"><fmt:message key="beesden.menu.hide" />Hide<label>
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