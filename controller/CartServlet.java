package controller;

import model.CartItem;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "view"; // default action
        }

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "view":
                showCart(request, response);
                break;
            case "remove":
                removeItem(request, response, cart);
                break;
            case "increase":
                changeQuantity(request, cart, 1);
                response.sendRedirect("cart.jsp");
                break;
            case "decrease":
                changeQuantity(request, cart, -1);
                response.sendRedirect("cart.jsp");
                break;
            default:
                showCart(request, response);
                break;
        }
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
        dispatcher.forward(request, response);
    }

    private void removeItem(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart)
            throws IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            cart.removeIf(item -> item.getProductId() == productId);
        }
        request.getSession().setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }

    private void changeQuantity(HttpServletRequest request, List<CartItem> cart, int delta) {
        String productIdStr = request.getParameter("productId");
        if (productIdStr != null) {
            int productId = Integer.parseInt(productIdStr);
            for (int i = 0; i < cart.size(); i++) {
                CartItem item = cart.get(i);
                if (item.getProductId() == productId) {
                    int newQty = item.getQuantity() + delta;
                    if (newQty <= 0) {
                        cart.remove(i);
                    } else {
                        item.setQuantity(newQty);
                    }
                    break;
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "add"; // default to add
        }

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        switch (action) {
            case "add":
                addToCart(request, response, cart);
                break;
            case "update":
                updateQuantity(request, response, cart);
                break;
            default:
                response.sendRedirect("cart.jsp");
                break;
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart)
            throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(productId, name, price, quantity));
        }

        response.sendRedirect("cart.jsp");
    }

    private void updateQuantity(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart)
            throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.setQuantity(quantity);
                break;
            }
        }

        response.sendRedirect("cart.jsp");
    }
}
