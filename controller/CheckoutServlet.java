package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import model.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Convert CartItem to OrderItem
        List<OrderItem> orderItems = new ArrayList<>();
        double total = 0.0;

        for (CartItem cartItem : cart) {
            OrderItem item = new OrderItem();
            item.setProductId(cartItem.getProductId());
            item.setQuantity(cartItem.getQuantity());
            item.setPrice(cartItem.getPrice());
            orderItems.add(item);

            total += cartItem.getPrice() * cartItem.getQuantity();
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotal(total);
        order.setItems(orderItems);

        ProductDAO productDAO = new ProductDAO();

        try {
            // Use the combined method that creates order and decreases stock atomically
            int orderId = orderDAO.createOrderWithItemsAndDecreaseStock(order, productDAO);

            session.setAttribute("currentOrderId", orderId);
            session.setAttribute("cart", null); // Clear cart after checkout

            resp.sendRedirect("payment.jsp");

        } catch (Exception e) {
            throw new ServletException("Checkout failed: " + e.getMessage(), e);
        }
    }
}
