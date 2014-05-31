<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<h1><fmt:message key="bees.account.title" /></h1>

<jsp:include page="accountMenu.jsp" />

<div class="accountSection">
	<h2><fmt:message key="bees.account.title.${layout}" /></h2>
	<tiles:insertAttribute name="subject" ignore="true" />
</div>
