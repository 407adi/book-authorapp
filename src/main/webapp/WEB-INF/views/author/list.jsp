<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Authors</h2>
    <a href="${pageContext.request.contextPath}/authors/add" class="btn btn-primary">Add New Author</a>
</div>

<c:if test="${not empty param.keyword}">
    <div class="alert alert-info">
        Search results for: <strong>${param.keyword}</strong>
    </div>
</c:if>

<c:if test="${empty authors}">
    <div class="alert alert-info">No authors found.</div>
</c:if>

<c:if test="${not empty authors}">
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Nationality</th>
                    <th>Birth Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${authors}" var="author">
                    <tr>
                        <td>${author.id}</td>
                        <td>${author.name}</td>
                        <td>${author.nationality}</td>
                        <td>${author.birthDate}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/authors/edit/${author.id}" class="btn btn-sm btn-warning">Edit</a>
                            <a href="${pageContext.request.contextPath}/authors/delete/${author.id}" 
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('Are you sure you want to delete this author?')">
                                Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
