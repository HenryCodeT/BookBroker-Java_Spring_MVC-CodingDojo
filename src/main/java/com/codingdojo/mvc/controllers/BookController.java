package com.codingdojo.mvc.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.codingdojo.mvc.models.Book;
import com.codingdojo.mvc.models.User;
import com.codingdojo.mvc.services.BookService;
import com.codingdojo.mvc.services.UserService;

@Controller
public class BookController {
	@Autowired
	UserService userService;
	@Autowired
	BookService bookService;

	// //// BOOK NEW /////////////
	// ---- view --------------------
	@GetMapping("/books/new")
	public String newBookView(@ModelAttribute("book") Book book, Model model, HttpSession session) {
		System.out.println("********* BOOK NEW VIEW *********");
		// ---- Check if User is Logged In -------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/initial";
		}
		// ---- Get the Log In User -------------------------------
		User loggedInUser = userService.retrieveUser((Long) session.getAttribute("user_id"));
		model.addAttribute("loggedInUser", loggedInUser);
		return "newbook";
	}

	// ---- post --------------
	@PostMapping("/books/new")
	public String createBook(@Valid @ModelAttribute("book") Book book, BindingResult result, HttpSession session,
			Model model) {
		if (result.hasErrors()) {
			System.out.println("------ THE FORM BOOK HAS ERRORS -------");
			// ---- Check if User is Logged In -------------------
			if (session.isNew() || session.getAttribute("user_id") == null) {
				return "redirect:/initial";
			}
			// ---- Get the Log In User -------------------------------
			User loggedInUser = userService.retrieveUser((Long) session.getAttribute("user_id"));
			model.addAttribute("loggedInUser", loggedInUser);
			return "newbook";
		} else {
			System.out.println("-------------- THE FORM NO HAS ERRORS --------------");
			// ---- Get the Log In User -------------------------------
			User loggedInUser = userService.retrieveUser((Long) session.getAttribute("user_id"));
			model.addAttribute("loggedInUser", loggedInUser);
			book.setOwner(loggedInUser);
			bookService.newBook(book);
			System.out.println("------ NEW BOOK CREATED -------");
			return "redirect:/home";
		}
	}

	// //// BOOK SHOW /////////////
	// --------- get book by id --------------
	@GetMapping("/books/{id}")
	public String getViewById(@PathVariable("id") Long id, Model model, HttpSession session) {
		System.out.println("********* BOOK SHOW VIEW *********");
		// ---- Get the Log In User -------------------------------
		User loggedInUser = userService.retrieveUser((Long) session.getAttribute("user_id"));
		model.addAttribute("loggedInUser", loggedInUser);
		// ---- Get Book By ID -------------------------------
		Book book = bookService.getBookById(id);
		model.addAttribute("book", book);
		return "showbook";
	}

	// //// EDIT BOOK /////////////
	// ---- view -------------------
	@GetMapping("/books/{id}/edit")
	public String editView(@PathVariable("id") Long id, Model model) {
		System.out.println("************** EDIT VIEW ***************");
		Book book = bookService.getBookById(id);
		model.addAttribute("book", book);
		return "editbook";
	}

	// ------ put --------------------
	@PutMapping("/books/{id}")
	public String update(@PathVariable("id") Long id, @Valid @ModelAttribute("book") Book book, BindingResult result, HttpSession session) {
		System.out.println("************* PUT BOOK ************");
		// ---- Check if User is Logged In -------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/initial";
		}
		System.out.println("controller-id-update: " + id);
		System.out.println("controller-update-book: " + book);
		if (result.hasErrors()) {
			return "editbook";
		} else {
			bookService.updateBook(id, book);
			return "redirect:/home";
		}
	}

	// //// DELETE BOOK /////////////
	@DeleteMapping("/books/{id}/delete")
	public String destroy(@PathVariable("id") Long id) {
		bookService.deleteBook(id);
		return "redirect:/home";
	}

	// //// BORROW BOOK /////////////
	@GetMapping("/books/{id}/borrow")
	public String bookmarketBorrow(@PathVariable("id") Long bookId, HttpSession session) {
		System.out.println("************* BORROW BOOK ************");
		// ---- Check if User is Logged In ------------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		// ---- Get the Log In User --------------------------------
		User loggedInUser = this.userService.retrieveUser((Long) session.getAttribute("user_id"));
		Book book = bookService.getBookById(bookId);
		book.setBorrower(loggedInUser);
		bookService.updateBook(bookId, book);
		System.out.println("--------------- BORROW BOOK ------------------");
		return "redirect:/home";
	}
	// //// RETURN BOOK /////////////

	@GetMapping("books/{id}/return")
	public String bookmarketIdReturn(@PathVariable("id") Long bookId, HttpSession session) {
		// ---- Check if User is Logged In ------------------------
		if (session.isNew() || session.getAttribute("user_id") == null) {
			return "redirect:/";
		}
		// ---- Get the book specified by book id ------------------
		Book book = bookService.getBookById(bookId);
		book.setBorrower(null);
		this.bookService.updateBook(bookId, book);
		return "redirect:/home";
	}
}
