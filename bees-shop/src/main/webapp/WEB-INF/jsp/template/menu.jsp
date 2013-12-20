<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<nav class="menu container">
	<section>
		<ol>
			<c:forEach var="parent" items="${menu}" varStatus="status">	
				<c:if test="${parent.status == 1 && parent.name == 'Top Navigation'}">
					<c:forEach var="child" items="${parent.children}" varStatus="status">	
						<store:menu menuItem="${child}" maxLevel="${config.enableDropDown}" type="li" />
					</c:forEach>
				</c:if>
			</c:forEach>
		</ol>
	</section>
</nav>