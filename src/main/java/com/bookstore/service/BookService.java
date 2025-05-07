package com.bookstore.service;

import com.bookstore.model.Book;
import com.bookstore.repository.BookRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class BookService {

    private final BookRepository bookRepository;

   
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Transactional(readOnly = true)
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Book> search(String keyword) {
        return bookRepository.search(keyword);
    }

    @Transactional
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

    @Transactional(readOnly = true)
    public Book getBookById(Long id) {
        return bookRepository.findById(id).orElse(null);
    }

    @Transactional
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }

    public List<Book> findByAuthorId(Long authorId) {
        return bookRepository.findByAuthorId(authorId);
    }

    public boolean isIsbnUnique(String isbn) {
        return !bookRepository.existsByIsbn(isbn);
    }

    public boolean isIsbnUniqueExceptCurrent(String isbn, Long bookId) {
        return !bookRepository.existsByIsbnAndIdNot(isbn, bookId);
    }
}
