<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>
<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="panel" tagdir="/WEB-INF/tags/panels" %>

<!DOCTYPE html>

<html lang="en">
<head>
	<title><fmt:message key="bees.error.title" /></title>
	<link href="/assets/styles/styles.css" type="text/css" rel="stylesheet"/>	
	<link rel="shortcut icon" href="/assets/client/favicon.ico">
</head>
<body>

<div id="main" class="wrapper error-page">
	<header class="header container">	
		<section>
			<a class="logo" title="Home" href="/"></a>
			<form action="/search" class="searchForm">
				<input class="input" name="keywords" value="${param.keywords}" type="text" />
				<input class="button" type="submit" value="Search" />
			</form>
		</section>
	</header>
			
	<article class="article container">
		<section>	
			<div id="info" class="content">
				<h1>Page Error</h1>
				<div class="message">
					<p><fmt:message key="bees.error.summary" /></p>
					<p><fmt:message key="bees.error.link" /></p>
				</div>
			</div>
		</section>
	</article>
</div>

</body>
</html>