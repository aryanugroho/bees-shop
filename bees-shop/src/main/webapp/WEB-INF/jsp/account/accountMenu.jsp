<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<c:set var="step"><tiles:getAsString name="step" ignore="true"/></c:set>

<ul class="accountMenu">
	<c:forTokens delims="," items="home,contact,password,payment,addresses,orders" var="accSection">
		<li class="${step == accSection ? 'current' : ''}">
			<a href="/account/${accSection}">
				<fmt:message key="bees.accountmenu.account.${accSection}" />
			</a>
		</li>
	</c:forTokens>
	
	<li><a class="return" href="/account/logout">
		<fmt:message key="bees.accountmenu.logout" />
	</a></li>
</ul>