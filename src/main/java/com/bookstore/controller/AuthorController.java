package com.bookstore.controller;

import com.bookstore.model.Author;
import com.bookstore.service.AuthorService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorService authorService;

   
    public AuthorController(AuthorService authorService) {
        this.authorService = authorService;
    }

    @GetMapping
    public String listAuthors(Model model, @RequestParam(required = false) String keyword) {
        List<Author> authors;
        if (keyword != null && !keyword.trim().isEmpty()) {
            authors = authorService.search(keyword.trim());
            model.addAttribute("keyword", keyword.trim());
        } else {
            authors = authorService.getAllAuthors();
        }
        model.addAttribute("authors", authors);
        return "author/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("author", new Author());
        return "author/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Author author = authorService.getAuthorById(id);
        if (author == null) {
            return "redirect:/authors";
        }
        model.addAttribute("author", author);
        return "author/form";
    }

    @PostMapping("/save")
    public String saveAuthor(@ModelAttribute("author") Author author, BindingResult result) {
        if (result.hasErrors()) {
            return "author/form";
        }
        authorService.saveAuthor(author);
        return "redirect:/authors?success=Author+saved+successfully!";
    }

    @GetMapping("/delete/{id}")
    public String deleteAuthor(@PathVariable Long id) {
        authorService.deleteAuthor(id);
        return "redirect:/authors?success=Author+deleted+successfully!";
    }
}
