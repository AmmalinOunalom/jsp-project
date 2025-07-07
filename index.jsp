<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to E-Commerce</title>
</head>
<body>
    <h1>Welcome to Our E-Commerce Website!</h1>

    <c:choose>
        <c:when test="${not empty sessionScope.user}">
            <p>Welcome, ${sessionScope.user.username}! 
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </p>

            <!-- View Products -->
            <p><a href="products?action=list">Click here to view products</a></p>

            <!-- Link to Full Category Page -->
            <p><a href="categories?action=list">Click here to manage categories</a></p> 
        </c:when>
        <c:otherwise>
            <p><a href="login">Login</a> | <a href="register">Register</a></p>
        </c:otherwise>
    </c:choose>

    <!-- Quick Category Overview Below -->
    <h2>Categories:</h2>

    <!-- Add New Category Button -->
    <p><a href="categories?action=new">Add New Category</a></p>

    <!-- List all categories -->
    <ul>
        <c:forEach var="category" items="${categories}">
            <li>
                ${category.name}
                <!-- Edit/Delete links -->
                <a href="categories?action=edit&id=${category.id}">Edit</a> |
                <a href="categories?action=delete&id=${category.id}" onclick="return confirm('Are you sure to delete?')">Delete</a>
            </li>
        </c:forEach>
    </ul>
</body>
</html>
