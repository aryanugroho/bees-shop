<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<%@ attribute name="name" type="java.lang.String" required="true" %>

<admin:form name="${name}">

	<dl>
		<dt>Variant Status</dt>
		<dd>Please fill in variant information below:</dd>
		<admin:input name="heading" />
		<admin:input name="status" type="select">
			<option value="1" <c:if test="${requestScope[name].status == 1}">selected="selected"</c:if>>Active</option>
			<option value="2" <c:if test="${requestScope[name].status == 2}">selected="selected"</c:if>>On Hold</option>
			<option value="3" <c:if test="${requestScope[name].status == 3}">selected="selected"</c:if>>Deleted</option>
		</admin:input>
		<admin:input name="description" type="ckedit" />
	</dl>
	
	<jsp:doBody />
	
	<dl class="dropList">
		<dt>SEO Components</dt>
		<admin:input name="name" />
		<admin:input name="promotionId" type="select">
			<option value="">Select a promotion</option>
			<c:forEach var="promotion" items="${categoryList }">
				<option value="${promotion.id}" <c:if test="${requestScope[name].promotionList.id == promotion.id}"> selected="selected"</c:if>>${promotion.heading}</option>
			</c:forEach>
		</admin:input>
		<admin:input name="seoTitle" />
		<admin:input name="seoDescription" type="textarea" />
	</dl>
		
	</admin:form>