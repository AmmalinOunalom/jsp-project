package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import model.Order;
import model.OrderItem;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("[DEBUG] OrderServlet.doPost called");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            System.out.println("[DEBUG] User not logged in — redirecting to login.jsp");
            resp.sendRedirect("login.jsp");
            return;
        }

        System.out.println("[DEBUG] User ID: " + user.getId());

        String[] productIds = req.getParameterValues("product_id");
        String[] quantities = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("price");

        if (productIds == null || quantities == null || prices == null
                || productIds.length != quantities.length || productIds.length != prices.length) {
            System.out.println("[DEBUG] Invalid order data received");
            req.setAttribute("error", "Invalid order data.");
            req.getRequestDispatcher("error.jsp").forward(req, resp);
            return;
        }

        System.out.println("[DEBUG] Order Items Count: " + productIds.length);

        List<OrderItem> items = new ArrayList<>();

        try {
            // Validate stock for each product BEFORE creating the order
            for (int i = 0; i < productIds.length; i++) {
                int productId = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                double price = Double.parseDouble(prices[i]);

                System.out.println("[DEBUG] Checking stock for product ID: " + productId + ", quantity: " + quantity);

                Product product = productDAO.getProductById(productId);
                if (product == null) {
                    System.out.println("[DEBUG] Product not found: " + productId);
                    req.setAttribute("error", "Product not found: " + productId);
                    req.getRequestDispatcher("error.jsp").forward(req, resp);
                    return;
                }

                if (quantity > product.getStock()) {
                    System.out.println("[DEBUG] Insufficient stock for product ID: " + productId + ", stock: "
                            + product.getStock());
                    req.setAttribute("error", "Insufficient stock for product ID: " + productId);
                    req.getRequestDispatcher("error.jsp").forward(req, resp);
                    return;
                }

                System.out.println("[DEBUG] Stock OK for product ID: " + productId);

                OrderItem item = new OrderItem();
                item.setProductId(productId);
                item.setQuantity(quantity);
                item.setPrice(price);
                items.add(item);
            }

            // Prepare the order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setItems(items);

            // Use the DAO method that handles everything transactionally
            int orderId = orderDAO.createOrderWithItemsAndDecreaseStock(order, productDAO);
            System.out.println("[DEBUG] Order created successfully with ID: " + orderId);

            resp.sendRedirect("order-success.jsp");

        } catch (NumberFormatException e) {
            System.out.println("[DEBUG] Invalid number format: " + e.getMessage());
            req.setAttribute("error", "Invalid number format: " + e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        } catch (SQLException e) {
            System.out.println("[DEBUG] Order failed: " + e.getMessage());
            req.setAttribute("error", "Order failed: " + e.getMessage());
            req.getRequestDispatcher("error.jsp").forward(req, resp);
        }
    }
}
