<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="object" type="org.beesden.shop.model.Product" required="true" %>

<div class="product" id="product">
		
	<div class="images" id="productImages">
		<div class="large">
			<a class="image" href="/assets/client/product/large/${util:url(object.name)}.jpg">
				<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}.jpg" alt="${object.heading}" />
			</a>
		</div>

		<div class="small">
			<a class="image" href="/assets/client/products/large/${util:url(object.name)}-1.jpg">
				<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}-1.jpg" alt="${object.heading}" />
			</a>
			<a class="image" href="/assets/client/products/large/${util:url(object.name)}-2.jpg">
				<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}-2.jpg" alt="${object.heading}" />
			</a>
		</div>
	</div>
	
	<form:form action="/checkout/basket/add" method="POST" cssClass="productSection" modelAttribute="basketItem">
	
		<input type="hidden" name="productId" value="${object.id}" />
		
		<c:if test="${!empty object.heading}"><h1>${object.heading}</h1></c:if>
		
		<span class="price">
			<fmt:message key="bees.product.${object.minPrice < object.maxPrice ? 'from' : 'price' }">
				<fmt:param><fmt:formatNumber value="${object.minPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${object.maxPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
			</fmt:message>
		</span>
		
		<c:choose>
			<c:when test="${object.availability == 2}"><p><strong><fmt:message key="bees.product.special.offer" /></strong></p></c:when>
			<c:when test="${object.availability == 3}"><p><strong><fmt:message key="bees.product.out.of.stock" /></strong></p></c:when>
			<c:when test="${object.availability == 4}"><p><strong><fmt:message key="bees.product.please.call.to.order" /></strong></p></c:when>
		</c:choose>
		
		<c:if test="${!empty object.description}">
			<div class="description">${object.description}</div>
		</c:if>
		
		<div class="variants">
			<c:forEach var="variant" items="${object.variants}" varStatus="s">
				<c:choose>
					<c:when test="${fn:length(object.variants) == 1}">
						<input type="hidden" name="variantId" value="${variant.id}" />
					</c:when>
					<c:otherwise>
						<fmt:formatNumber var="variantPrice" value="${variant.price}" currencySymbol="&pound;" type="currency"/>
						<h2 class="formSelect variant">
							<input type="radio" name="variantId" id="variant-${s.index}" value="${variant.id}" />
							<label for="variant-${s.index}">${variant.name} - ${variantPrice}</label>
						</h2>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		
		<p class="quantity"><fmt:message key="bees.product.quantity" /><form:input class="input number" type="number" path="quantity" value="1" /></p>
		
		<div class="buttons">
			<c:if test="${!quickView}"><a class="button return" href="${url.ref}"><fmt:message key="bees.product.return" /></a></c:if>
			<c:if test="${quickView}"><a class="button return" href="/product/${util:url(object.name)}"><fmt:message key="bees.product.view.details" /></a></c:if>
			<c:if test="${config.paymentStatus}"><button class="button advance"><fmt:message key="bees.product.add.to.basket" /></button></c:if>
		</div>
	</form:form>
	
</div>