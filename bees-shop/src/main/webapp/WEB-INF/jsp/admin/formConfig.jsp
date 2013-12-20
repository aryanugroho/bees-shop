<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:form name="config">

	<admin:input type="hidden" name="status" value="1" />

	<dl>
		<dt>Configuration</dt>
		<dd>Please fill in configuration option information below:</dd>
		<admin:input name="name" />
		<admin:input name="description" type="textarea" />
		<admin:input name="type" type="select">
			<c:forTokens var="type" items="string,boolean,integer,map" delims=",">
				<option value="${type}" <c:if test="${config.type == type}"> selected="selected"</c:if>>${type}</option>
			</c:forTokens>
		</admin:input>
		<c:set var="typeDisplay" value="${config.type == 'boolean' ? 'checkbox' : config.type == 'integer' ? 'number' : 'textarea'}" />
		<admin:input name="value" type="${typeDisplay}" value="${config.value}" />
		
	</dl>
	
</admin:form>