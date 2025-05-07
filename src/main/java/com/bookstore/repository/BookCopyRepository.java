package com.bookstore.repository;

import com.bookstore.model.BookCopy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookCopyRepository extends JpaRepository<BookCopy, Long> {
    Optional<BookCopy> findFirstByBookIdAndStatus(Long bookId, String status);
    int countByBookIdAndStatus(Long bookId, String status);
} 