<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:content name="category">	

	<dl class="dropList">
		<dt>Category Content</dt>
		<admin:input name="sortOrder" type="select">
			<option value="">Select sort order</option>
			<c:forTokens var="sort" items="name,price ASC, price DESC,id" delims=",">
				<option value="${sort}" <c:if test="${category.sortOrder == sort}"> selected="selected"</c:if>>${sort}</option>
			</c:forTokens>
		</admin:input>
	</dl>

</admin:content>