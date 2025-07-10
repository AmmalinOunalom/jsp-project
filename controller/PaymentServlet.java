package controller;

import dao.PaymentDAO;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class PaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        // Get orderId from session
        Integer orderIdObj = (Integer) session.getAttribute("currentOrderId");
        if (orderIdObj == null) {
            resp.sendRedirect("cart.jsp?error=No order to pay");
            return;
        }
        int orderId = orderIdObj;

        // Get payment method parameter, default to "Unknown" if missing
        String method = req.getParameter("method");
        if (method == null || method.trim().isEmpty()) {
            method = "Unknown";
        }

        Connection conn = null;
        try {
            conn = paymentDAO.getConnection();
            conn.setAutoCommit(false); // begin transaction

            // Create payment record and update order status in one transaction
            paymentDAO.createPayment(conn, orderId, method);

            conn.commit(); // commit transaction

            // Clear order ID from session after successful payment
            session.removeAttribute("currentOrderId");

            resp.sendRedirect("success.jsp");
        } catch (SQLException e) {
            // Rollback transaction on error
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            throw new ServletException("Payment failed: " + e.getMessage(), e);
        } finally {
            // Reset auto-commit and close connection
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException closeEx) {
                    closeEx.printStackTrace();
                }
            }
        }
    }
}
