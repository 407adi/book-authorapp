<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookstore Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            padding-top: 20px;
            background-color: #f8f9fa;
        }
        .navbar {
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%) !important;
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff !important;
        }
        .nav-link {
            color: rgba(255,255,255,.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            color: #fff !important;
            transform: translateY(-1px);
        }
        .search-form {
            position: relative;
        }
        .search-form .form-control {
            border-radius: 20px;
            padding-left: 20px;
            padding-right: 40px;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .search-form .btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            border-radius: 20px;
            padding: 0.375rem 1rem;
            background: rgba(255,255,255,.2);
            border: none;
            color: #fff;
        }
        .search-form .btn:hover {
            background: rgba(255,255,255,.3);
        }
        .container {
            max-width: 1200px;
        }
        .card {
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .btn-primary {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        }
    </style>
</head>
<body>
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                    <i class="fas fa-book-open me-2"></i>Bookstore
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/books">
                                <i class="fas fa-books me-1"></i>Books
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/authors">
                                <i class="fas fa-users me-1"></i>Authors
                            </a>
                        </li>
                    </ul>
                    <form class="d-flex search-form" action="${pageContext.request.contextPath}/books" method="get">
                        <input class="form-control me-2" type="search" name="keyword" 
                               placeholder="Search by title, author, or ISBN..." 
                               value="${param.keyword}"
                               aria-label="Search">
                        <button class="btn" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </nav>
