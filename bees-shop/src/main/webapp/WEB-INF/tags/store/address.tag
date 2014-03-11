<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="address" type="org.beesden.shop.model.Address" required="true" %>
<%@ attribute name="type" required="false" %>

<c:choose>
	<c:when test="${type == 'array'}">
		<c:set var="summary"><strong>${address.name}</strong><div>${address.telephone}</div><div><a href="mailto:${address.email}" target="_blank">${address.email}</a></div></c:set>
		['${summary}', '${address.geoLat}', '${address.geoLng}']
	</c:when>
	
	<c:otherwise>
		<c:if test="${!empty address.line1}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.line1}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
		
		<c:if test="${!empty address.line2}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.line2}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
		
		<c:if test="${!empty address.line3}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.line3}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
		
		<c:if test="${!empty address.locality}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.locality}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
		
		<c:if test="${!empty address.region}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.region}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
		
		<c:if test="${!empty address.postalCode}">
			<c:if test="${!empty type}"><${type}></c:if>
			${active && empty type ? ', ' : ''}${address.postalCode}
			<c:if test="${!empty type}"></${type}></c:if>
			<c:set var="active" value="${true}" />
		</c:if>
	</c:otherwise>
</c:choose>