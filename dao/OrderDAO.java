package dao;

import model.Order;
import model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private String jdbcURL = "jdbc:postgresql://localhost:5432/postgres";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "1234";

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Insert order and return generated order ID
    public int createOrder(Connection conn, Order order) throws SQLException {
        String sql = "INSERT INTO orders (user_id, total) VALUES (?, ?) RETURNING id";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getUserId());
            stmt.setDouble(2, order.getTotal());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            } else {
                throw new SQLException("Failed to insert order, no ID obtained.");
            }
        }
    }

    // Insert order items for an order
    public void insertOrderItems(Connection conn, int orderId, List<OrderItem> items) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (OrderItem item : items) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, item.getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getPrice());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    // Create order, insert items, and decrease product stock in one transaction
    public int createOrderWithItemsAndDecreaseStock(Order order, ProductDAO productDAO) throws SQLException {
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);

            try {
                int orderId = createOrder(conn, order);
                insertOrderItems(conn, orderId, order.getItems());

                // Decrease stock for each product ordered
                for (OrderItem item : order.getItems()) {
                    System.out.println("[DEBUG] Decreasing stock for product ID: " + item.getProductId()
                            + ", quantity: " + item.getQuantity());
                    productDAO.updateProductStock(conn, item.getProductId(), item.getQuantity());
                }

                conn.commit();
                return orderId;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id ASC";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotal(rs.getDouble("total"));
                // You can add other fields like order date, status if you have them
                orders.add(order);
            }
        }
        return orders;
    }

    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.price, p.name AS product_name " +
                "FROM order_items oi " +
                "JOIN products p ON oi.product_id = p.id " +
                "WHERE oi.order_id = ?";

        try (Connection conn = getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setProductName(rs.getString("product_name")); // add this setter in OrderItem
                items.add(item);
            }
        }
        return items;
    }
}
