package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        try {
            // Check if username or email already exists
            if (userDAO.findByUsername(username) != null) {
                req.setAttribute("error", "Username already exists!");
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                return;
            }
            if (userDAO.findByEmail(email) != null) { // <-- Add this method in UserDAO
                req.setAttribute("error", "Email already registered!");
                req.getRequestDispatcher("/view/register.jsp").forward(req, resp);
                return;
            }

            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);

            userDAO.insertUser(user);
            resp.sendRedirect(req.getContextPath() + "/login");
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
