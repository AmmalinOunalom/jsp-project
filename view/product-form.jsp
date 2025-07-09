<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>
                <c:choose>
                    <c:when test="${not empty product}">Edit Product</c:when>
                    <c:otherwise>Add New Product</c:otherwise>
                </c:choose>
            </title>
        </head>

        <body>
            <h2>
                <c:choose>
                    <c:when test="${not empty product}">Edit Product</c:when>
                    <c:otherwise>Add New Product</c:otherwise>
                </c:choose>
            </h2>
            <form action="products" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${product.id}" />

                Category:
                <select name="categoryId" required>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.id}" <c:if test="${cat.id == product.categoryId}">selected</c:if>>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>
                <br />

                Name: <input type="text" name="name" value="${product.name}" required /><br />
                Description: <textarea name="description">${product.description}</textarea><br />
                Price: <input type="number" step="0.01" name="price" value="${product.price}" required /><br />
                Stock: <input type="number" name="stock" value="${product.stock}" required /><br />
                <label>Product Image: <input type="file" name="imageFile"/></label>

                <!-- Image preview -->
                <c:if test="${not empty product.imageUrl}">
                    <p>Image Preview:</p>
                    <img src="${pageContext.request.contextPath}/${product.imageUrl}" width="100" />

                </c:if>

                <input type="submit" value="Save" />
            </form>
            <a href="products?action=list">Back to List</a>
        </body>

        </html>