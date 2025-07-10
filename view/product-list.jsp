<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopHub - Premium Products</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            --secondary-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --accent-gradient: linear-gradient(135deg, #ff6b6b 0%, #ffa500 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 16px 48px rgba(0, 0, 0, 0.15);
            --shadow-hard: 0 24px 64px rgba(0, 0, 0, 0.2);
            --border-radius: 20px;
            --border-radius-small: 12px;
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--primary-gradient);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Enhanced Background Effects */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
        }

        .particle:nth-child(2n) {
            width: 2px;
            height: 2px;
            background: rgba(255, 255, 255, 0.3);
            animation: float 6s ease-in-out infinite reverse;
        }

        @keyframes float {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg) scale(1); 
                opacity: 0.4;
            }
            50% { 
                transform: translateY(-30px) rotate(180deg) scale(1.2); 
                opacity: 0.8;
            }
        }

        /* Glassmorphism Header */
        .header {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            animation: slideDown 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            width: 55px;
            height: 55px;
            background: var(--secondary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
        }

        .logo-icon:hover {
            transform: rotate(360deg) scale(1.1);
            box-shadow: var(--shadow-medium);
        }

        .logo-text {
            font-size: 32px;
            font-weight: 800;
            color: white;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .nav-btn {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            color: white;
            padding: 12px 24px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .nav-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-btn:hover::before {
            left: 100%;
        }

        .nav-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
            border-color: rgba(255, 255, 255, 0.4);
        }

        .nav-btn.secondary {
            background: var(--secondary-gradient);
            border: none;
        }

        .nav-btn.danger {
            background: var(--accent-gradient);
            border: none;
        }

        /* Enhanced Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 60px 20px;
            position: relative;
            z-index: 10;
        }

        .page-header {
            text-align: center;
            margin-bottom: 60px;
            animation: fadeInUp 1s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .page-title {
            font-size: 56px;
            font-weight: 800;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--secondary-gradient);
            border-radius: 2px;
        }

        .page-subtitle {
            font-size: 20px;
            color: rgba(255, 255, 255, 0.9);
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            font-weight: 400;
        }

        .admin-actions {
            display: flex;
            justify-content: center;
            margin-bottom: 50px;
            animation: slideUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .add-product-btn {
            background: var(--secondary-gradient);
            color: white;
            border: none;
            padding: 18px 36px;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 12px;
            transition: var(--transition);
            box-shadow: var(--shadow-soft);
            position: relative;
            overflow: hidden;
        }

        .add-product-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: translateX(-100%);
            transition: transform 0.6s;
        }

        .add-product-btn:hover::before {
            transform: translateX(100%);
        }

        .add-product-btn:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow: var(--shadow-medium);
        }

        /* Enhanced Product Grid */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 40px;
            margin-bottom: 60px;
        }

        .product-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
            position: relative;
            animation: cardSlideUp 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .product-card:hover::before {
            opacity: 1;
        }

        .product-card:hover {
            transform: translateY(-15px) scale(1.03);
            box-shadow: var(--shadow-hard);
            border-color: rgba(255, 255, 255, 0.3);
        }

        /* Fixed Image Container - Consistent Size */
        .product-image {
            width: 100%;
            height: 280px;
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            transition: var(--transition);
            border-radius: 0;
        }

        .product-card:hover .product-image img {
            transform: scale(1.1);
        }

        /* Fallback for missing images */
        .product-image-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
            color: #a0aec0;
            font-size: 48px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        }

        .product-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: var(--accent-gradient);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            box-shadow: var(--shadow-soft);
            z-index: 10;
        }

        .product-info {
            padding: 30px;
        }

        .product-id {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 12px;
        }

        .product-name {
            font-size: 24px;
            font-weight: 700;
            color: white;
            margin-bottom: 20px;
            line-height: 1.3;
        }

        .product-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .product-price {
            font-size: 32px;
            font-weight: 800;
            background: var(--secondary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: transparent;
        }

        .product-stock {
            display: flex;
            align-items: center;
            gap: 10px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        .stock-indicator {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--secondary-gradient);
            box-shadow: 0 0 10px rgba(56, 239, 125, 0.5);
        }

        .stock-indicator.low {
            background: var(--accent-gradient);
            box-shadow: 0 0 10px rgba(255, 107, 107, 0.5);
        }

        .product-actions {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .admin-actions-row {
            display: flex;
            gap: 12px;
            width: 100%;
        }

        .edit-btn, .delete-btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: var(--border-radius-small);
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: var(--transition);
            font-size: 14px;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .edit-btn {
            background: var(--secondary-gradient);
            color: white;
        }

        .edit-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .delete-btn {
            background: var(--accent-gradient);
            color: white;
        }

        .delete-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .cart-form {
            width: 100%;
            display: flex;
            gap: 12px;
            align-items: center;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            padding: 20px;
            border-radius: var(--border-radius-small);
        }

        .quantity-input {
            width: 70px;
            padding: 12px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transition: var(--transition);
        }

        .quantity-input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
        }

        .quantity-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .add-to-cart-btn {
            flex: 1;
            background: var(--secondary-gradient);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: var(--border-radius-small);
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative;
            overflow: hidden;
        }

        .add-to-cart-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .add-to-cart-btn:hover::before {
            left: 100%;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .add-to-cart-btn:active {
            transform: translateY(0);
        }

        .no-products {
            text-align: center;
            color: white;
            font-size: 24px;
            margin: 120px 0;
            animation: fadeIn 1s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .no-products i {
            font-size: 80px;
            margin-bottom: 30px;
            display: block;
            opacity: 0.7;
        }

        /* Enhanced Animations */
        @keyframes slideDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes slideUp {
            from {
                transform: translateY(80px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes cardSlideUp {
            from {
                opacity: 0;
                transform: translateY(60px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Loading States */
        .loading {
            pointer-events: none;
            opacity: 0.7;
        }

        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Enhanced Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
            }

            .nav-actions {
                flex-wrap: wrap;
                justify-content: center;
            }

            .page-title {
                font-size: 42px;
            }

            .products-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .product-details {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .cart-form {
                flex-direction: column;
                gap: 15px;
            }

            .admin-actions-row {
                flex-direction: column;
                gap: 10px;
            }

            .quantity-input {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 40px 15px;
            }

            .page-title {
                font-size: 36px;
            }

            .products-grid {
                grid-template-columns: 1fr;
                gap: 25px;
            }

            .product-info {
                padding: 20px;
            }

            .product-image {
                height: 250px;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--secondary-gradient);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--accent-gradient);
        }
    </style>
</head>
<body>
    <!-- Enhanced Floating Particles -->
    <div class="particles" id="particles"></div>

    <!-- Enhanced Header -->
    <header class="header">
        <div class="header-content">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="logo-text">ShopHub</div>
            </div>
            
            <div class="nav-actions">
                <a href="index.jsp" class="nav-btn">
                    <i class="fas fa-home"></i>
                    Home
                </a>
                <a href="cart.jsp" class="nav-btn secondary">
                    <i class="fas fa-shopping-cart"></i>
                    View Cart
                </a>
                <c:if test="${sessionScope.roleId == 1}">
                    <a href="admin.jsp" class="nav-btn danger">
                        <i class="fas fa-user-shield"></i>
                        Admin
                    </a>
                </c:if>
            </div>
        </div>
    </header>

    <!-- Enhanced Main Content -->
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Premium Products</h1>
            <p class="page-subtitle">Discover our curated collection of amazing products</p>
        </div>

        <!-- Enhanced Admin Actions -->
        <c:if test="${sessionScope.roleId == 1}">
            <div class="admin-actions">
                <a href="products?action=new" class="add-product-btn">
                    <i class="fas fa-plus"></i>
                    Add New Product
                </a>
            </div>
        </c:if>

        <!-- Enhanced Products Grid -->
        <c:choose>
            <c:when test="${not empty listProduct}">
                <div class="products-grid">
                    <c:forEach var="product" items="${listProduct}" varStatus="status">
                        <div class="product-card" >
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${not empty product.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" 
                                             alt="${product.name}"
                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                        <div class="product-image-placeholder" style="display: none;">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-image-placeholder">
                                            <i class="fas fa-image"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="product-badge">ID: ${product.id}</div>
                            </div>
                            
                            <div class="product-info">
                                <div class="product-id">Product #${product.id}</div>
                                <h3 class="product-name">${product.name}</h3>
                                
                                <div class="product-details">
                                    <div class="product-price">$${product.price}</div>
                                    <div class="product-stock">
                                        <div class="stock-indicator ${product.stock < 10 ? 'low' : ''}"></div>
                                        <span>${product.stock} in stock</span>
                                    </div>
                                </div>
                                
                                <div class="product-actions">
                                    <!-- Admin Actions -->
                                    <c:if test="${sessionScope.roleId == 1}">
                                        <div class="admin-actions-row">
                                            <a href="products?action=edit&id=${product.id}" class="edit-btn">
                                                <i class="fas fa-edit"></i>
                                                Edit
                                            </a>
                                            <a href="products?action=delete&id=${product.id}" class="delete-btn"
                                               onclick="return confirm('Are you sure you want to delete ${product.name}?')">
                                                <i class="fas fa-trash"></i>
                                                Delete
                                            </a>
                                        </div>
                                    </c:if>
                                    
                                    <!-- User Actions -->
                                    <c:if test="${sessionScope.roleId == 2}">
                                        <form action="add-to-cart" method="post" class="cart-form">
                                            <input type="hidden" name="productId" value="${product.id}" />
                                            <input type="hidden" name="name" value="${product.name}" />
                                            <input type="hidden" name="price" value="${product.price}" />
                                            
                                            <label for="quantity-${product.id}" style="font-weight: 600; color: rgba(255, 255, 255, 0.9);">Qty:</label>
                                            <input type="number" id="quantity-${product.id}" name="quantity" 
                                                   value="1" min="1" max="${product.stock}" class="quantity-input" 
                                                   placeholder="1" />
                                            
                                            <button type="submit" class="add-to-cart-btn">
                                                <i class="fas fa-cart-plus"></i>
                                                Add to Cart
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-products">
                    <i class="fas fa-box-open"></i>
                    <p>No products available at the moment.</p>
                    <c:if test="${sessionScope.roleId == 1}">
                        <p style="margin-top: 30px;">
                            <a href="products?action=new" class="add-product-btn">
                                <i class="fas fa-plus"></i>
                                Add First Product
                            </a>
                        </p>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Enhanced particle system
        function createParticles() {
            const container = document.getElementById('particles');
            const particleCount = 50;
            
            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.top = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 8 + 's';
                particle.style.animationDuration = (Math.random() * 4 + 4) + 's';
                
                // Random size variations
                const size = Math.random() * 2 + 2;
                particle.style.width = size + 'px';
                particle.style.height = size + 'px';
                
                container.appendChild(particle);
            }
        }

        // Enhanced interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize particles
            createParticles();

            // Enhanced form submissions with loading states
            const forms = document.querySelectorAll('.cart-form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const button = this.querySelector('.add-to-cart-btn');
                    const originalContent = button.innerHTML;
                    
                    // Add loading state
                    button.innerHTML = '<div class="spinner"></div>Adding...';
                    button.disabled = true;
                    button.classList.add('loading');
                });
            });

            // Enhanced quantity input validation
            const quantityInputs = document.querySelectorAll('.quantity-input');
            quantityInputs.forEach(input => {
                input.addEventListener('input', function() {
                    const max = parseInt(this.getAttribute('max'));
                    const min = parseInt(this.getAttribute('min'));
                    const value = parseInt(this.value);
                    
                    if (value > max) {
                        this.value = max;
                    } else if (value < min) {
                        this.value = min;
                    }
                });
            });
        });
    </script>
</body>
</html>