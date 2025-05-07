<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>
            <i class="fas fa-history me-2"></i>Borrowing History
        </h2>
        <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Back to Books
        </a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row">
        <div class="col-md-6">
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-book-reader me-2"></i>Current Borrowings
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty currentBorrowings}">
                        <div class="text-center py-4">
                            <i class="fas fa-book fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No current borrowings</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty currentBorrowings}">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Book Title</th>
                                        <th>Borrower</th>
                                        <th>Borrow Date</th>
                                        <th>Due Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${currentBorrowings}" var="record">
                                        <tr>
                                            <td>${record.bookCopy.book.title}</td>
                                            <td>${record.borrower.name}</td>
                                            <td>${record.borrowDate}</td>
                                            <td>${record.dueDate}</td>
                                            <td>
                                                <form action="${pageContext.request.contextPath}/borrowing/return/${record.id}" method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-success btn-sm">Return</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow-sm">
                <div class="card-header bg-info text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-history me-2"></i>Borrowing History
                    </h5>
                </div>
                <div class="card-body">
                    <c:if test="${empty borrowingHistory}">
                        <div class="text-center py-4">
                            <i class="fas fa-history fa-3x text-muted mb-3"></i>
                            <p class="text-muted">No borrowing history</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty borrowingHistory}">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Book Title</th>
                                        <th>Borrower</th>
                                        <th>Borrow Date</th>
                                        <th>Return Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${borrowingHistory}" var="record">
                                        <tr>
                                            <td>${record.bookCopy.book.title}</td>
                                            <td>${record.borrower.name}</td>
                                            <td>${record.borrowDate}</td>
                                            <td>${record.returnDate}</td>
                                            <td>
                                                <span class="badge ${record.status == 'RETURNED' ? 'bg-success' : 'bg-warning'}">
                                                    ${record.status}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> 