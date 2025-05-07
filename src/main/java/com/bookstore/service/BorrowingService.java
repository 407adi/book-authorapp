package com.bookstore.service;

import com.bookstore.model.*;
import com.bookstore.repository.BorrowingRecordRepository;
import com.bookstore.repository.BookCopyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class BorrowingService {

    @Autowired
    private BorrowingRecordRepository borrowingRecordRepository;

    @Autowired
    private BookCopyRepository bookCopyRepository;

    @Transactional
    public BorrowingRecord borrowBook(Long bookCopyId, Long borrowerId) {
        BookCopy bookCopy = bookCopyRepository.findById(bookCopyId)
                .orElseThrow(() -> new RuntimeException("Book copy not found"));

        if (bookCopy.getStatus() != BookCopyStatus.AVAILABLE) {
            throw new RuntimeException("Book copy is not available for borrowing");
        }

        // Create borrowing record
        BorrowingRecord record = new BorrowingRecord();
        record.setBookCopy(bookCopy);
        record.setBorrower(new Borrower(borrowerId));
        record.setBorrowDate(LocalDate.now());
        record.setDueDate(LocalDate.now().plusDays(14));
        record.setStatus(BorrowingStatus.BORROWED);

        // Update book copy status
        bookCopy.setStatus(BookCopyStatus.BORROWED);
        bookCopyRepository.save(bookCopy);

        return borrowingRecordRepository.save(record);
    }

    @Transactional
    public BorrowingRecord returnBook(Long recordId) {
        BorrowingRecord record = borrowingRecordRepository.findById(recordId)
                .orElseThrow(() -> new RuntimeException("Borrowing record not found"));

        if (record.getStatus() == BorrowingStatus.RETURNED) {
            throw new RuntimeException("Book has already been returned");
        }

        // Update borrowing record
        record.setReturnDate(LocalDate.now());
        record.setStatus(BorrowingStatus.RETURNED);

        // Update book copy status
        BookCopy bookCopy = record.getBookCopy();
        bookCopy.setStatus(BookCopyStatus.AVAILABLE);
        bookCopyRepository.save(bookCopy);

        return borrowingRecordRepository.save(record);
    }

    public List<BorrowingRecord> getCurrentBorrowings(Long bookId) {
        return borrowingRecordRepository.findCurrentBorrowingsByBookId(bookId);
    }

    public List<BorrowingRecord> getBorrowingHistory(Long bookId) {
        return borrowingRecordRepository.findBorrowingHistoryByBookId(bookId);
    }
} 