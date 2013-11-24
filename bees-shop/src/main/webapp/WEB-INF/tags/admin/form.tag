<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<%@ attribute name="name" type="java.lang.String" required="true" %>

<div id="formView">

	<form:form commandName="${name}" cssClass="itemForm" action="/admin/${name}" method="POST">
	
		<%-- Form errors --%>
		<form:errors path="*"  />
	
		<%-- Logged Information --%>
		<admin:input type="hidden" name="createdBy" />
		<admin:input type="hidden" name="dateCreated" />
		<admin:input type="hidden" name="lastEdited" />
		<admin:input type="hidden" name="lastEditedBy" />
		
		<%-- Set object id --%>
		<admin:input type="hidden" name="id" />
	
		<%-- Set return url --%>
		<input type="hidden" name="returnUrl" value="${url.ref}" />
			
		<jsp:doBody />
	
		<%-- Form buttons --%>
		<div class="buttons">
			<button class="button save" type="submit" name="save">Save</button>
			<button class="button cancel" type="reset" name="cancel">Revert</button>
		</div>
	
	</form:form>
</div>