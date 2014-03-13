<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="address" type="org.beesden.shop.model.Address" required="true" %>
<%@ attribute name="delimiter" required="false" %>
<%@ attribute name="type" required="false" %>

<c:if test="${!empty type}">	
	<c:set var="open" value="<${type}>" />
	<c:set var="close" value="</${type}>" />
</c:if>
<c:set var="delimiter" value="${delimiter == '[null]' ? '' : empty delimiter ? ', ' : delimiter}" />

<c:set var="returnAddress">
	<c:if test="${!hideCustomer && !(empty address.title && empty address.firstname && empty address.surname)}">
		${open}<c:out value="${address.title} ${address.firstname} ${address.surname}${delimiter}" />${close}
	</c:if>

	<c:forTokens var="line" delims="," items="address1,address2,address3,city,region,postalCode">
		<c:if test="${!empty address[line]}">
			${open}<c:out value="${address[line]}${delimiter}" />${close}		
		</c:if>
	</c:forTokens>
</c:set>

<c:set var="returnAddress" value="${fn:trim(returnAddress)}" />
${fn:substring(returnAddress, 0, fn:length(returnAddress) - fn:length(empty close ? fn:trim(delimiter) : delimiter) - fn:length(close))}${close}