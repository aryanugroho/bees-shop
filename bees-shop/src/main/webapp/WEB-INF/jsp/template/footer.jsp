<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<footer class="footer container">
	<section>
	
		<dl class="sitemap">
			<dt><fmt:message key="bees.footer.pages" /></dt>
			<dd><a href="/"><fmt:message key="bees.home.title" /></a></dd>
			<c:forEach var="parent" items="${menuItems}" varStatus="status">	
				<c:if test="${parent.type == 1}">
					<store:menu menuItem="${parent}" maxLevel="1" type="dd" />
				</c:if>
			</c:forEach>
		</dl>
		
		<dl class="groups">
			<dt><fmt:message key="bees.footer.groups" /></dt>
			<c:forEach var="parent" items="${menuItems}" varStatus="status">	
				<c:if test="${parent.type == 2}">
					<store:menu menuItem="${parent}" maxLevel="1" type="dd" />
				</c:if>
			</c:forEach>
		</dl>
		
		<dl class="address">
			<c:forEach var="add" items="${addresses}">
				<c:if test="${!empty add.name}">
					<dt>${add.name}</dt>
				</c:if>
				<dd><store:address address="${add}" type="span" />
				<c:if test="${!empty add.telephone}"><dd>${add.telephone}</dd></c:if>
				<c:if test="${!empty add.email}"><dd><a href="mailto:${add.email}" target="_blank">${add.email}</a></dd></c:if>
			</c:forEach>
		
		</dl>
		
		<dl class="legal">
			<dt>${config.companyName}</dt>
			<c:forEach var="parent" items="${menuItems}" varStatus="status">	
				<c:if test="${parent.type == 3}">
					<store:menu menuItem="${parent}" maxLevel="1" type="dd" />
				</c:if>
			</c:forEach>
			<dd><a href="mailto:beesden@gmail.co.uk" title="Site built by Beesden" target="_blank"><fmt:message key="bees.footer.site.built.by.beesden" /></a>
		</dl>
	
	</section>
</footer>