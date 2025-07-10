<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopHub - Premium E-Commerce Experience</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Falling Animation Background */
        .falling-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .falling-item {
            position: absolute;
            color: rgba(255, 255, 255, 0.1);
            font-size: 20px;
            animation: fall linear infinite;
        }

        @keyframes fall {
            0% {
                transform: translateY(-100px) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        /* Header */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 15px 0;
            animation: slideDown 0.8s ease-out;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
        }

        .logo-text {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome-text {
            color: #4a5568;
            font-weight: 500;
        }

        .user-badge {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn {
            background: #e53e3e;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: #c53030;
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(197, 48, 48, 0.3);
        }

        .auth-links {
            display: flex;
            gap: 15px;
        }

        .auth-links a {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .auth-links a:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
            position: relative;
            z-index: 10;
        }

        .hero-section {
            text-align: center;
            margin-bottom: 60px;
            animation: fadeInUp 1s ease-out;
        }

        .hero-title {
            font-size: 48px;
            font-weight: 700;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .hero-subtitle {
            font-size: 20px;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* Navigation Cards */
        .nav-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 60px;
        }

        .nav-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        .nav-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .nav-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
        }

        .nav-card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
            margin-bottom: 20px;
            box-shadow: 0 8px 16px rgba(102, 126, 234, 0.3);
        }

        .nav-card-title {
            font-size: 24px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .nav-card-links {
            list-style: none;
        }

        .nav-card-links li {
            margin-bottom: 12px;
        }

        .nav-card-links a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-card-links a:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(5px);
        }

        /* Categories Section */
        .categories-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-out;
        }

        .section-title {
            font-size: 32px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .category-item {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 20px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .category-item:hover {
            border-color: #667eea;
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.2);
        }

        .category-name {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .category-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .category-actions a {
            padding: 6px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .edit-btn {
            background: #38a169;
            color: white;
        }

        .edit-btn:hover {
            background: #2f855a;
            transform: translateY(-2px);
        }

        .delete-btn {
            background: #e53e3e;
            color: white;
        }

        .delete-btn:hover {
            background: #c53030;
            transform: translateY(-2px);
        }

        /* Animations */
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
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
            }

            .hero-title {
                font-size: 36px;
            }

            .hero-subtitle {
                font-size: 18px;
            }

            .nav-grid {
                grid-template-columns: 1fr;
            }

            .categories-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Admin Badge */
        .admin-badge {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <!-- Falling Animation Container -->
    <div class="falling-container" id="fallingContainer"></div>

    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-shopping-bag"></i>
                </div>
                <div class="logo-text">ShopHub</div>
            </div>

            <div class="user-info">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="welcome-text">Welcome back!</div>
                        <div class="user-badge">
                            <i class="fas fa-user"></i>
                            ${sessionScope.user.username}
                            <c:if test="${sessionScope.roleId == 1}">
                                <span class="admin-badge">ADMIN</span>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                            <i class="fas fa-sign-out-alt"></i>
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <div class="auth-links">
                            <a href="${pageContext.request.contextPath}/login">
                                <i class="fas fa-sign-in-alt"></i>
                                Login
                            </a>
                            <a href="${pageContext.request.contextPath}/register">
                                <i class="fas fa-user-plus"></i>
                                Register
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <!-- Hero Section -->
                <section class="hero-section">
                    <h1 class="hero-title">Welcome to ShopHub</h1>
                    <p class="hero-subtitle">Your premium shopping destination awaits</p>
                </section>

                <!-- Navigation Cards -->
                <div class="nav-grid">
                    <div class="nav-card">
                        <div class="nav-card-icon">
                            <i class="fas fa-box"></i>
                        </div>
                        <h3 class="nav-card-title">Products</h3>
                        <ul class="nav-card-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/products?action=list">
                                    <i class="fas fa-eye"></i>
                                    Browse All Products
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="nav-card">
                        <div class="nav-card-icon">
                            <i class="fas fa-history"></i>
                        </div>
                        <h3 class="nav-card-title">Orders</h3>
                        <ul class="nav-card-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/order-history">
                                    <i class="fas fa-clipboard-list"></i>
                                    Your Order History
                                </a>
                            </li>
                        </ul>
                    </div>

                    <c:if test="${sessionScope.roleId == 1}">
                        <div class="nav-card">
                            <div class="nav-card-icon">
                                <i class="fas fa-cog"></i>
                            </div>
                            <h3 class="nav-card-title">Admin Panel</h3>
                            <ul class="nav-card-links">
                                <li>
                                    <a href="${pageContext.request.contextPath}/categories?action=list">
                                        <i class="fas fa-list"></i>
                                        Manage Categories
                                    </a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/categories?action=new">
                                        <i class="fas fa-plus"></i>
                                        Add New Category
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </div>

                <!-- Categories Section -->
                <section class="categories-section">
                    <h2 class="section-title">Product Categories</h2>
                    <div class="categories-grid">
                        <c:forEach var="category" items="${categories}">
                            <div class="category-item">
                                <div class="category-name">
                                    <i class="fas fa-tag"></i>
                                    ${category.name}
                                </div>
                                <c:if test="${sessionScope.roleId == 1}">
                                    <div class="category-actions">
                                        <a href="${pageContext.request.contextPath}/categories?action=edit&id=${category.id}" class="edit-btn">
                                            <i class="fas fa-edit"></i>
                                            Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/categories?action=delete&id=${category.id}" 
                                           class="delete-btn"
                                           onclick="return confirm('Are you sure you want to delete this category?')">
                                            <i class="fas fa-trash"></i>
                                            Delete
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </section>

            </c:when>
            <c:otherwise>
                <!-- Guest Hero Section -->
                <section class="hero-section">
                    <h1 class="hero-title">Welcome to ShopHub</h1>
                    <p class="hero-subtitle">Discover amazing products and exclusive deals</p>
                </section>

                <div class="nav-grid">
                    <div class="nav-card">
                        <div class="nav-card-icon">
                            <i class="fas fa-rocket"></i>
                        </div>
                        <h3 class="nav-card-title">Get Started</h3>
                        <ul class="nav-card-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt"></i>
                                    Sign In to Your Account
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus"></i>
                                    Create New Account
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script>
        // Falling animation script
        function createFallingItem() {
            const container = document.getElementById('fallingContainer');
            const item = document.createElement('div');
            item.className = 'falling-item';
            
            // Random e-commerce icons
            const icons = ['💎', '🛍️', '💳', '🎁', '⭐', '🏷️', '📦', '🛒', '💰', '🎊'];
            item.innerHTML = icons[Math.floor(Math.random() * icons.length)];
            
            // Random position and animation duration
            item.style.left = Math.random() * 100 + '%';
            item.style.animationDuration = (Math.random() * 3 + 2) + 's';
            item.style.animationDelay = Math.random() * 2 + 's';
            
            container.appendChild(item);
            
            // Remove item after animation
            setTimeout(() => {
                if (item.parentNode) {
                    item.parentNode.removeChild(item);
                }
            }, 5000);
        }

        // Create falling items continuously
        setInterval(createFallingItem, 800);

        // Add smooth scroll behavior
        document.addEventListener('DOMContentLoaded', function() {
            // Add staggered animation to grid items
            const gridItems = document.querySelectorAll('.nav-card, .category-item');
            gridItems.forEach((item, index) => {
                item.style.animationDelay = (index * 0.1) + 's';
            });

            // Add hover effects to interactive elements
            const interactiveElements = document.querySelectorAll('a, button');
            interactiveElements.forEach(element => {
                element.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                element.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
        });

        // Add parallax effect to hero section
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const hero = document.querySelector('.hero-section');
            if (hero) {
                hero.style.transform = `translateY(${scrolled * 0.5}px)`;
            }
        });
    </script>
</body>
</html>