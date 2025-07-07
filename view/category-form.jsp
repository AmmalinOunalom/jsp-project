<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Category Form</title></head>
<body>
<h2><c:choose>
    <c:when test="${not empty category}">Edit Category</c:when>
    <c:otherwise>Add New Category</c:otherwise>
</c:choose></h2>

<form action="categories" method="post">
    <input type="hidden" name="id" value="${category.id}" />
    Name: <input type="text" name="name" value="${category.name}" required /><br/>
    <input type="submit" value="Save" />
</form>
<a href="categories?action=list">Back to List</a>
</body>
</html>
