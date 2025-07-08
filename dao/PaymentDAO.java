package dao;

import java.sql.*;

public class PaymentDAO {

    private String jdbcURL = "jdbc:postgresql://localhost:5432/postgres";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "1234";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("PostgreSQL Driver not found.", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void createPayment(int orderId, String method) throws SQLException {
        String insertSql = "INSERT INTO payments (order_id, amount, method, status) " +
                "SELECT id, total, ?, 'Completed' FROM orders WHERE id = ?";
        String updateOrderSql = "UPDATE orders SET status = 'Paid' WHERE id = ?";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false); // start transaction
            try (PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                    PreparedStatement updateStmt = conn.prepareStatement(updateOrderSql)) {

                // Insert payment record
                insertStmt.setString(1, method);
                insertStmt.setInt(2, orderId);
                insertStmt.executeUpdate();

                // Update order status
                updateStmt.setInt(1, orderId);
                updateStmt.executeUpdate();

                conn.commit(); // commit transaction
            } catch (SQLException e) {
                conn.rollback(); // rollback on error
                throw e;
            } finally {
                conn.setAutoCommit(true); // reset autocommit
            }
        }
    }
}
