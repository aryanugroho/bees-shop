<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>

<admin:form name="user">

	<dl>
		<dt>User Information</dt>
		<dd>Please fill in user's information below:</dd>
		<admin:input name="name" />
		<admin:input name="password" type="password" value="[null]" placeholder="Enter a new password" />
		<admin:input name="authority" type="select">
			<option value="1" <c:if test="${adminForm.authority == 1}">selected="selected"</c:if>>User</option> 
			<option value="2" <c:if test="${adminForm.authority == 2}">selected="selected"</c:if>>Administrator</option> 
		</admin:input>
		<admin:input name="status" type="checkbox" value="1" />
	</dl>
	
</admin:form>