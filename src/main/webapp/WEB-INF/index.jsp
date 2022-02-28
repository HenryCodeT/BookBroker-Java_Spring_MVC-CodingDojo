<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title> Titulo </title>
	<!-- Bootstrap -->
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<!-- Estilos Locales -->
	<link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
	<div class="m-2 p-2 mx-auto" style="width: 900px;">
		<h1 class="text-success">Welcome</h1>
		<p>Join our growing community.</p>
		<div class="d-flex mx-auto my-4 justify-content-between text-light"
			>
			<div class="border border-dark p-3 col-5 bg-dark">
				<h2 class="text-primary">Register</h2>
				<form:form action="/register" method="post" modelAttribute="newUser">
					<div class="mb-3 form-group">
						<form:label path="userName">UserName:</form:label>
						<form:input path="userName" class="form-control mb-3"  />
						<form:errors path="userName" class="text-danger mb-3 d-inline-block" />
					</div>
					<div class="mb-3 form-group">
						<form:label path="email">Email:</form:label>
						<form:input path="email" class="form-control mb-3"  />
						<form:errors path="email" class="text-danger mb-3 d-inline-block" />
					</div>
					<div class="mb-3 form-group">
						<form:label path="password">Password:</form:label>
						<form:input path="password" class="form-control mb-3"  />
						<form:errors path="password" class="text-danger mb-3 d-inline-block" />
					</div>
					<div class="mb-3 form-group">
						<form:label path="confirm">Confirm Password:</form:label>
						<form:input path="confirm" class="form-control mb-3"  />
						<form:errors path="confirm" class="text-danger mb-3 d-inline-block" />
					</div>
					<button class="btn btn-primary" type="submit">Register</button>
				</form:form>
			</div>
			<div class="border border-dark p-3 col-5 bg-dark">
				<h2 class="text-success">Login</h2>
				<form:form action="/login" method="post" modelAttribute="newLogin">
					<div class="mb-3 form-group" >
						<form:label path="email" for="email1">Email:</form:label>
						<form:input path="email" class="form-control mb-3"  id="email1"/>
						<form:errors path="email" class="text-danger mb-3 d-inline-block" />
					</div>
					<div class="mb-3 form-group">
						<form:label path="password" for="password1">Password:</form:label>
						<form:input path="password" class="form-control mb-3" id="password1" />
						<form:errors path="password" class="text-danger mb-3 d-inline-block" />
					</div>
					<button class="btn btn-success" type="submit">Login</button>
				</form:form>
			</div>
		</div>
	</div>
	


	<!-- jQuery (No necesario en Bootstrap 5) -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<!--Bootstrap -->
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<!-- Javascript Local -->
	<script src="/js/app.js"></script>
</body>
</html>