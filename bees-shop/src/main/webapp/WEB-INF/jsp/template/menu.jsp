<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<nav class="menu container">
	<section>
		<ol>
			<li><a href="/"><fmt:message key="bees.home.title" /></a></li>	
			<c:forEach var="parent" items="${menuItems}" varStatus="status">	
				<c:if test="${parent.type == 1}">
					<store:menu menuItem="${parent}" maxLevel="${config.enableDropDown}" type="li" />
				</c:if>
			</c:forEach>
		</ol>
	</section>
</nav>