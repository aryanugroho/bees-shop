<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<ul class="element accountLinks">

	<li><a class="button ${pageType eq 'account-home' ? 'advance' : 'return'}" href="/account/home">
		<fmt:message key="bees.accountmenu.account.home" />
	</a></li>
	
	<li><a class="button ${pageType eq 'account-address' ? 'advance' : 'return'}" href="/account/address">
		<fmt:message key="bees.accountmenu.manage.addresses" />
	</a></li>
	
	<li><a class="button ${pageType eq 'account-order' ? 'advance' : 'return'}" href="/account/orders">
		<fmt:message key="bees.accountmenu.view.orders" />
	</a></li>
	
	<li><a class="button return" href="/account/logout">
		<fmt:message key="bees.accountmenu.logout" />
	</a></li>
</ul>