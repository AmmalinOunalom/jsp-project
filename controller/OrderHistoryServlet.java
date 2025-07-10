package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/order-history")
public class OrderHistoryServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = ((model.User) session.getAttribute("user")).getId();

        try {
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            for (Order order : orders) {
                List<OrderItem> items = orderDAO.getOrderItemsByOrderId(order.getId());
                order.setItems(items);
            }

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("order-history.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Failed to load order history", e);
        }
    }
}
