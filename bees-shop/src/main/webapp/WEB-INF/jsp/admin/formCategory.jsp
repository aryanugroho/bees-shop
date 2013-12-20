<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<admin:content name="category">	

	<dl class="dropList">
		<dt>Category Hierarchy</dt>		
		<admin:input name="categoryParents" type="multiple">
				<c:forEach items="${categoryList}" var="cat">
					<c:if test="${cat.id != category.id }">
						<c:set var="exists" value="false" />
						<c:forEach var="parent" items="${category.parents}">
							<c:if test="${cat.id == parent.id}"><c:set var="exists" value="true" /></c:if>
						</c:forEach>
						<option value="${cat.id}" ${exists ? 'selected="selected"' : ''}>${cat.heading}</option>
					</c:if>
				</c:forEach>
		</admin:input>
		<admin:input name="categoryChildren" type="multiple">
				<c:forEach items="${categoryList}" var="cat">
					<c:if test="${cat.id != category.id }">
						<c:set var="exists" value="false" />
						<c:forEach var="child" items="${category.children}">
							<c:if test="${cat.id == child.id}"><c:set var="exists" value="true" /></c:if>
						</c:forEach>
						<option value="${cat.id}" ${exists ? 'selected="selected"' : ''}>${cat.heading}</option>
					</c:if>
				</c:forEach>
		</admin:input>
	</dl>

	<dl class="dropList">
		<dt>Category Content</dt>
		<admin:input name="sortOrder" type="select">
			<option value="">Select sort order</option>
			<c:forTokens var="sort" items="name,price ASC, price DESC,id" delims=",">
				<option value="${sort}" <c:if test="${category.sortOrder == sort}"> selected="selected"</c:if>>${sort}</option>
			</c:forTokens>
		</admin:input>
		<admin:input name="layout" type="select">
			<c:forTokens var="layout" items="list,dept" delims=",">
				<option value="${layout}" <c:if test="${category.layout == layout}"> selected="selected"</c:if>>${layout}</option>
			</c:forTokens>
		</admin:input>

		<dd id="category-products">
			<ul>
				<c:forEach var="product" items="${category.products}">
					<c:set var="product" value="${product[0]}" />
					<li class="status=${product.status}">
						<span class="image"><img src="/assets/client/product/small/${util:url(product.name)}.jpg" alt="${product.heading}" /></span>
						<span class="title">${product.name}</span>
						<span class="price">From <fmt:formatNumber value="${product.minPrice}" currencySymbol="&pound;" type="currency"/></span>
					</li>
				</c:forEach>
			</ul>
		</dd>
	</dl>

</admin:content>