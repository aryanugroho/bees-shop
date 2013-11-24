<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header class="header container">	
	<section>
		<a class="logo" title="Home" href="/">${config.companyName}</a>
		
		<c:if test="${!empty basket.items}">			
			<c:set var="basketSize" value="0" />
			<c:forEach items="${basket.items}" var="item">
				<c:set var="basketSize" value="${basketSize + item.quantity}" />
			</c:forEach>
		</c:if>
		
		<c:if test="${config.enableAccount}">
			<ul class="account">
				<li><a class="viewAccount" href="/account/home"><span><fmt:message key="bees.header.my.account" /></span></a></li>
				<li><a class="viewSearch" href="/search"><span><fmt:message key="bees.header.search" /></span></a></li>
				<c:if test="${config.paymentStatus}">
					<li id="basketLink"><a class="viewBasket" href="/checkout/basket"><span><fmt:message key="bees.header.my.basket" /> (${basketSize})</span></a></li>
				</c:if>
			</ul>
		</c:if>
		
		<c:if test="${config.enableSearch}">
			<form action="/search" class="searchForm" id="searchForm">
				<input class="input" name="keywords" value="${param.keywords}" type="text" />
				<input class="button" type="submit" value="Search" />
			</form>
		</c:if>
		
	</section>
</header>