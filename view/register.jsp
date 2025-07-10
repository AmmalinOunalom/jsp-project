<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - ShopHub</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 100%;
            max-width: 450px;
            position: relative;
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        .register-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
        }

        .brand-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .brand-logo {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 24px;
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .brand-title {
            font-size: 28px;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .brand-subtitle {
            color: #718096;
            font-size: 16px;
        }

        .form-section {
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            text-align: center;
        }

        .error-message {
            background: linear-gradient(135deg, #fed7d7, #feb2b2);
            color: #c53030;
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #e53e3e;
            font-size: 14px;
            display: flex;
            align-items: center;
            animation: shake 0.5s ease-in-out;
        }

        .error-message i {
            margin-right: 8px;
        }

        .form-group {
            position: relative;
            margin-bottom: 25px;
        }

        .form-group label {
            position: absolute;
            top: 50%;
            left: 45px;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 16px;
            pointer-events: none;
            transition: all 0.3s ease;
            z-index: 1;
        }

        .form-group input {
            width: 100%;
            padding: 16px 20px 16px 45px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            background: white;
            transition: all 0.3s ease;
            position: relative;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .form-group input:focus + label,
        .form-group input:valid + label {
            top: -10px;
            left: 15px;
            font-size: 12px;
            color: #667eea;
            background: white;
            padding: 0 8px;
        }

        .form-group .icon {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #a0aec0;
            font-size: 16px;
            z-index: 2;
            transition: color 0.3s ease;
        }

        .form-group input:focus ~ .icon {
            color: #667eea;
        }

        .register-btn {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .register-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }

        .register-btn:hover::before {
            left: 100%;
        }

        .register-btn:active {
            transform: translateY(0);
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e2e8f0;
        }

        .divider span {
            padding: 0 15px;
            color: #718096;
            font-size: 14px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .features {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        .feature {
            text-align: center;
            color: #718096;
            font-size: 12px;
        }

        .feature i {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            color: #667eea;
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

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        @media (max-width: 480px) {
            .register-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .brand-title {
                font-size: 24px;
            }
            
            .form-group input {
                padding: 14px 18px 14px 40px;
            }
            
            .register-btn {
                padding: 14px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="brand-section">
            <div class="brand-logo">
                <i class="fas fa-shopping-bag"></i>
            </div>
            <h1 class="brand-title">ShopHub</h1>
            <p class="brand-subtitle">Your premium shopping destination</p>
        </div>

        <div class="form-section">
            <h2 class="section-title">Create Your Account</h2>
            
            <!-- Error message display -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <form action="register" method="post">
                <div class="form-group">
                    <input type="text" name="username" id="username" required>
                    <label for="username">Username</label>
                    <i class="fas fa-user icon"></i>
                </div>

                <div class="form-group">
                    <input type="email" name="email" id="email" required>
                    <label for="email">Email Address</label>
                    <i class="fas fa-envelope icon"></i>
                </div>

                <div class="form-group">
                    <input type="password" name="password" id="password" required>
                    <label for="password">Password</label>
                    <i class="fas fa-lock icon"></i>
                </div>

                <button type="submit" class="register-btn">
                    <i class="fas fa-user-plus"></i>&nbsp;&nbsp;Create Account
                </button>
            </form>

            <div class="divider">
                <span>Already a member?</span>
            </div>

            <div class="login-link">
                <a href="login">
                    <i class="fas fa-sign-in-alt"></i>&nbsp;&nbsp;Sign in to your account
                </a>
            </div>
        </div>

        <div class="features">
            <div class="feature">
                <i class="fas fa-shield-alt"></i>
                Secure
            </div>
            <div class="feature">
                <i class="fas fa-shipping-fast"></i>
                Fast Delivery
            </div>
            <div class="feature">
                <i class="fas fa-star"></i>
                Quality Products
            </div>
        </div>
    </div>

    <script>
        // Add smooth interactions
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input');
            const button = document.querySelector('.register-btn');
            
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.classList.remove('focused');
                });
            });
            
            // Add loading state to button
            button.addEventListener('click', function() {
                const form = this.closest('form');
                if (form.checkValidity()) {
                    this.innerHTML = '<i class="fas fa-spinner fa-spin"></i>&nbsp;&nbsp;Creating Account...';
                    this.disabled = true;
                }
            });
        });
    </script>
</body>
</html>