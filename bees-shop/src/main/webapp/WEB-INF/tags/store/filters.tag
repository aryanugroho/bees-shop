<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="category" type="org.beesden.shop.model.Category" required="true" %>

<div class="categoryFilters">

	<%-- Category 'hierarchy' if not a search --%>
	<c:if test="${!empty category.name}">
		<dl class="filterHierarchy">
			<dt>Shop by department</dt>
			<dd>
				<c:forEach var="parent" items="${category.parents}" end="0" varStatus="status">
					<c:choose>
						<c:when test="${parent.name == 'TOP-NAVIGATION'}">
							<span>${category.heading}</span>	
							<c:if test="${!empty category.children}">
								<ul>
									<c:forEach var="child" items="${category.children}" varStatus="status">
										<li><a href="/category/${util:url(child.name)}" title="Anniversary flowers">${child.heading}</a></li>
									</c:forEach>
								</ul>
							</c:if>		
						</c:when>
						<c:otherwise>
							<a href="/category/${util:url(parent.name)}" title="Anniversary flowers">${parent.heading}</a>					
							<ul>
								<li>
									<span>${category.heading}</span>
									<c:if test="${!empty category.children}">
										<ul>
											<c:forEach var="child" items="${category.children}" varStatus="status">
												<li><a href="/category/${util:url(child.name)}" title="Anniversary flowers">${child.heading}</a></li>
											</c:forEach>
										</ul>
									</c:if>
								</li>								
								<c:if test="${empty category.children}">
									<c:forEach var="child" items="${parent.children}" varStatus="status">
										<c:if test="${child.id != category.id}">
											<li><a href="/category/${util:url(child.name)}" title="Anniversary flowers">${child.heading}</a></li>
										</c:if>
									</c:forEach>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</dd>
		</dl>
	</c:if>

	<dl class="filterToggle">
		<dt>Brand</dt>
		<dd class="active"><a href="#">Sony</a></dd>
		<dd><a href="#">Google</a></dd>
		<dd><a href="#">Apple</a></dd>
		<dd><a href="#">Samsung</a></dd>
		<dd><a href="#">Dell</a></dd>
	</dl>

	<dl class="filterToggle">
		<dt>Colours</dt>
		<dd><a href="#">Red</a></dd>
		<dd><a href="#">Blue</a></dd>
		<dd><a href="#">Green</a></dd>
		<dd class="active"><a href="#">Orange</a></dd>
		<dd><a href="#">Silver</a></dd>
	</dl>

	<dl class="filterPrice">
		<dt>Price</dt>
		<dd>
			<form action="?">
				<label for="minPrice">Min Price</label>
				<input id="minPrice" class="priceSlider" type="range" name="minPrice" value="0" step="5" max="50" min="0" />
				<label for="maxPrice">Max Price</label>
				<input id="maxPrice" class="priceSlider" type="range" name="maxPrice" value="45" step="5" max="50" min="0" />
			</form>
		</dd>
	</dl>
</div>