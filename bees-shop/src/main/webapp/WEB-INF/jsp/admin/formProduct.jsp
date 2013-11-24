<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:content name="product">

	<dl class="dropList">
		<dt>Product Settings</dt>
			<admin:input name="availability" type="select">
				<c:forEach var="status" begin="1" end="5">
					<option value="${status}" <c:if test="${product.availability == status}"> selected="selected"</c:if>>${status}</option>
				</c:forEach>
			</admin:input>
			<admin:input name="preOrderDate" type="date" />
	</dl>

	<dl class="dropList">
		<dt>Product Categories</dt>
			<admin:input name="categorySave" type="multiple">
					<c:forEach items="${categoryList}" var="cat">
						<c:set var="exists" value="false" />
						<c:forEach var="category" items="${product.categories}">
							<c:if test="${cat.id == category.id}"><c:set var="exists" value="true" /></c:if>
						</c:forEach>
						<option value="${cat.id}" ${exists ? 'selected="selected"' : ''}>${cat.heading}</option>
					</c:forEach>
			</admin:input>
	</dl>

	<dl class="dropList">
		<dt>Product Variants</dt>
		<c:forEach items="${adminForm.variants}" var="variant">
			<dd>
				<a class="title" href="/admin/variant?name=${variant.name}">${variant.heading}</a> - 
				<fmt:formatNumber value="${variant.price}" currencySymbol="&pound;" type="currency"/> | 
				<em class="status">
					<c:if test="${variant.stock > 0}">${variant.stock}</c:if>
					${variant.status > 0 || variant.status < 0 ? 'In stock' : 'Out of stock'}
				</em>
			</dd>
		</c:forEach>
	</dl>

</admin:content>