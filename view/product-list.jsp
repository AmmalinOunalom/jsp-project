<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product List</title>
</head>
<body>
<h2>Product List</h2>
<a href="products?action=new">Add New Product</a>
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th><th>Name</th><th>Price</th><th>Stock</th><th>Image</th><th>Actions</th>
    </tr>
    <c:forEach var="product" items="${listProduct}">
        <tr>
            <td>${product.id}</td>
            <td>${product.name}</td>
            <td>${product.price}</td>
            <td>${product.stock}</td>
            <td>
                <c:if test="${not empty product.imageUrl}">
                    <img src="${product.imageUrl}" alt="Product Image" width="80" height="80"/>
                </c:if>
            </td>
            <td>
                <a href="products?action=edit&id=${product.id}">Edit</a> |
                <a href="products?action=delete&id=${product.id}"
                   onclick="return confirm('Are you sure to delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
