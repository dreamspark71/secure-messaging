<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
<title>Homepage</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/mainpagestyle.css">
/* AES JavaScript implementation */
<script src="${pageContext.request.contextPath}/static/js/aes.js"></script>
/* AES Counter Mode implementation */
<script src="${pageContext.request.contextPath}/static/js/aes-ctr.js"></script>

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

.btn {
	margin-top: 3%;
	margin-left: 40%;
}
</style>
<script>
	'use strict';
	var doc = document;
	doc.qrySel = doc.querySelector;
	doc.qrySelAll = doc.querySelectorAll; // shortforms

	document.addEventListener('DOMContentLoaded', function(event) {
		doc.qrySel('#password').oninput = function() {
			var password = doc.qrySel('#password').value;
			var plaintxt = doc.qrySel('#plaintxt').value;
			var t1 = performance.now();
			var encrtext = AesCtr.encrypt(plaintxt, password, 256);
			var t2 = performance.now();
			doc.qrySel('#encrtext').value = encrtext;
			//doc.qrySel('#time-encrypt').value = (t2-t1).toFixed(3)+'ms';
			doc.qrySel('#encrtext').oninput(); // trigger decrypt
		};

		doc.qrySel('#plaintxt').oninput = function() {
			var password = doc.qrySel('#password').value;
			var plaintxt = doc.qrySel('#plaintxt').value;
			var t1 = performance.now();
			var encrtext = AesCtr.encrypt(plaintxt, password, 256);
			var t2 = performance.now();
			doc.qrySel('#encrtext').value = encrtext;
			//doc.qrySel('#time-encrypt').value = (t2-t1).toFixed(3)+'ms';
			doc.qrySel('#encrtext').oninput(); // trigger decrypt
		};

		doc.qrySel('#password').oninput(); // trigger initial hash

	});
</script>

</head>
<body onload='document.loginForm.username.focus();'>
	<div class="container">
		<hr>
		<h1 style="text-align: center">MyTrekAdvisor</h1>
		<hr />
		<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
		<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
			
			function formlogin() {
				document.location.href = 'login';
			}
		</script>

		<c:if test="${ empty pageContext.request.userPrincipal.name}">
			<h2 style="text-align: center">
				For Login | <a href="javascript:formlogin()"> Click Here</a>
			</h2>
		</c:if>
		<c:if test="${ not empty pageContext.request.userPrincipal.name}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
			<body class="container">

	<div class="text-center mx-auto">
		<h1> Hello </h1><h2 id="user"></h2>
	</div>

	<div style="margin-top: 5%;" class="container mx-auto">

		<div id="MathJax_Message" style="display: none;"></div>

		<script type="text/x-mathjax-config;executed=true">
  		MathJax.Hub.Config({
                tex2jax: {
                inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                processEscapes: true
                }
  		});
            </script>

		<table>
			<tr>
				<td colspan="2"><input type="text" id="username"
					placeholder="Username" />
					<button type="button" onclick="connect();">Connect</button> <br />
					<br /></td>
			</tr>
			<tr>
				<td><label>RECEIVED CIPHERTEXT</label> <input type="text"
					id="decrtext" />
					<button type="button" onclick="myfunction();">Decrypt</button></td>
			</tr>
			<tr>
				<td><br /> <label>ORIGINAL TEXT</label> <input type="text"
					size="51" id="originaltext" /> <br /></td>
			</tr>
			<tr>
				<td><br /> <textarea readonly="true" rows="10" cols="80"
						id="log"></textarea></td>
			</tr>

			<tr>
				<td><input type="text" size="15" id="to" placeholder="To" /> <input
					type="text" size="51" id="plaintxt" placeholder="Message" /> <br />
					<br /> <label>PASSPHRASE</label> <input type="text" size="51"
					id="password" value="secret passphrase" /> <br /> <br /> <label>CIPHERTEXT</label>
					<input type="text" size="51" id="encrtext"
					placeholder="Encrypted Text" />
					<button type="button" onclick="send();">Send</button> <!--                    <br />
                                Received CipherText:
                                <br />
                                <input type="text" size="51" id="decrtext" placeholder="Decrypted Text"/><br />-->

				</td>
			</tr>
		</table>

	</div>
		</c:if>
	</div>
</body>
<script src="${pageContext.request.contextPath}/static/js/script.js"></script>

<!-- Script for AES encryption and decryption -->
<script>
	function myfunction() {
		var password = document.getElementById("password").value;
		var encrtext = document.getElementById("decrtext").value;
		console.log("encrypted text" + " : " + encrtext);

		var decrypttext = AesCtr.decrypt(encrtext, password, 256);

		alert("message decrypted" + " : " + decrypttext);
		console.log("decrypted message" + "=" + decrypttext);

		document.getElementById("originaltext").value = decrypttext;

		log.innerHTML += "Decrypted Text: " + " : " + decrypttext + "\n";
		
		document.getElementById("decrtext").value = "";
		document.getElementById("originaltext").value = "";
	}
</script>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery-1.10.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>

<script src="${pageContext.request.contextPath}/static/js/MathJax.js"
	id=""></script>
<script src="${pageContext.request.contextPath}/static/js/jsencrypt.js"
	type="text/javascript"></script>

</html>