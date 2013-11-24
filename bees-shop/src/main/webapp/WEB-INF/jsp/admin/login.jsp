<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en" id="loginPage">

<head>
  	<link href="/assets/styles/admin.css" type="text/css" rel="stylesheet"/>  	
	<link rel="shortcut icon" href="/assets/styles/admin/admin.ico">	
  	<title>Administrator Login</title>  
</head>

<body>
	<c:if test="${!empty message}">
		<p class="message">${message}</p>
		<c:remove var="message" scope="session"/>
	</c:if>	

	<div id="formView" class="loginWrapper">
		<form id="loginForm" method="post" action="/admin/login.do">	
			<span class="logoLarge">Beesden Web Design</span>	
			
			<label for="j_username">Username:</label>
			<input type="text" class="input" type="text" name="j_username" id="j_username" placeholder="username" autofocus="autofocus" />
			
			<label for="j_password">Password:</label>
			<input type="password" class="input" type="text" name="j_password" id="j_password" placeholder="password" />
			
			<div class="buttons">
				<input type="submit" class="button save" name="submit" value="login">
			</div>			
		</form>
	</div>
	
</body>
</html>