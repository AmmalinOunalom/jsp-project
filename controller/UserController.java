package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserController extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null)
            action = "list";

        try {
            switch (action) {
                case "list":
                    listUsers(req, resp);
                    break;
                case "profile":
                    showProfile(req, resp);
                    break;
                case "delete":
                    deleteUser(req, resp);
                    break;
                default:
                    resp.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listUsers(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        List<User> users = userDAO.getAllUsers(); // You must add this method
        req.setAttribute("users", users);
        req.getRequestDispatcher("/view/user-list.jsp").forward(req, resp);
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        User user = userDAO.getUserById(id); // You must add this method
        req.setAttribute("user", user);
        req.getRequestDispatcher("/view/user-profile.jsp").forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        userDAO.deleteUser(id); // You must add this method
        resp.sendRedirect(req.getContextPath() + "/users?action=list");
    }
}
