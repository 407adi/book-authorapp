package com.bookstore.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "books")
public class Book {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Title is required")
    @Size(max = 150, message = "Title must be less than 150 characters")
    private String title;
    
    @Size(max = 50, message = "Genre must be less than 50 characters")
    private String genre;
    
    @NotBlank(message = "ISBN is required")
    @Pattern(regexp = "^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ])?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$", 
             message = "Invalid ISBN format. Please enter a valid ISBN-10 or ISBN-13.")
    @Column(unique = true)
    private String isbn;
    
    @Column(name = "published_year")
    private Integer publishedYear;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id", nullable = false)
    @NotNull(message = "Author is required")
    private Author author;
    
    @OneToMany(mappedBy = "book")
    private List<BookCopy> copies;
    
    // Constructors
    public Book() {
    }
    
    public Book(String title, String genre, String isbn, Integer publishedYear, Author author) {
        this.title = title;
        this.genre = genre;
        this.isbn = isbn;
        this.publishedYear = publishedYear;
        this.author = author;
    }
    
    // Getters and Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getGenre() {
        return genre;
    }
    
    public void setGenre(String genre) {
        this.genre = genre;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = cleanIsbn(isbn);
    }
    
    private String cleanIsbn(String isbn) {
        if (isbn == null) {
            return null;
        }
        // Remove all non-alphanumeric characters except X
        return isbn.replaceAll("[^0-9X]", "").toUpperCase();
    }
    
    public Integer getPublishedYear() {
        return publishedYear;
    }
    
    public void setPublishedYear(Integer publishedYear) {
        this.publishedYear = publishedYear;
    }
    
    public Author getAuthor() {
        return author;
    }
    
    public void setAuthor(Author author) {
        this.author = author;
    }
    
    public List<BookCopy> getCopies() {
        return copies;
    }
    
    public void setCopies(List<BookCopy> copies) {
        this.copies = copies;
    }
    
    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", genre='" + genre + '\'' +
                ", isbn='" + isbn + '\'' +
                ", publishedYear=" + publishedYear +
                ", author=" + (author != null ? author.getName() : "null") +
                '}';
    }
}
