<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

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
		<%--
		<dd id="category-products">
			<c:forEach var="product" items="${category.products}">
				${product }
				<c:forEach var="ss" items="${product}"><hr />${ss.name}</c:forEach>
				<div class="status-${product}">${product}</div>
			</c:forEach>
		</dd>
		--%>
	</dl>

</admin:content>