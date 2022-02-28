package com.codingdojo.mvc.services;

import java.util.List;
import java.util.Optional;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.mvc.models.Book;
import com.codingdojo.mvc.repositories.BookRepository;

@Service
public class BookService {
	@Autowired
	BookRepository bookRepository;
	
	// //// GET ALL BOOKS /////
	public List<Book> allBooks(){
		System.out.println("------------ FIND ALL BOOKS FROM DB -----------");
		return bookRepository.findAll();
	}
	// //// CREATE NEW BOOK //////
	public Book newBook(Book book) {
		System.out.println("-------------- CREATE NEW BOOK DB ---------------");
		return bookRepository.save(book);
	}
	// //// GET BOOK BY ID /////////
	public Book getBookById(Long id) {
		System.out.println("************** GET BOOK BY ID ***************");
		Optional<Book> optional = bookRepository.findById(id);
		if (optional.isPresent()) {
			System.out.println("------------- BOOK IS PRESENT -------------");
			return optional.get();
		} else {
			return null;
		}
	}
	// //// UPDATE BOOK /////////
	public Book updateBook(Long id,Book book) {
		Optional<Book> optional = bookRepository.findById(id);
		if (optional.isPresent()) {
			Book data = optional.get();
			data.setTitle(book.getTitle());
			data.setAuthor(book.getAuthor());
			data.setThought(book.getThought());
			System.out.println("-------------- BOOK UPDATED ------------");
			return bookRepository.save(data);
		} else {
			return null;
		}
	}
	// //// DELETE BOOK ///////////
	public void deleteBook(Long id) {
		Optional<Book> optional = bookRepository.findById(id);
		System.out.println("service-update-optional-service: "+optional.get());
		if (optional.isPresent()) {
			bookRepository.deleteById(id);
			System.out.println("------------------------- BOOK DELETED---------------------------");
		} 
	}
}
