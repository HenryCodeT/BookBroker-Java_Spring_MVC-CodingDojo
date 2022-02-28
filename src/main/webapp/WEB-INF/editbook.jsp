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
	<!-- //// HEADER /////////////////////////////////////////// -->
	<header>
		<div class="navbar navbar-dark bg-dark box-shadow">
			<div class="container d-flex justify-content-between">
				<a href="/" class="col-8 navbar-brand"> <strong
					class="text-warning">Welcome: ${ loggedInUser.userName }</strong>
				</a>
				<div class="col-2 row align-items-center">
					<a class="col btn btn-warning btn-sm round m-2" href="/home">Home</a>
					<a class="col btn btn-danger btn-sm round" href="/logout">LogOut</a>
				</div>
			</div>
		</div>
	</header>

	<!-- //// MAIN AREA //////////////////////////////////////// -->
	<main role="main">
		<div class="container col-6 mt-4">
			<h2>add book to your shelf!</h2>
			<form:form action="/books/${ book.getId() }" method="post" modelAttribute="book">
				<input type="hidden" name="_method" value="put">
				<div class="form-group">
					<form:label path="title">Title:</form:label>
					<form:input path="title" class="form-control mb-3"  />
					<form:errors path="title" class="text-danger mb-3 d-inline-block" />
				</div>
				<div class="form-group">
					<form:label path="author">Author:</form:label>
					<form:input path="author" class="form-control mb-3"  />
					<form:errors path="author" class="text-danger mb-3 d-inline-block" />
				</div>
				<div class="form-group">
					<form:label path="thought">Description:</form:label>
					<form:textarea path="thought" class="form-control mb-3" rows="3"></form:textarea>
					<form:errors path="thought" class="text-danger mb-3 d-inline-block" />
				</div>
				<input class="btn btn-success" type="submit" value="Submit New Book" />
			</form:form>
		</div>
	</main>


	<!-- jQuery (No necesario en Bootstrap 5) -->
	<script src="/webjars/jquery/jquery.min.js"></script>
	<!--Bootstrap -->
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
	<!-- Javascript Local -->
	<script src="/js/app.js"></script>
</body>
</html>