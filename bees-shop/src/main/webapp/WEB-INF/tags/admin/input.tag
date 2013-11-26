<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ attribute name="name" type="java.lang.String" required="true" %>
<%@ attribute name="type" type="java.lang.String" required="false" %>
<%@ attribute name="value" type="java.lang.String" required="false" %>
<%@ attribute name="placeholder" type="java.lang.String" required="false" %>

<c:set var="value" value="${value == '[null]' ? '' : empty value && type != 'select' && type == 'multiple' ? adminForm[name] : value}" />
<c:set var="extras">
	<c:if test="${!empty placeholder}">placeholder="${placeholder}"</c:if>
</c:set>

<c:choose>

	<c:when test="${type != 'hidden'}">
		<dd>
			<%-- Form label --%>
			<form:label cssClass="label" path="${name}">${name}:</form:label>
			
			<c:choose>
				<%-- Select box --%>
				<c:when test="${type == 'select' || type == 'multiple'}">
					<form:select cssClass="input ${type}" path="${name}" multiple="${type == 'multiple' ? 'multiple' : '' }">
						<jsp:doBody />
					</form:select>
				</c:when>
				
				<%-- Text area --%>
				<c:when test="${type == 'textarea' || type == 'ckedit'}">
					<form:textarea cssClass="${type == 'ckedit' ? 'input ckedit' : 'input'}" path="${name}" />
				</c:when>
				
				<%-- Radio Buttons --%>
				<c:when test="${type == 'radio'}">
					<div class="multiple">
						<c:forTokens var="item" items="${value}" delims=",">
							<span>
								<form:radiobutton cssClass="${type}" path="${name}" label="${item}" value="${item}" />
							</span>
						</c:forTokens>
					</div>
				</c:when>
				
				<%-- Checkbox --%>
				<c:when test="${type == 'checkbox'}">
					<form:checkbox cssClass="${type}" path="${name}" value="${empty value ? true : value}" />
				</c:when>
				
				<%-- Normal text inputs --%>
				<c:otherwise>
					<form:input type="${empty type || type == 'date' ? 'text' : type}" cssClass="input ${type}" path="${name}" value="${value}"  />
				</c:otherwise>
			</c:choose>
			
			<%-- Show errors if any --%>
			<form:errors path="${name}" cssClass="errorblock" element="div" />
		</dd>
	</c:when>
	
	<c:otherwise>
		<%-- Hidden text inputs --%>
		<form:hidden path="${name}" value="${value}" />
	</c:otherwise>
</c:choose>