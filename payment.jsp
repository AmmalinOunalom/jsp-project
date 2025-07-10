<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Secure Checkout</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #0c0c0c 0%, #1a1a2e 50%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.05) 0%, transparent 50%);
            animation: backgroundShift 20s ease-in-out infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translateX(0) translateY(0); }
            25% { transform: translateX(-5px) translateY(-10px); }
            50% { transform: translateX(10px) translateY(-5px); }
            75% { transform: translateX(-10px) translateY(10px); }
        }

        .payment-container {
            background: rgba(255, 255, 255, 0.02);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 40px;
            max-width: 480px;
            width: 100%;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.5),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            position: relative;
            z-index: 1;
            animation: slideIn 0.8s cubic-bezier(0.23, 1, 0.32, 1);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(40px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .payment-header {
            text-align: center;
            margin-bottom: 35px;
            position: relative;
        }

        .payment-header::before {
            content: '';
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { box-shadow: 0 0 10px rgba(102, 126, 234, 0.3); }
            to { box-shadow: 0 0 20px rgba(102, 126, 234, 0.6); }
        }

        .payment-icon {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 15px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .payment-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .payment-subtitle {
            font-size: 0.95rem;
            color: rgba(255, 255, 255, 0.6);
            font-weight: 400;
        }

        .payment-form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .form-group {
            position: relative;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-label {
            display: block;
            font-size: 0.9rem;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-label i {
            margin-right: 8px;
            color: #667eea;
        }

        .payment-select {
            width: 100%;
            padding: 16px 20px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            color: #ffffff;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23667eea' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 16px center;
            background-repeat: no-repeat;
            background-size: 16px;
            padding-right: 50px;
            position: relative;
        }

        .payment-select::before {
            content: '';
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
        }

        .payment-select[data-selected="Credit Card"]::before {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23667eea' viewBox='0 0 24 24'%3e%3cpath d='M2 4h20c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H2c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2zm0 4v2h20V8H2zm0 4v4h20v-4H2z'/%3e%3c/svg%3e");
        }

        .payment-select[data-selected="Cash"]::before {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23667eea' viewBox='0 0 24 24'%3e%3cpath d='M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1.41 16.09V20h-2.67v-1.93c-1.71-.36-3.16-1.46-3.27-3.4h1.96c.1 1.05.82 1.87 2.65 1.87 1.96 0 2.4-.98 2.4-1.59 0-.83-.44-1.61-2.67-2.14-2.48-.6-4.18-1.62-4.18-3.67 0-1.72 1.39-2.84 3.11-3.21V4h2.67v1.95c1.86.45 2.79 1.86 2.85 3.39H14.3c-.05-1.11-.64-1.87-2.22-1.87-1.5 0-2.4.68-2.4 1.64 0 .84.65 1.39 2.67 1.91s4.18 1.39 4.18 3.91c-.01 1.83-1.38 2.83-3.12 3.16z'/%3e%3c/svg%3e");
        }

        .payment-select[data-selected="Bank Transfer"]::before {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='%23667eea' viewBox='0 0 24 24'%3e%3cpath d='M12 3L2 9v10c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V9l-10-6zM5 19v-6h2v6H5zm6 0v-6h2v6h-2zm6 0v-6h2v6h-2z'/%3e%3c/svg%3e");
        }

        .payment-select.has-icon {
            padding-left: 50px;
        }

        .payment-select:focus {
            outline: none;
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }

        .payment-select:hover {
            border-color: rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.05);
        }

        .payment-select option {
            background: #1a1a2e;
            color: #ffffff;
            padding: 12px;
            border: none;
        }

        .payment-methods {
            display: flex;
            gap: 12px;
            margin-top: 15px;
            flex-wrap: wrap;
        }

        .method-icon {
            width: 50px;
            height: 32px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(255, 255, 255, 0.4);
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .method-icon:hover {
            background: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.8);
            transform: translateY(-2px);
        }

        .pay-button {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 16px;
            color: #ffffff;
            font-size: 1.1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            margin-top: 10px;
        }

        .pay-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .pay-button:hover::before {
            left: 100%;
        }

        .pay-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .pay-button:active {
            transform: translateY(-1px);
        }

        .pay-button i {
            margin-right: 10px;
        }

        .security-note {
            text-align: center;
            margin-top: 25px;
            padding: 16px;
            background: rgba(76, 175, 80, 0.1);
            border-radius: 12px;
            border: 1px solid rgba(76, 175, 80, 0.2);
            animation: fadeIn 1s ease-out 0.5s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .security-note i {
            color: #4caf50;
            margin-right: 8px;
        }

        .security-note p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.85rem;
            margin: 0;
        }

        .floating-particles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }

        .particle {
            position: absolute;
            width: 3px;
            height: 3px;
            background: rgba(102, 126, 234, 0.3);
            border-radius: 50%;
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% {
                transform: translateY(100vh) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) rotate(360deg);
                opacity: 0;
            }
        }

        .particle:nth-child(1) { left: 10%; animation-delay: 0s; }
        .particle:nth-child(2) { left: 20%; animation-delay: 2s; }
        .particle:nth-child(3) { left: 30%; animation-delay: 4s; }
        .particle:nth-child(4) { left: 40%; animation-delay: 6s; }
        .particle:nth-child(5) { left: 50%; animation-delay: 8s; }
        .particle:nth-child(6) { left: 60%; animation-delay: 10s; }
        .particle:nth-child(7) { left: 70%; animation-delay: 12s; }
        .particle:nth-child(8) { left: 80%; animation-delay: 14s; }
        .particle:nth-child(9) { left: 90%; animation-delay: 16s; }

        @media (max-width: 480px) {
            .payment-container {
                padding: 30px 20px;
                margin: 10px;
                border-radius: 20px;
            }

            .payment-icon {
                font-size: 2.5rem;
            }

            .payment-title {
                font-size: 1.5rem;
            }

            .payment-select {
                padding: 14px 16px;
                padding-right: 45px;
            }

            .pay-button {
                padding: 16px;
                font-size: 1rem;
            }

            .method-icon {
                width: 45px;
                height: 28px;
                font-size: 0.8rem;
            }
        }

        /* Loading animation */
        .pay-button.loading {
            pointer-events: none;
            position: relative;
        }

        .pay-button.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid #ffffff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .pay-button.loading .button-text {
            opacity: 0;
        }
    </style>
</head>
<body>
    <div class="floating-particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <div class="payment-container">
        <div class="payment-header">
            <div class="payment-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h2 class="payment-title">Secure Payment</h2>
            <p class="payment-subtitle">Choose your preferred payment method</p>
        </div>

        <form class="payment-form" action="PaymentServlet" method="post">
            <div class="form-group">
                <label class="form-label" for="payment-method">
                    <i class="fas fa-credit-card"></i>
                    Payment Method
                </label>
                <select class="payment-select" name="method" id="payment-method" required>
                    <option value="">Select payment method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Cash">Cash Payment</option>
                    <option value="Bank Transfer">Bank Transfer</option>
                </select>
                
                <div class="payment-methods">
                    <div class="method-icon" title="Visa">
                        <i class="fab fa-cc-visa"></i>
                    </div>
                    <div class="method-icon" title="Mastercard">
                        <i class="fab fa-cc-mastercard"></i>
                    </div>
                    <div class="method-icon" title="PayPal">
                        <i class="fab fa-cc-paypal"></i>
                    </div>
                    <div class="method-icon" title="Apple Pay">
                        <i class="fab fa-cc-apple-pay"></i>
                    </div>
                </div>
            </div>

            <button type="submit" class="pay-button" id="payButton">
                <span class="button-text">
                    <i class="fas fa-shield-alt"></i>
                    Pay Now Securely
                </span>
            </button>
        </form>

        <div class="security-note">
            <p>
                <i class="fas fa-shield-alt"></i>
                Your payment information is encrypted and secure
            </p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const payButton = document.getElementById('payButton');
            const paymentSelect = document.getElementById('payment-method');
            const form = document.querySelector('.payment-form');

            // Add loading state to button
            form.addEventListener('submit', function(e) {
                if (paymentSelect.value === '') {
                    e.preventDefault();
                    alert('Please select a payment method');
                    return;
                }
                
                payButton.classList.add('loading');
                setTimeout(() => {
                    // Remove loading state after 2 seconds (in case form doesn't redirect)
                    payButton.classList.remove('loading');
                }, 2000);
            });

            // Add smooth focus effects
            paymentSelect.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });

            paymentSelect.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });

            // Add selection animation
            paymentSelect.addEventListener('change', function() {
                if (this.value !== '') {
                    this.style.background = 'rgba(102, 126, 234, 0.08)';
                    this.style.borderColor = '#667eea';
                } else {
                    this.style.background = 'rgba(255, 255, 255, 0.03)';
                    this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                }
            });

            // Add hover effects for method icons
            const methodIcons = document.querySelectorAll('.method-icon');
            methodIcons.forEach(icon => {
                icon.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-3px) scale(1.05)';
                });
                
                icon.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });

            // Add keyboard navigation
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' && document.activeElement === paymentSelect) {
                    e.preventDefault();
                    paymentSelect.click();
                }
            });

            // Add form validation animation
            paymentSelect.addEventListener('invalid', function() {
                this.style.borderColor = '#ff6b6b';
                this.style.boxShadow = '0 0 0 3px rgba(255, 107, 107, 0.1)';
                
                setTimeout(() => {
                    this.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                    this.style.boxShadow = 'none';
                }, 2000);
            });
        });
    </script>
</body>
</html>