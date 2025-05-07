package com.bookstore.controller;

import com.bookstore.model.BorrowingRecord;
import com.bookstore.service.BorrowingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/borrowing")
public class BorrowingController {

    @Autowired
    private BorrowingService borrowingService;

    @PostMapping("/borrow")
    public String borrowBook(@RequestParam Long bookId, 
                           @RequestParam Long borrowerId,
                           RedirectAttributes redirectAttributes) {
        try {
            BorrowingRecord record = borrowingService.borrowBook(bookId, borrowerId);
            redirectAttributes.addFlashAttribute("success", "Book borrowed successfully!");
            return "redirect:/borrowing/history/" + record.getBookCopy().getBook().getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/books";
        }
    }

    @PostMapping("/return/{recordId}")
    public String returnBook(@PathVariable Long recordId,
                           RedirectAttributes redirectAttributes) {
        try {
            BorrowingRecord record = borrowingService.returnBook(recordId);
            redirectAttributes.addFlashAttribute("success", "Book returned successfully!");
            return "redirect:/borrowing/history/" + record.getBookCopy().getBook().getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/books";
        }
    }

    @GetMapping("/history/{bookId}")
    public String getBorrowingHistory(@PathVariable Long bookId, Model model) {
        try {
            model.addAttribute("borrowingHistory", borrowingService.getBorrowingHistory(bookId));
            model.addAttribute("currentBorrowings", borrowingService.getCurrentBorrowings(bookId));
            return "borrowing/history";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/books";
        }
    }
} 