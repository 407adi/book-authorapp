package com.bookstore.repository;

import com.bookstore.model.BorrowingRecord;
import com.bookstore.model.BorrowingStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BorrowingRecordRepository extends JpaRepository<BorrowingRecord, Long> {
    
    @Query("SELECT br FROM BorrowingRecord br WHERE br.bookCopy.book.id = :bookId AND br.status = :status")
    List<BorrowingRecord> findByBookIdAndStatus(@Param("bookId") Long bookId, @Param("status") BorrowingStatus status);
    
    @Query("SELECT br FROM BorrowingRecord br WHERE br.bookCopy.book.id = :bookId AND br.status = 'BORROWED'")
    List<BorrowingRecord> findCurrentBorrowingsByBookId(@Param("bookId") Long bookId);
    
    @Query("SELECT br FROM BorrowingRecord br WHERE br.bookCopy.book.id = :bookId AND br.status = 'RETURNED' ORDER BY br.returnDate DESC")
    List<BorrowingRecord> findBorrowingHistoryByBookId(@Param("bookId") Long bookId);
} 