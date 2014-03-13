<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="category" type="org.beesden.shop.model.Category" required="true" %>

<div class="categoryFilters">

	<%-- Category 'hierarchy' if not a search --%>
	<c:if test="${!empty category.name}">
		<dl class="hierarchy">
			<dt>Category tree</dt>
			<c:choose>
				<c:when test="${!empty category.parents}">
					<c:forEach var="parent" items="${category.parents}" varStatus="status">
						<dd>
							<a href="/category/${util:url(parent.name)}" title="Anniversary flowers">${parent.heading}</a>
							<ul>
								<li><span>${category.heading}</span></li>
							</ul>
						</dd>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<dd>
						<span>${category.heading}</span>
						<c:if test="${!empty category.children}">
							<ul>
								<c:forEach var="child" items="${category.children}" varStatus="status">
									<li><a href="/category/${util:url(child.name)}" title="Anniversary flowers">${child.heading}</a></li>
								</c:forEach>
							</ul>
						</c:if>
					</dd>
				</c:otherwise>
			</c:choose>
		</dl>
	</c:if>

	<dl>
		<dt>Brand</dt>
		<dd class="active"><a href="#">Sony</a></dd>
		<dd><a href="#">Google</a></dd>
		<dd><a href="#">Apple</a></dd>
		<dd><a href="#">Samsung</a></dd>
		<dd><a href="#">Dell</a></dd>
	</dl>

	<dl>
		<dt>Colours</dt>
		<dd><a href="#">Red</a></dd>
		<dd><a href="#">Blue</a></dd>
		<dd><a href="#">Green</a></dd>
		<dd class="active"><a href="#">Orange</a></dd>
		<dd><a href="#">Silver</a></dd>
	</dl>
</div>