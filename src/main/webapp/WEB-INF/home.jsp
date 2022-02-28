<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Book lender dashboard</title>
<!-- Bootstrap -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<!-- Estilos Locales -->
<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<!-- //// HEADER /////////////////////////////////////////// -->
	<header>
		<div class="navbar navbar-dark bg-dark box-shadow">
			<div class="container d-flex justify-content-between">
				<a href="/" class="col-8 navbar-brand"> <strong
					class="text-warning">Hello, ${ loggedInUser.getUserName() }
						welcome to ... </strong>
				</a>
				<div class="col-2 row align-items-center">
					<a class="col btn btn-warning btn-sm round m-2 text-light" style="background-color: Navy" href="/home">Home</a>
					<a class="col btn btn-danger btn-sm round" style="background-color: Maroon"  href="/logout">LogOut</a>
				</div>
			</div>
		</div>
	</header>

	<!-- //// MAIN AREA //////////////////////////////////////// -->
	<main role="main">
		<div class="container mt-4 col-10 mx-auto">
			<div class="row">
				<h2 class="col">Books from everyone's shelves:</h2>
				<a class="col-2 btn btn-primary btn-sm round m-2" href="/books/new">Add a to my shelf</a>
			</div>
			<div class="row">
				<h1>The Book Broker</h1>
				<h3>Avaiable books to borrow</h3>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th scope="col"><strong>ID</strong></th>
						<th scope="col"><strong>Title</strong></th>
						<th scope="col"><strong>Author Name</strong></th>
						<th scope="col"><strong>Owner</strong></th>
						<th scope="col"><strong>Actions</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="book" items="${ books }">
						<c:choose>
							<c:when test="${ book.getBorrower() == null }">
								<tr>
									<td>${ book.getId() }</td>
									<td><a class="text-primary text-decoration-none"
										href="/books/${ book.getId() }">${ book.getTitle() }</a></td>
									<td>${ book.getAuthor() }</td>
									<td>${ book.getOwner().getUserName() }</td>
									<td class="row">
										<c:choose>
											<c:when
												test="${loggedInUser.getId() == book.getOwner().getId()}">
												<div class="col">
													<a class="btn btn-primary btn-sm round"
														href="/books/${ book.getId() }/edit">Edit</a>
												</div>
												<form class="col" action="/books/${ book.getId() }/delete"
													method="post">
													<input type="hidden" name="_method" value="delete">
													<button  type="submit" class="btn btn-danger btn-sm round">Delete</button>
												</form>
											</c:when>
										</c:choose> <c:choose>
											<c:when test="${ book.borrower == null }">
												<div class="col">
													<a class="btn btn-success btn-sm round"
														href="/books/${ book.getId() }/borrow">Borrow</a>
												</div>
											</c:when>
										</c:choose>
									</td>
								</tr>
							</c:when>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
			<hr />

			<p>Books ${ loggedInUser.userName } is borrowing:</p>
			<!-- //// TABLE TO DISPLAY BORROWED BOOKS //////// -->
			<table class="table">
				<thead>
					<tr>
						<th scope="col"><strong>ID</strong></th>
						<th scope="col"><strong>Title</strong></th>
						<th scope="col"><strong>Author Name</strong></th>
						<th scope="col"><strong>Owner</strong></th>
						<th scope="col"><strong>Actions</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="book" items="${ borrowedBooks }">
						<tr>
							<td>${ book.getId() }</td>
							<td><a class="text-dark text-decoration-none"
								href="/books/${ book.getId() }">${ book.getTitle() }</a></td>
							<td>${ book.getAuthor() }</td>
							<td>${ book.getOwner().getUserName() }</td>
							<td class="row">
								<!-- **** Button that points to Book View ************ -->
								<div class="col">
									<a class="btn btn-primary btn-sm round"
										href="/books/${ book.getId() }">View</a>
								</div> <c:choose>
									<c:when test="${loggedInUser.getId() == book.getOwner().getId()}">
										<div class="col">
											<a class="btn btn-primary btn-sm round"
												href="/books/${ book.id }/edit">Edit</a>
										</div>
										<!-- **** Button that deletes Book ************ -->
										<form class="col" action="/books/${ book.getId() }/delete"
											method="post">
											<input type="hidden" name="_method" value="delete">
											<!-- ### Converts method of form to DELETE ### -->
											<button class="btn btn-danger btn-sm round">Delete</button>
										</form>
									</c:when>
								</c:choose> <c:choose>
									<c:when test="${ book.getBorrower() != null }">
										<!-- **** Button that Returns a borrowed book **** -->
										<div class="col">
											<a class="btn btn-warning btn-sm round"
												href="/books/${ book.getId() }/return">Return
												Book</a>
										</div>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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