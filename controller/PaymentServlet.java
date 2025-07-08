package controller;

import dao.PaymentDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

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
        int orderId = (int) session.getAttribute("currentOrderId");
        String method = req.getParameter("method");

        try {
            paymentDAO.createPayment(orderId, method);
            session.removeAttribute("currentOrderId"); // Clear
            resp.sendRedirect("success.jsp");
        } catch (Exception e) {
            throw new ServletException("Payment failed", e);
        }
    }
}
