<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Category List</title></head>
<body>
<h2>Category List</h2>
<a href="categories?action=new">Add New Category</a>
<table border="1" cellpadding="5" cellspacing="0">
    <tr><th>ID</th><th>Name</th><th>Actions</th></tr>
    <c:forEach var="category" items="${categories}">
        <tr>
            <td>${category.id}</td>
            <td>${category.name}</td>
            <td>
                <a href="categories?action=edit&id=${category.id}">Edit</a> |
                <a href="categories?action=delete&id=${category.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="index.jsp">Back to Home</a>
</body>
</html>
