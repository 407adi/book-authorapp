<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        <i class="fas fa-book me-2"></i>
                        <c:choose>
                            <c:when test="${book.id == null}">Add New Book</c:when>
                            <c:otherwise>Edit Book</c:otherwise>
                        </c:choose>
                    </h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <form:form action="${pageContext.request.contextPath}/books/save" method="post" modelAttribute="book">
                        <form:hidden path="id" />
                        
                        <div class="mb-3">
                            <form:label path="title" class="form-label">
                                <i class="fas fa-heading me-1"></i>Title
                            </form:label>
                            <form:input path="title" class="form-control" required="true" />
                            <form:errors path="title" cssClass="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="author.id" class="form-label">
                                <i class="fas fa-user me-1"></i>Author
                            </form:label>
                            <div class="input-group">
                                <form:select path="author.id" class="form-select" id="authorSelect">
                                    <option value="">-- Select Author --</option>
                                    <form:options items="${allAuthors}" itemValue="id" itemLabel="name" />
                                </form:select>
                                <button class="btn btn-outline-secondary" type="button" id="toggleAuthorInput">
                                    <i class="fas fa-plus"></i> New Author
                                </button>
                            </div>
                            <div id="newAuthorInput" class="mt-2" style="display: none;">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="newAuthorName" 
                                           placeholder="Enter author name" name="newAuthorName">
                                    <input type="text" class="form-control" id="newAuthorNationality" 
                                           placeholder="Nationality" name="newAuthorNationality">
                                    <input type="date" class="form-control" id="newAuthorBirthDate" 
                                           name="newAuthorBirthDate">
                                </div>
                            </div>
                            <form:errors path="author.id" cssClass="text-danger" />
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <form:label path="genre" class="form-label">
                                    <i class="fas fa-tag me-1"></i>Genre
                                </form:label>
                                <form:input path="genre" class="form-control" />
                                <form:errors path="genre" cssClass="text-danger" />
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <form:label path="isbn" class="form-label">
                                    <i class="fas fa-barcode me-1"></i>ISBN
                                </form:label>
                                <form:input path="isbn" class="form-control" required="true" />
                                <form:errors path="isbn" cssClass="text-danger" />
                                <c:if test="${not empty isbnError}">
                                    <div class="text-danger">${isbnError}</div>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="publishedYear" class="form-label">
                                <i class="fas fa-calendar me-1"></i>Published Year
                            </form:label>
                            <form:input path="publishedYear" type="number" class="form-control" min="1000" max="2099" />
                            <form:errors path="publishedYear" cssClass="text-danger" />
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times me-1"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i>Save
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const toggleButton = document.getElementById('toggleAuthorInput');
    const newAuthorInput = document.getElementById('newAuthorInput');
    const authorSelect = document.getElementById('authorSelect');
    const newAuthorName = document.getElementById('newAuthorName');
    const newAuthorNationality = document.getElementById('newAuthorNationality');
    const newAuthorBirthDate = document.getElementById('newAuthorBirthDate');

    toggleButton.addEventListener('click', function() {
        if (newAuthorInput.style.display === 'none') {
            newAuthorInput.style.display = 'block';
            authorSelect.disabled = true;
            toggleButton.innerHTML = '<i class="fas fa-times"></i> Cancel';
        } else {
            newAuthorInput.style.display = 'none';
            authorSelect.disabled = false;
            toggleButton.innerHTML = '<i class="fas fa-plus"></i> New Author';
            newAuthorName.value = '';
            newAuthorNationality.value = '';
            newAuthorBirthDate.value = '';
        }
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
