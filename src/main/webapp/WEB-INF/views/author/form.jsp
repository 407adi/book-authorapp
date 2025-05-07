<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="row">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">
                    <c:choose>
                        <c:when test="${author.id == null}">Add New Author</c:when>
                        <c:otherwise>Edit Author</c:otherwise>
                    </c:choose>
                </h4>
            </div>
            <div class="card-body">
                <form:form action="${pageContext.request.contextPath}/authors/save" method="post" modelAttribute="author">
                    <form:hidden path="id" />
                    
                    <div class="mb-3">
                        <form:label path="name" class="form-label">Name</form:label>
                        <form:input path="name" class="form-control" required="true" />
                        <form:errors path="name" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <form:label path="nationality" class="form-label">Nationality</form:label>
                        <form:input path="nationality" class="form-control" />
                        <form:errors path="nationality" cssClass="text-danger" />
                    </div>
                    
                    <div class="mb-3">
                        <form:label path="birthDate" class="form-label">Birth Date</form:label>
                        <form:input path="birthDate" type="date" class="form-control" />
                        <form:errors path="birthDate" cssClass="text-danger" />
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="${pageContext.request.contextPath}/authors" class="btn btn-secondary me-md-2">Cancel</a>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
