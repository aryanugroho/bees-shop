<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:content name="variant">

	<dl class="dropList">
		<dt>Variant Stuff</dt>
		<c:forEach var="product" items="${productList }">
			<option value="${product.id}" <c:if test="${variant.product.id == product.id}"> selected="selected"</c:if>>${product.heading}</option>
		</c:forEach>
		<admin:input name="price" type="number" />
		<admin:input name="stock" type="number" />
	</dl>
	
</admin:content>