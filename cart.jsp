<%@ page import="java.util.List" %>
<%@ page import="model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - Your Store</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .content {
            padding: 40px;
        }

        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .empty-cart i {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-cart h2 {
            color: #666;
            margin-bottom: 10px;
            font-size: 1.8rem;
        }

        .empty-cart p {
            color: #999;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .cart-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .cart-table td {
            padding: 20px 15px;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
            transition: all 0.3s ease;
        }

        .cart-table tr:hover td {
            background: #f8f9ff;
            transform: scale(1.01);
        }

        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .product-name {
            font-weight: 600;
            color: #333;
            font-size: 1.1rem;
        }

        .price {
            color: #667eea;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .quantity {
            background: #f8f9ff;
            padding: 8px 15px;
            border-radius: 25px;
            font-weight: 600;
            color: #667eea;
            text-align: center;
            min-width: 60px;
        }

        .subtotal {
            color: #2c3e50;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .decrease-btn {
            background: #ff6b6b;
            color: white;
        }

        .increase-btn {
            background: #51cf66;
            color: white;
        }

        .remove-btn {
            background: #868e96;
            color: white;
            font-size: 0.8rem;
            width: auto;
            padding: 8px 15px;
            border-radius: 20px;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .decrease-btn:hover {
            background: #ff5252;
        }

        .increase-btn:hover {
            background: #40c057;
        }

        .remove-btn:hover {
            background: #495057;
        }

        .total-row {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .total-row td {
            border-bottom: none;
            font-weight: 700;
            font-size: 1.2rem;
            padding: 25px 15px;
        }

        .checkout-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .btn-primary:hover {
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        .checkout-form {
            margin: 0;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 15px;
            }

            .header {
                padding: 20px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .content {
                padding: 20px;
            }

            .cart-table {
                font-size: 0.9rem;
            }

            .cart-table th,
            .cart-table td {
                padding: 15px 10px;
            }

            .checkout-section {
                flex-direction: column;
                align-items: stretch;
            }

            .btn {
                justify-content: center;
                width: 100%;
            }

            .actions {
                flex-direction: column;
                gap: 5px;
            }

            .action-btn {
                width: 100%;
                border-radius: 20px;
            }
        }

        .loading {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .spinner {
            border: 4px solid #f3f3f3;
            border-top: 4px solid #667eea;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-shopping-cart"></i> Your Shopping Cart</h1>
            <p>Review your items and proceed to checkout</p>
        </div>

        <div class="content">
            <%
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Your cart is empty</h2>
                    <p>Looks like you haven't added any items to your cart yet.</p>
                    <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-primary">
                        <i class="fas fa-arrow-left"></i>
                        Start Shopping
                    </a>
                </div>
            <%
                } else {
            %>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-box"></i> Product</th>
                            <th><i class="fas fa-tag"></i> Price</th>
                            <th><i class="fas fa-sort-numeric-up"></i> Quantity</th>
                            <th><i class="fas fa-calculator"></i> Subtotal</th>
                            <th><i class="fas fa-cogs"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            double total = 0.0;
                            for (CartItem item : cart) {
                                double subtotal = item.getPrice() * item.getQuantity();
                                total += subtotal;
                        %>
                        <tr>
                            <td class="product-name"><%= item.getName() %></td>
                            <td class="price">$<%= String.format("%.2f", item.getPrice()) %></td>
                            <td><span class="quantity"><%= item.getQuantity() %></span></td>
                            <td class="subtotal">$<%= String.format("%.2f", subtotal) %></td>
                            <td>
                                <div class="actions">
                                    <a href="cart?action=decrease&productId=<%= item.getProductId() %>" 
                                       class="action-btn decrease-btn" 
                                       title="Decrease quantity">
                                        <i class="fas fa-minus"></i>
                                    </a>
                                    <a href="cart?action=increase&productId=<%= item.getProductId() %>" 
                                       class="action-btn increase-btn" 
                                       title="Increase quantity">
                                        <i class="fas fa-plus"></i>
                                    </a>
                                    <a href="cart?action=remove&productId=<%= item.getProductId() %>" 
                                       class="action-btn remove-btn" 
                                       title="Remove item"
                                       onclick="return confirm('Are you sure you want to remove this item?')">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                        <tr class="total-row">
                            <td colspan="3"><i class="fas fa-receipt"></i> Total Amount:</td>
                            <td colspan="2">$<%= String.format("%.2f", total) %></td>
                        </tr>
                    </tbody>
                </table>

                <div class="checkout-section">
                    <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Continue Shopping
                    </a>
                    
                    <form class="checkout-form" action="CheckoutServlet" method="post">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-credit-card"></i>
                            Proceed to Checkout
                        </button>
                    </form>
                </div>

                <div class="loading" id="loading">
                    <div class="spinner"></div>
                    <p>Processing your request...</p>
                </div>
            <%
                }
            %>
        </div>
    </div>

    <script>
        // Add loading animation for form submissions
        document.addEventListener('DOMContentLoaded', function() {
            const checkoutForm = document.querySelector('.checkout-form');
            const loading = document.getElementById('loading');
            
            if (checkoutForm) {
                checkoutForm.addEventListener('submit', function() {
                    loading.style.display = 'block';
                });
            }

            // Add smooth scrolling for better UX
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });

            // Add confirmation for remove actions
            document.querySelectorAll('.remove-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    if (!confirm('Are you sure you want to remove this item from your cart?')) {
                        e.preventDefault();
                    }
                });
            });
        });
    </script>
</body>
</html>