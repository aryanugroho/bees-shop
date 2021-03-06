<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>

<!doctype html>
<html lang="en">

<head> 
	<link rel="stylesheet" type="text/css" href="/assets/styles/styles.css" />
	<link rel="stylesheet" type="text/css" href="/assets/client/client.css" />
	<link rel="shortcut icon" href="/assets/favicon.ico">

	<script src="/assets/scripts/scripts.js"></script>
	<script src="/assets/client/client.js"></script>
	
	<jsp:include page="template/meta.jsp" />
	<c:if test="${!empty config.customStyles}">${config.customStyles}</c:if>	
	
</head>

<body>

<div id="main" class="wrapper <c:if test="${!empty pageType}">${pageType} ${pageType}-${content.name}</c:if>">

	<jsp:include page="template/header.jsp" />

	<article class="article container">
		<section>
		<div id="info" class="content">
			<tiles:insertAttribute name="content" />
		</div>
		</section>	
		<c:if test="${(!empty content.promotionList || !empty promotions) && !param.ajax}">
			<jsp:include page="template/promotions.jsp" />
		</c:if>
	</article>	

	<jsp:include page="template/footer.jsp" />

</div>

</body>
</html>