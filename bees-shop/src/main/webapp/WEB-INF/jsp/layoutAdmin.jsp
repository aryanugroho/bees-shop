<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!doctype html>
<!-- Hello there! I hope you like the code I've written :) -->
<html lang="en">

<head>
	<link rel="shortcut icon" href="/assets/styles/admin/admin.ico">
  	<link href="/assets/styles/admin.css" type="text/css" rel="stylesheet" />
  	
	<script src="/assets/scripts/plugin/jquery.js"></script>
	<script src="/assets/scripts/plugin/jquery-ui.js"></script>
	<script src="/assets/scripts/plugin/jquery.validate.js"></script>
	<c:if test="${pageType == 'order'}"><script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script></c:if>
	<script src="/assets/scripts/admin.js"></script>        
	  	
  	<title>Admin Area</title>
	<meta name="viewport" content="width=device-width" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<input type="hidden" id="pageUrl" value="" />

<div class="header">
	<a class="logo" href="/admin/home"></a>		

	<ul class="menu">
		<li class="content">
			<a href="#"><span>Store Content</span></a>
			<ul>				
				<li><a href="/admin/categoryList">Categories</a></li>
				<li><a href="/admin/productList">Products</a></li>
				<li><a href="/admin/variantList">Variants</a></li>
				<li><a href="/admin/pageList">Content</a></li>
			</ul>
		</li>
		
		<li class="orders">
			<a href="#"><span>Online Sales</span></a>
			<ul>	
				<li><a href="/admin/orders">Orders</a></li>
				<li><a href="/admin/customerList">Customers</a></li>
				<li><a href="/admin/addressList">Site Enquiries</a></li>
			</ul>
		</li>
		
		<li class="configuration">
			<a href="#"><span>System Settings</span></a>
			<ul>			
				<li><a href="/admin/configList">System Config</a></li>					
				<li><a href="/admin/deliveryList">Delivery Charges</a></li>	
				<li><a href="/admin/userList">User Manager</a></li>
			</ul>
		</li>
		
		<li class="configuration"><a href="/logout"><span>Logout</span></a></li>
	</ul>
</div>

<div class="container">
	<div id="content">	
		<tiles:insertAttribute name="content" />

		<div class="form-space">
			<p class="message"><c:choose>
				<c:when test="${!empty message}">${message}</c:when>
				<c:otherwise>Please select a ${form.type}</c:otherwise>
			</c:choose></p>

		</div>
	</div>
</div>
		
<div class="footer">
	<span>&copy; Beesden Web Design</span>
	<span><a href="mailto:beesden@gmail.com" target="_blank">Contact Us</a></span>
</div>

</body>
</html>