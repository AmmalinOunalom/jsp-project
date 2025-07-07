package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class OrderServlet extends HttpServlet {
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

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // In real apps, data should come from cart/session. For now, get from form
        String[] productIds = req.getParameterValues("product_id");
        String[] quantities = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("price");

        List<OrderItem> items = new ArrayList<>();
        for (int i = 0; i < productIds.length; i++) {
            OrderItem item = new OrderItem();
            item.setProductId(Integer.parseInt(productIds[i]));
            item.setQuantity(Integer.parseInt(quantities[i]));
            item.setPrice(Double.parseDouble(prices[i]));
            items.add(item);
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setItems(items);

        try {
            int orderId = orderDAO.createOrder(order);
            orderDAO.insertOrderItems(orderId, items);
            resp.sendRedirect("order-success.jsp");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
