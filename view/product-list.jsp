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
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="product" items="${listProduct}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.price}</td>
                        <td>${product.stock}</td>
                        <td>
                            <c:if test="${not empty product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                                    alt="Product Image" width="100" height="100" />
                            </c:if>
                        </td>
                        <td>
                            <!-- Admin actions -->
                            <a href="products?action=edit&id=${product.id}">Edit</a> |
                            <a href="products?action=delete&id=${product.id}"
                                onclick="return confirm('Are you sure to delete?')">Delete</a>
                            <br />

                            <!-- Add to Cart form -->
                            <form action="add-to-cart" method="post">
                                <input type="hidden" name="productId" value="${product.id}" />
                                <input type="hidden" name="name" value="${product.name}" />
                                <input type="hidden" name="price" value="${product.price}" />
                                Quantity: <input type="number" name="quantity" value="1" min="1" style="width:50px;" />
                                <input type="submit" value="Add to Cart" />
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <a href="index.jsp">Back to Home Page</a> | <a href="cart.jsp"> View Cart</a>
        </body>

        </html>