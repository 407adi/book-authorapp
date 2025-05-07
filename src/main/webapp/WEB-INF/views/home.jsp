<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="jumbotron text-center">
    <h1 class="display-4">Welcome to Bookstore Management</h1>
    <p class="lead">Manage your books and authors with ease</p>
    <hr class="my-4">
    <div class="row mt-5">
        <div class="col-md-6 mb-4">
            <div class="card h-100">
                <div class="card-body text-center">
                    <h5 class="card-title">Books</h5>
                    <p class="card-text">Manage your book collection</p>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">View Books</a>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="card h-100">
                <div class="card-body text-center">
                    <h5 class="card-title">Authors</h5>
                    <p class="card-text">Manage author information</p>
                    <a href="${pageContext.request.contextPath}/authors" class="btn btn-primary">View Authors</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
