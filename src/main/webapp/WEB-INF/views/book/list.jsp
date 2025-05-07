<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">
            <i class="fas fa-books me-2"></i>Books
        </h2>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/borrowers" class="btn btn-info me-2">
                <i class="fas fa-users me-2"></i>Manage Borrowers
            </a>
            <a href="${pageContext.request.contextPath}/books/add" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>Add New Book
            </a>
        </div>
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

    <c:if test="${empty books}">
        <div class="text-center py-5">
            <i class="fas fa-books fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">No books found</h4>
            <c:if test="${not empty keyword}">
                <p class="text-muted">Try a different search term</p>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty books}">
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
            <c:forEach items="${books}" var="book">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title text-truncate" title="${book.title}">${book.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">
                                <i class="fas fa-user me-1"></i>${book.author.name}
                            </h6>
                            <div class="card-text">
                                <p class="mb-1">
                                    <i class="fas fa-tag me-1"></i>${book.genre}
                                </p>
                                <p class="mb-1">
                                    <i class="fas fa-barcode me-1"></i>${book.isbn}
                                </p>
                                <p class="mb-1">
                                    <i class="fas fa-calendar me-1"></i>${book.publishedYear}
                                </p>
                                <p class="card-text">
                                    <small class="text-muted">
                                        Available Copies: ${book.copies.stream().filter(copy -> copy.status == 'AVAILABLE').count()}
                                    </small>
                                </p>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-top-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a href="${pageContext.request.contextPath}/books/edit/${book.id}" 
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/books/delete/${book.id}" 
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Are you sure you want to delete this book?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                                <div class="btn-group">
                                    <c:if test="${book.copies.stream().filter(copy -> copy.status == 'AVAILABLE').count() > 0}">
                                        <button type="button" class="btn btn-sm btn-success" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#borrowModal${book.id}">
                                            <i class="fas fa-book-reader"></i> Borrow
                                        </button>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/borrowing/history/${book.id}" 
                                       class="btn btn-sm btn-info">
                                        <i class="fas fa-history"></i> History
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Borrow Modal -->
                <div class="modal fade" id="borrowModal${book.id}" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Borrow Book</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/borrowing/borrow" method="post">
                                <div class="modal-body">
                                    <input type="hidden" name="bookId" value="${book.id}">
                                    <div class="mb-3">
                                        <label for="borrowerId" class="form-label">Select Borrower</label>
                                        <select class="form-select" id="borrowerId" name="borrowerId" required>
                                            <c:forEach items="${borrowers}" var="borrower">
                                                <option value="${borrower.id}">${borrower.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-success">Borrow Book</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
