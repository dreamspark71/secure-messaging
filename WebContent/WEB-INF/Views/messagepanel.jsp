<html>
<head>
<title>Secure Messaging</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/css/mainpagestyle.css">

<script src="${pageContext.request.contextPath}/static/js/aes.js">
	/* AES JavaScript implementation */
</script>
<script src="${pageContext.request.contextPath}/static/js/aes-ctr.js">
	/* AES Counter Mode implementation */
</script>


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
<script>
			function formSubmit() {
				document.getElementById("logoutForm").submit();
			}
			
			function formlogin() {
				document.location.href = 'login';
			}
		</script>


</head>

<body class="container">


<sec:authorize access="hasRole('ROLE_USER')">
<c:url value="/j_spring_security_logout" var="logoutUrl" />
		<form action="${logoutUrl}" method="post" id="logoutForm">
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
<c:if test="${ not empty pageContext.request.userPrincipal.name}">
			<h2>
				User : ${pageContext.request.userPrincipal.name} | <a
					href="javascript:formSubmit()"> Logout</a>
			</h2>
		</c:if>

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
</sec:authorize>
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

<!-- Script for AES encryption and decryption -->

</html>
