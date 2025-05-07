package com.bookstore.controller;

import com.bookstore.model.Author;
import com.bookstore.model.Book;

import com.bookstore.service.AuthorService;
import com.bookstore.service.BookService;
import com.bookstore.service.BorrowerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.List;

@Controller
@RequestMapping("/books")
public class BookController {

    private static final Logger logger = LoggerFactory.getLogger(BookController.class);
    private final BookService bookService;
    private final AuthorService authorService;
    private final BorrowerService borrowerService;

   
    public BookController(BookService bookService, AuthorService authorService, BorrowerService borrowerService) {
        this.bookService = bookService;
        this.authorService = authorService;
        this.borrowerService = borrowerService;
    }

    @GetMapping
    public String listBooks(Model model, @RequestParam(required = false) String keyword) {
        logger.debug("Searching books with keyword: {}", keyword);
        List<Book> books;
        if (keyword != null && !keyword.trim().isEmpty()) {
            books = bookService.search(keyword.trim());
            logger.debug("Found {} books matching keyword: {}", books.size(), keyword);
            model.addAttribute("keyword", keyword.trim());
        } else {
            books = bookService.getAllBooks();
            logger.debug("Retrieved all books, count: {}", books.size());
        }
        model.addAttribute("books", books);
        model.addAttribute("borrowers", borrowerService.getAllBorrowers());
        return "book/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("allAuthors", authorService.getAllAuthors());
        return "book/form";
    }

    @PostMapping("/save")
    public String saveBook(@ModelAttribute("book") Book book, 
                          @RequestParam(required = false) String newAuthorName,
                          @RequestParam(required = false) String newAuthorNationality,
                          @RequestParam(required = false) String newAuthorBirthDate,
                          BindingResult result, 
                          Model model,
                          RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("allAuthors", authorService.getAllAuthors());
            return "book/form";
        }

        // Handle new author creation
        if (newAuthorName != null && !newAuthorName.trim().isEmpty()) {
            Author newAuthor = new Author();
            newAuthor.setName(newAuthorName.trim());
            newAuthor.setNationality(newAuthorNationality != null ? newAuthorNationality.trim() : null);
            if (newAuthorBirthDate != null && !newAuthorBirthDate.trim().isEmpty()) {
                newAuthor.setBirthDate(java.time.LocalDate.parse(newAuthorBirthDate));
            }
            Author savedAuthor = authorService.saveAuthor(newAuthor);
            book.setAuthor(savedAuthor);
        }

        try {
            bookService.saveBook(book);
            redirectAttributes.addFlashAttribute("success", "Book saved successfully!");
            return "redirect:/books";
        } catch (Exception e) {
            model.addAttribute("allAuthors", authorService.getAllAuthors());
            model.addAttribute("error", e.getMessage());
            return "book/form";
        }
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Book book = bookService.getBookById(id);
        if (book == null) {
            return "redirect:/books";
        }
        model.addAttribute("book", book);
        model.addAttribute("allAuthors", authorService.getAllAuthors());
        return "book/form";
    }

    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            bookService.deleteBook(id);
            redirectAttributes.addFlashAttribute("success", "Book deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/books";
    }
}
