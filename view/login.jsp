<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ShopHub - Sign In to Your Account</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #f5576c 75%, #4facfe 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Shopping icons floating animation */
        .floating-icon {
            position: absolute;
            opacity: 0.08;
            animation: float 25s linear infinite;
            font-size: 28px;
            color: white;
            filter: blur(0.5px);
        }

        @keyframes float {
            0% {
                transform: translateY(100vh) rotate(0deg) scale(0.8);
                opacity: 0;
            }
            5% {
                opacity: 0.08;
            }
            95% {
                opacity: 0.08;
            }
            100% {
                transform: translateY(-100vh) rotate(360deg) scale(1.2);
                opacity: 0;
            }
        }

        /* Smooth particle effects */
        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            animation: particle 12s ease-in-out infinite;
        }

        @keyframes particle {
            0% {
                transform: translateY(0) translateX(0) scale(0);
                opacity: 0;
            }
            10% {
                opacity: 0.6;
                transform: translateY(-10vh) translateX(10px) scale(1);
            }
            90% {
                opacity: 0.4;
                transform: translateY(-90vh) translateX(80px) scale(0.8);
            }
            100% {
                transform: translateY(-100vh) translateX(100px) scale(0);
                opacity: 0;
            }
        }

        /* Smooth breathing effect overlay */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 30% 70%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: breathe 8s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes breathe {
            0%, 100% { opacity: 0.3; transform: scale(1); }
            50% { opacity: 0.6; transform: scale(1.05); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 50px 40px;
            border-radius: 24px;
            box-shadow: 
                0 32px 64px rgba(0, 0, 0, 0.12),
                0 0 0 1px rgba(255, 255, 255, 0.2),
                inset 0 1px 0 rgba(255, 255, 255, 0.4);
            width: 100%;
            max-width: 420px;
            position: relative;
            z-index: 10;
            animation: slideUp 1s cubic-bezier(0.4, 0, 0.2, 1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 40px 80px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(255, 255, 255, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.5);
        }

        @keyframes slideUp {
            0% {
                opacity: 0;
                transform: translateY(60px) scale(0.9);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeIn 1.2s ease-out 0.3s both;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .brand-logo {
            font-size: 36px;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
            letter-spacing: -1px;
            animation: logoShine 3s ease-in-out infinite;
        }

        @keyframes logoShine {
            0%, 100% { filter: brightness(1); }
            50% { filter: brightness(1.2); }
        }

        .login-header h2 {
            font-size: 28px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .login-header p {
            color: #6b7280;
            font-size: 16px;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 28px;
            position: relative;
            animation: slideInLeft 0.8s ease-out both;
        }

        .form-group:nth-child(1) { animation-delay: 0.4s; }
        .form-group:nth-child(2) { animation-delay: 0.6s; }

        @keyframes slideInLeft {
            0% {
                opacity: 0;
                transform: translateX(-30px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-group label {
            display: block;
            margin-bottom: 12px;
            color: #374151;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .input-wrapper {
            position: relative;
            overflow: hidden;
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .input-wrapper:hover {
            transform: translateY(-2px);
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 18px 24px;
            border: 2px solid #e5e7eb;
            border-radius: 16px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.9);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            outline: none;
            font-weight: 500;
            color: #1f2937;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus {
            border-color: #667eea;
            background: rgba(255, 255, 255, 1);
            box-shadow: 
                0 0 0 4px rgba(102, 126, 234, 0.1),
                0 8px 32px rgba(102, 126, 234, 0.15);
            transform: translateY(-3px);
        }

        .form-group input[type="text"]:focus + .input-highlight,
        .form-group input[type="password"]:focus + .input-highlight {
            transform: scaleX(1);
            opacity: 1;
        }

        .input-highlight {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
            transform: scaleX(0);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 3px;
            opacity: 0;
        }

        .input-group {
            position: relative;
            margin-bottom: 28px;
        }

        .input-group input[type="password"] {
            padding-right: 60px;
        }

        .toggle-password {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 24px;
            height: 24px;
            fill: #9ca3af;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 2px;
            border-radius: 50%;
        }

        .toggle-password:hover {
            fill: #667eea;
            background: rgba(102, 126, 234, 0.1);
            transform: translateY(-50%) scale(1.1);
        }

        .submit-btn {
            width: 100%;
            padding: 18px 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            background-size: 200% 200%;
            color: white;
            border: none;
            border-radius: 16px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: 10px;
            animation: slideInRight 0.8s ease-out 0.8s both;
        }

        @keyframes slideInRight {
            0% {
                opacity: 0;
                transform: translateX(30px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .submit-btn:hover {
            transform: translateY(-4px);
            background-position: 100% 0;
            box-shadow: 
                0 16px 40px rgba(102, 126, 234, 0.4),
                0 0 0 1px rgba(255, 255, 255, 0.3);
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:active {
            transform: translateY(-2px);
            transition: transform 0.1s ease;
        }

        .error-message {
            color: #dc2626;
            background: linear-gradient(135deg, #fef2f2, #fee2e2);
            border: 1px solid #fecaca;
            padding: 16px 20px;
            margin-bottom: 24px;
            border-radius: 16px;
            text-align: center;
            font-weight: 500;
            font-size: 14px;
            animation: errorSlide 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        @keyframes errorSlide {
            0% {
                opacity: 0;
                transform: translateY(-20px) scale(0.9);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .register-link {
            text-align: center;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
            font-size: 15px;
            color: #6b7280;
            animation: fadeIn 1s ease-out 1s both;
        }

        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .register-link a:hover {
            color: #764ba2;
            transform: translateY(-1px);
        }

        .register-link a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(135deg, #667eea, #764ba2, #f093fb);
            transition: width 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .register-link a:hover::after {
            width: 100%;
        }

        /* Loading state with smooth animation */
        .submit-btn.loading {
            pointer-events: none;
            opacity: 0.9;
            background: linear-gradient(135deg, #9ca3af 0%, #6b7280 100%);
        }

        .submit-btn.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top-color: #fff;
            border-radius: 50%;
            animation: smoothSpin 1s cubic-bezier(0.4, 0, 0.2, 1) infinite;
        }

        @keyframes smoothSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Enhanced focus states */
        .form-group.focused label {
            color: #667eea;
            transform: translateY(-2px);
        }

        /* Shopping cart icon */
        .cart-icon {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 32px;
            height: 32px;
            opacity: 0.6;
            animation: cartBounce 2s ease-in-out infinite;
        }

        @keyframes cartBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        /* Responsive design with smooth transitions */
        @media (max-width: 480px) {
            .login-container {
                padding: 35px 25px;
                margin: 15px;
                border-radius: 20px;
                transform: none;
            }
            
            .login-container:hover {
                transform: translateY(-2px);
            }
            
            .brand-logo {
                font-size: 32px;
            }
            
            .login-header h2 {
                font-size: 24px;
            }
            
            .form-group input[type="text"],
            .form-group input[type="password"] {
                padding: 16px 20px;
                font-size: 16px;
            }
            
            .submit-btn {
                padding: 16px 20px;
            }
        }

        /* Smooth accessibility improvements */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.3s !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.3s !important;
            }
        }

        /* High contrast mode support */
        @media (prefers-contrast: high) {
            .login-container {
                border: 2px solid #000;
                background: rgba(255, 255, 255, 1);
            }
            
            .form-group input[type="text"],
            .form-group input[type="password"] {
                border: 2px solid #000;
            }
        }
    </style>
</head>

<body>
    <!-- Shopping cart icon -->
    <svg class="cart-icon" fill="white" viewBox="0 0 24 24">
        <path d="M7 18c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12L8.1 13h7.45c.75 0 1.41-.41 1.75-1.03L21.7 4H5.21l-.94-2H1zm16 16c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2z"/>
    </svg>

    <div class="login-container">
        <div class="login-header">
            <div class="brand-logo">ShopHub</div>
            <h2>Welcome Back</h2>
            <p>Sign in to continue shopping</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="login" method="post" id="loginForm">
            <div class="form-group">
                <label for="username">Email or Username</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" required autocomplete="username" />
                    <div class="input-highlight"></div>
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-group">
                    <div class="input-wrapper">
                        <input type="password" id="password" name="password" required autocomplete="current-password" />
                        <div class="input-highlight"></div>
                    </div>
                    <svg id="togglePassword" class="toggle-password" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M12 5c-7 0-11 7-11 7s4 7 11 7 11-7 11-7-4-7-11-7zm0 12a5 5 0 1 1 0-10 5 5 0 0 1 0 10z" />
                        <circle cx="12" cy="12" r="2.5" />
                    </svg>
                </div>
            </div>

            <input type="submit" value="Sign In & Start Shopping" class="submit-btn" />
        </form>

        <div class="register-link">
            New to ShopHub? <a href="register">Create your account</a>
        </div>
    </div>

    <script>
        // Password toggle functionality with smooth animation
        const togglePassword = document.querySelector('#togglePassword');
        const passwordInput = document.querySelector('#password');

        togglePassword.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            togglePassword.style.fill = (type === 'text') ? '#667eea' : '#9ca3af';
            
            // Smooth icon transition
            togglePassword.style.transform = 'translateY(-50%) scale(0.8)';
            setTimeout(() => {
                togglePassword.style.transform = 'translateY(-50%) scale(1)';
            }, 150);
        });

        // Enhanced focus effects with smooth transitions
        document.querySelectorAll('input[type="text"], input[type="password"]').forEach(input => {
            input.addEventListener('focus', function() {
                this.closest('.form-group').classList.add('focused');
                this.closest('.form-group').querySelector('label').style.color = '#667eea';
                this.closest('.form-group').querySelector('label').style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.closest('.form-group').classList.remove('focused');
                this.closest('.form-group').querySelector('label').style.color = '#374151';
                this.closest('.form-group').querySelector('label').style.transform = 'translateY(0)';
            });

            // Smooth input typing effect
            input.addEventListener('input', function() {
                this.style.transform = 'translateY(-1px)';
                setTimeout(() => {
                    this.style.transform = 'translateY(0)';
                }, 100);
            });
        });

        // Form submission with smooth loading state
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const submitBtn = document.querySelector('.submit-btn');
            const originalText = submitBtn.value;
            
            submitBtn.classList.add('loading');
            submitBtn.value = 'Signing you in...';
            
            // Simulate loading (remove this in production)
            setTimeout(() => {
                submitBtn.classList.remove('loading');
                submitBtn.value = originalText;
            }, 2500);
        });

        // Create smooth floating shopping icons
        const shoppingIcons = ['🛒', '🛍️', '💳', '🏪', '📦', '💰', '🎁', '⭐', '🔖', '🏷️'];
        
        function createFloatingIcon() {
            const icon = document.createElement('div');
            icon.className = 'floating-icon';
            icon.textContent = shoppingIcons[Math.floor(Math.random() * shoppingIcons.length)];
            icon.style.left = Math.random() * 100 + '%';
            icon.style.animationDuration = (Math.random() * 10 + 20) + 's';
            icon.style.animationDelay = Math.random() * 5 + 's';
            document.body.appendChild(icon);
            
            setTimeout(() => {
                icon.remove();
            }, 30000);
        }

        // Create smooth particles
        function createParticle() {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDuration = (Math.random() * 8 + 10) + 's';
            particle.style.animationDelay = Math.random() * 3 + 's';
            document.body.appendChild(particle);
            
            setTimeout(() => {
                particle.remove();
            }, 15000);
        }

        // Initialize smooth animations
        setInterval(createFloatingIcon, 3000);
        setInterval(createParticle, 1500);

        // Create initial effects
        for (let i = 0; i < 8; i++) {
            setTimeout(createFloatingIcon, Math.random() * 5000);
        }
        
        for (let i = 0; i < 15; i++) {
            setTimeout(createParticle, Math.random() * 3000);
        }

        // Smooth scroll to top on page load
        window.addEventListener('load', function() {
            document.body.style.opacity = '0';
            setTimeout(() => {
                document.body.style.transition = 'opacity 0.5s ease';
                document.body.style.opacity = '1';
            }, 100);
        });

        // Add smooth hover effects to the container
        const container = document.querySelector('.login-container');
        container.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.01)';
        });
        
        container.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    </script>
</body>

</html>