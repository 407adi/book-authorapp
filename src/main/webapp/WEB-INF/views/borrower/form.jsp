<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        <c:if test="${borrower.id == null}">
                            <i class="fas fa-user-plus me-2"></i>Add New Borrower
                        </c:if>
                        <c:if test="${borrower.id != null}">
                            <i class="fas fa-user-edit me-2"></i>Edit Borrower
                        </c:if>
                    </h4>
                </div>
                <div class="card-body">
                    <form:form action="${pageContext.request.contextPath}/borrowers/save" method="post" modelAttribute="borrower">
                        <form:hidden path="id" />
                        
                        <div class="mb-3">
                            <form:label path="name" class="form-label">Name</form:label>
                            <form:input path="name" class="form-control" required="true" />
                            <form:errors path="name" class="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="email" class="form-label">Email</form:label>
                            <form:input path="email" type="email" class="form-control" required="true" />
                            <form:errors path="email" class="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="phone" class="form-label">Phone</form:label>
                            <form:input path="phone" class="form-control" />
                            <form:errors path="phone" class="text-danger" />
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="address" class="form-label">Address</form:label>
                            <form:textarea path="address" class="form-control" rows="3" />
                            <form:errors path="address" class="text-danger" />
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/borrowers" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Back to List
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Borrower
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> 