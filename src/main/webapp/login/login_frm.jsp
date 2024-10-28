<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en" data-bs-theme="auto">
<head>
<!-- JQuery CD작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script src="http://192.168.10.229/jsp_prj/login/js/color-modes.js"></script>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById("id").addEventListener("keyup", entreKey);
		document.getElementById("pass").addEventListener("keyup", entreKey);
		document.getElementById("loginBut").addEventListener("click", chkNull);
	}

	function entreKey(evt) {
		if (evt.which == 13) {
			chkNull();
		}
	}
	function chkNull() {
		var obj = document.loginFrm;

		var idNode = obj.id;
		if (idNode.value.replaceAll(/ /g, "") == "") {
			idNode.focus();
			return;
		}

		var passNode = obj.pass;
		if (passNode.value.replaceAll(/ /g, "") == "") {
			passNode.focus();
			return;
		}

		$("#loginFrm").submit();
	}
</script>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.122.0">
<title>Signin Template · Bootstrap v5.3</title>
<link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sign-in/">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link href="http://192.168.10.229/jsp_prj/login/css/bootstrap.min.css" rel="stylesheet">
<meta name="theme-color" content="#712cf9">

<!-- Custom styles for this template -->
<link href="http://192.168.10.229/jsp_prj/login/sign-in.css"
	rel="stylesheet">
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">

	<main class="form-signin w-100 m-auto">
		<form name="loginFrm" id=loginFrm action="login_frm_process.jsp"
			method="post">
			<h1 class="h3 mb-3 fw-normal">로그인</h1>

			<div class="form-floating">
				<input type="text" name="id" id="id" class="form-control"
					placeholder="name@example.com">
			</div>
			<div class="form-floating">
				<input type="password" name="pass" id="pass" class="form-control"
					placeholder="Password">
			</div>

			<input class="btn btn-primary w-100 py-2" type="button" value="로그인"
				id="loginBut">
		</form>
	</main>
	<script
		src="http://192.168.10.229/jsp_prj/login/js/bootstrap.bundle.min.js"></script>

</body>
</html>
