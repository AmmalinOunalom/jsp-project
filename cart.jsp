<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>

<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
%>
    <p>Your cart is empty.</p>
    <!-- Back to Product List button -->
    <a href="<%= request.getContextPath() %>/products?action=list">
        <button type="button">Back to Product List</button>
    </a>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th>Actions</th>
        </tr>
        <%
            double total = 0.0;
            for (CartItem item : cart) {
                double subtotal = item.getPrice() * item.getQuantity();
                total += subtotal;
        %>
        <tr>
            <td><%= item.getName() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= subtotal %></td>
            <td>
                <!-- Decrease quantity -->
                <a href="cart?action=decrease&productId=<%= item.getProductId() %>">-1</a>
                <!-- Increase quantity -->
                <a href="cart?action=increase&productId=<%= item.getProductId() %>">+1</a>
                <!-- Remove item -->
                <a href="cart?action=remove&productId=<%= item.getProductId() %>">Remove</a>
            </td>
        </tr>
        <% } %>
        <tr>
            <td colspan="3" align="right"><b>Total:</b></td>
            <td colspan="2"><b><%= total %></b></td>
        </tr>
    </table>

    <!-- Pay button submits to CheckoutServlet -->
    <form action="CheckoutServlet" method="post">
        <input type="submit" value="Proceed to Pay" />
    </form>

    <!-- Back to Product List button -->
    <a href="<%= request.getContextPath() %>/products?action=list">
        <button type="button">Back to Product List</button>
    </a>
<%
    }
%>
