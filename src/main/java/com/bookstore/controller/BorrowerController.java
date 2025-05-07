package com.bookstore.controller;

import com.bookstore.model.Borrower;
import com.bookstore.service.BorrowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/borrowers")
public class BorrowerController {

    @Autowired
    private BorrowerService borrowerService;

    @GetMapping
    public String listBorrowers(Model model) {
        model.addAttribute("borrowers", borrowerService.getAllBorrowers());
        return "borrower/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("borrower", new Borrower());
        return "borrower/form";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Borrower borrower = borrowerService.getBorrowerById(id);
        model.addAttribute("borrower", borrower);
        return "borrower/form";
    }

    @PostMapping("/save")
    public String saveBorrower(@ModelAttribute Borrower borrower, RedirectAttributes redirectAttributes) {
        try {
            borrowerService.saveBorrower(borrower);
            redirectAttributes.addFlashAttribute("success", "Borrower saved successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/borrowers";
    }

    @GetMapping("/delete/{id}")
    public String deleteBorrower(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            borrowerService.deleteBorrower(id);
            redirectAttributes.addFlashAttribute("success", "Borrower deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/borrowers";
    }
} 