<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
<title>Login Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.error {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #a94442;
	background-color: #f2dede;
	border-color: #ebccd1;
}

.msg {
	padding: 15px;
	margin-bottom: 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #31708f;
	background-color: #d9edf7;
	border-color: #bce8f1;
}

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}

.btn {
	margin-top: 3%;
	margin-left: 40%;
}
</style>
</head>
<body onload='document.loginForm.username.focus();'>
	<div class="container">
		<hr>
		<h1 style="text-align: center">MyTrekAdvisor</h1>
		<hr/>
			<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
		</script>
		
			<c:if test="${ empty pageContext.request.userPrincipal.name}">
			<form name='loginForm'
			action="<c:url value='/auth/login_check?targetUrl=${targetUrl}' />"
			method='POST'>
			<div class="panel-group">
				<div class="col-sm-offset-4 col-md-offset-4 col-md-4  col-sm-6">
					<div class="panel panel-info">
						<div class="panel-heading text-center">
							<h4>User Authentication</h4>
						</div>
						<div class="panel-body">
							<div class="form-group">
								<label for="usr">Username</label> <input type="text"
									class="form-control" name='username' placeholder="admin">
							</div>
							
							<div class="form-group">
								<label for="pwd">Password</label> <input type="password"
									class="form-control" name='password' placeholder="123456">
							</div>

							<button type="submit" class="btn text-center btn-primary">Login</button>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</div>
					</div>

					<div class="text-center" style="margin-top: 2%">
						<c:if test="${not empty error}">
							<div class="error">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="msg">${msg}</div>
						</c:if>
					</div>
				</div>

			</div>
			
			</form>
		</c:if>
		<c:if test="${ not empty pageContext.request.userPrincipal.name}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>
	</div>

	
</body>
</html>