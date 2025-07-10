<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Order History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 14px;
            margin: 20px;
            color: #333;
        }

        .order-container {
            border: 1px solid #ccc;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        a.button {
            display: inline-block;
            padding: 8px 16px;
            background-color: #007bff;
            color: white !important;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }

        a.button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <p>
        <a href="${pageContext.request.contextPath}/index.jsp" class="button">Back to Home Page</a>
    </p>

    <h2>Your Order History</h2>

    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-container">
                    <h3>Order #${order.id} - Total: $${order.total}</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Product ID</th>
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>
                                    <td>${item.productId}</td>
                                    <td>${item.productName}</td>
                                    <td>${item.quantity}</td>
                                    <td>$${item.price}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>You have no orders yet.</p>
        </c:otherwise>
    </c:choose>

</body>
</html>
