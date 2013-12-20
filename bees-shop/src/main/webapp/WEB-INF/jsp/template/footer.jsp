<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<footer class="footer container">
	<section>
	
		<dl class="sitemap">
			<dt><fmt:message key="bees.footer.pages" /></dt>
			<c:forEach var="parent" items="${menu}" varStatus="status">	
				<c:if test="${parent.status == 1 && parent.name == 'Top Navigation'}">
					<c:forEach var="child" items="${parent.children}" varStatus="status">	
						<store:menu menuItem="${child}" maxLevel="2" type="dd" />
					</c:forEach>
				</c:if>
			</c:forEach>
		</dl>
		
		<dl class="legal">
			<dt>${config.companyName}</dt>
			<c:forEach var="parent" items="${menu}" varStatus="status">	
				<c:if test="${parent.status == 1 && parent.name == 'Footer'}">
					<c:forEach var="child" items="${parent.children}" varStatus="status">	
						<store:menu menuItem="${child}" maxLevel="2" type="dd" />
					</c:forEach>
				</c:if>
			</c:forEach>
			<dd><a href="mailto:beesden@gmail.co.uk" title="Site built by Beesden" target="_blank"><fmt:message key="bees.footer.site.built.by.beesden" /></a>
		</dl>
	
	</section>
</footer>