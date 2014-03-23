<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<header class="header container">
	<section>
		<a class="logo" title="Home" href="/">${config.companyName}</a>
		
		<c:if test="${!empty basket.items}">			
			<c:set var="basketSize" value="0" />
			<c:forEach items="${basket.items}" var="item">
				<c:set var="basketSize" value="${basketSize + item.quantity}" />
			</c:forEach>
		</c:if>
		
		<ul class="account">
			<li class="menuLink"><label class="menuToggle" for="menuToggle"><span><fmt:message key="bees.header.menu" /></span></label>
			<c:if test="${config.enableAccount}">
				<li class="accountLink"><a href="/account/home"><span><fmt:message key="bees.header.my.account" /></span></a></li>
			</c:if>			
			<c:if test="${config.enableSearch}">
				<li class="searchLink"><a href="/search"><span><fmt:message key="bees.header.search" /></span></a></li>
			</c:if>
			<c:if test="${config.paymentStatus}">
				<li class="basketLink" id="basketLink">
					<jsp:include page="../checkout/basket.jsp">
						<jsp:param name="minibasket" value="true" />
					</jsp:include>
				</li>
			</c:if>
		</ul>
		
		<input class="menuToggle" type="checkbox" id="menuToggle" name="menuToggle" />

		<nav class="menu">	
			<label class="menuToggle" for="menuToggle"><fmt:message key="bees.header.menu.hide" /></label>	
			<c:if test="${config.enableSearch}">
				<form action="/search" class="searchForm" id="searchForm">
					<fieldset>
						<legend><fmt:message key="bees.header.search" /></legend>
						<store:input name="keywords" type="search" />
					</fieldset>
					<button class="button"><fmt:message key="bees.header.search" /></button>
				</form>
			</c:if>
			<ol>
				<c:forEach var="parent" items="${menu}" varStatus="status">	
					<c:if test="${parent.status == 1 && parent.name == 'Top Navigation'}">
						<c:forEach var="child" items="${parent.children}" varStatus="status">	
							<store:menu menuItem="${child}" maxLevel="${config.enableDropDown}" type="li" />
						</c:forEach>
						<input type="radio" name="showMenu" id="menu_hideChildren" class="menuChildToggle" />
					</c:if>
				</c:forEach>			
			</ol>
		</nav>
	</section>
</header>