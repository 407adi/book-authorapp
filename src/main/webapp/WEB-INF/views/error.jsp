<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="row">
    <div class="col-md-8 offset-md-2">
        <div class="card">
            <div class="card-header bg-danger text-white">
                <h4 class="mb-0">Error</h4>
            </div>
            <div class="card-body">
                <div class="alert alert-danger">
                    <h5>An error occurred while processing your request</h5>
                    <c:if test="${not empty message}">
                        <p><strong>Error Message:</strong> ${message}</p>
                    </c:if>
                    <c:if test="${not empty url}">
                        <p><strong>Request URL:</strong> ${url}</p>
                    </c:if>
                </div>
                
                <c:if test="${not empty exception}">
                    <div class="mt-4">
                        <h5>Technical Details:</h5>
                        <pre class="bg-light p-3">${exception}</pre>
                    </div>
                </c:if>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Home</a>
                    <button onclick="history.back()" class="btn btn-secondary">Go Back</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> 