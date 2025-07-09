<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Welcome to E-Commerce</title></head>
<body>
<h1>Welcome to Our E-Commerce Website!</h1>

<c:choose>
    <c:when test="${not empty sessionScope.user}">
        
        <p>Welcome, ${sessionScope.user.username}(Role ID: ${sessionScope.roleId})
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </p>

        <p><a href="products?action=list">View Products</a></p>

        <c:if test="${sessionScope.roleId == 1}">
            <p><a href="categories?action=list">Manage Categories</a></p>
            <p><a href="categories?action=new">Add New Category</a></p>
        </c:if>

        <h2>Categories:</h2>
        <ul>
            <c:forEach var="category" items="${categories}">
                <li>
                    ${category.name}
                    <c:if test="${sessionScope.roleId == 1}">
                        | <a href="categories?action=edit&id=${category.id}">Edit</a>
                        | <a href="categories?action=delete&id=${category.id}"
                             onclick="return confirm('Are you sure?')">Delete</a>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
    </c:when>
    <c:otherwise>
        <p><a href="login">Login</a> | <a href="register">Register</a></p>
    </c:otherwise>
</c:choose>

</body>
</html>
