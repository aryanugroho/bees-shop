<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="store" tagdir="/WEB-INF/tags/store" %>
<%@ taglib prefix="util" uri="/WEB-INF/tags/beesden.tld" %>

<%@ attribute name="object" type="org.beesden.shop.model.Product" required="true" %>

<div class="product" id="product">
		
	<h1 class="productInfo">${object.heading}</h1>
		
	<div class="images" id="productImages">
		<div class="large">
			<a href="/assets/client/product/large/${util:url(object.name)}.jpg">
				<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}.jpg" alt="${object.heading}" />
			</a>
		</div>

		<c:if test="${!param.ajax}">
			<div class="small">
				<a href="/assets/client/products/large/${util:url(object.name)}-1.jpg">
					<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}-1.jpg" alt="${object.heading}" />
				</a>
				<a href="/assets/client/products/large/${util:url(object.name)}-2.jpg">
					<img class="preview" src="/assets/client/product/normal/${util:url(object.name)}-2.jpg" alt="${object.heading}" />
				</a>
			</div>
		</c:if>
	</div>

	<div class="productInfo">

		<div class="info">		
			<c:if test="${!empty object.productCode}">
				<p class="productCode"><strong><fmt:message key="bees.product.code" /></strong> ${object.productCode}</p>
			</c:if>	
			<c:if test="${!empty object.description}">
				<div class="description">
					<h2><fmt:message key="bees.product.description" /></h2>
					${object.description}
				</div>
			</c:if>
			<c:if test="${!param.ajax}">
				<ul id="socialShare" class="socialShare">
					<li><div id="fb-root"></div><div class="fb-like" data-width="450" data-layout="button_count" data-show-faces="false" data-send="false"></div></li>
					<li><a href="https://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a></li>
					<li><div class="g-plusone" data-size="medium" data-annotation="none"></div></li>
					<li><a href="//pinterest.com/pin/create/button/?url=http%3A%2F%2Fwww.flickr.com%2Fphotos%2Fkentbrew%2F6851755809%2F&media=http%3A%2F%2Ffarm8.staticflickr.com%2F7027%2F6851755809_df5b2051c9_z.jpg&description=Next%20stop%3A%20Pinterest" data-pin-do="buttonPin" data-pin-config="none">Pin</a></li>
				</ul>
			</c:if>
		</div>
		
		<form:form action="/checkout/basket/add" method="POST" cssClass="productSection" modelAttribute="basketItem">
		
			<input type="hidden" name="productId" value="${object.id}" />
			
			<c:if test="${!empty object.availability}">
				<p><strong><fmt:message key="bees.product.availablity.${object.availability}" /></strong></p>
			</c:if>
			
			<p class="price">
				<fmt:message key="bees.product.${object.minPrice < object.maxPrice ? 'from' : 'price' }">
					<fmt:param><fmt:formatNumber value="${object.minPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${object.maxPrice}" currencySymbol="&pound;" type="currency"/></fmt:param>
				</fmt:message>
			</p>

			<fieldset>
				<legend><fmt:message key="bees.product.form" /></legend>
				<ol>
					<li>
						<label class="label" for="quantity" /><fmt:message key="bees.product.quantity" /></label>
						<form:input id="quantity" class="input number" type="number" path="quantity" value="1" />
					</li>
				</ol>
			</fieldset>
			
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
			
			<c:if test="${config.paymentStatus}"><button class="button advance"><fmt:message key="bees.product.add.to.basket" /></button></c:if>

		</form:form>
	</div>
	
</div>