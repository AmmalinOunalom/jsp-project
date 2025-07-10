<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - Thank You!</title>
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

        /* Animated Background */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 30% 20%, rgba(76, 175, 80, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 70% 80%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 20% 80%, rgba(255, 193, 7, 0.08) 0%, transparent 50%);
            animation: backgroundPulse 8s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { transform: scale(1) rotate(0deg); }
            50% { transform: scale(1.1) rotate(2deg); }
        }

        /* Success Container */
        .success-container {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(25px);
            border-radius: 30px;
            padding: 50px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            position: relative;
            z-index: 1;
            animation: successPopup 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        @keyframes successPopup {
            0% {
                opacity: 0;
                transform: scale(0.3) translateY(100px);
            }
            70% {
                transform: scale(1.05) translateY(-10px);
            }
            100% {
                opacity: 1;
                transform: scale(1) translateY(0);
            }
        }

        /* Success Icon */
        .success-icon {
            position: relative;
            margin-bottom: 30px;
            animation: iconBounce 2s ease-in-out;
        }

        @keyframes iconBounce {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .success-check {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #4caf50, #66bb6a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            position: relative;
            box-shadow: 0 15px 30px rgba(76, 175, 80, 0.3);
            animation: checkPulse 2s infinite;
        }

        @keyframes checkPulse {
            0% { box-shadow: 0 15px 30px rgba(76, 175, 80, 0.3); }
            50% { box-shadow: 0 15px 40px rgba(76, 175, 80, 0.5); }
            100% { box-shadow: 0 15px 30px rgba(76, 175, 80, 0.3); }
        }

        .success-check::before {
            content: '';
            position: absolute;
            top: -10px;
            left: -10px;
            right: -10px;
            bottom: -10px;
            background: linear-gradient(45deg, #4caf50, #66bb6a, #4caf50);
            border-radius: 50%;
            z-index: -1;
            animation: rotate 3s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .success-check i {
            font-size: 3rem;
            color: white;
            animation: checkmark 0.8s ease-in-out 0.3s both;
        }

        @keyframes checkmark {
            0% {
                opacity: 0;
                transform: scale(0) rotate(45deg);
            }
            100% {
                opacity: 1;
                transform: scale(1) rotate(0deg);
            }
        }

        /* Success Content */
        .success-title {
            font-size: 2.5rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 15px;
            letter-spacing: -0.5px;
            animation: titleSlide 1s ease-out 0.5s both;
        }

        @keyframes titleSlide {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-message {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
            line-height: 1.6;
            animation: messageSlide 1s ease-out 0.7s both;
        }

        @keyframes messageSlide {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Order Details */
        .order-details {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            animation: detailsSlide 1s ease-out 0.9s both;
        }

        @keyframes detailsSlide {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .order-details h3 {
            color: #4caf50;
            margin-bottom: 15px;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .order-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .order-info:last-child {
            margin-bottom: 0;
        }

        .order-info span {
            color: rgba(255, 255, 255, 0.7);
        }

        .order-info strong {
            color: #ffffff;
            font-weight: 600;
        }

        /* Navigation Buttons */
        .nav-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            animation: buttonsSlide 1s ease-out 1.1s both;
        }

        @keyframes buttonsSlide {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 15px 25px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #4caf50, #66bb6a);
            color: white;
            box-shadow: 0 8px 20px rgba(76, 175, 80, 0.3);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
        }

        .btn-primary:hover {
            box-shadow: 0 12px 30px rgba(76, 175, 80, 0.4);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        /* Countdown Timer */
        .countdown {
            margin-top: 25px;
            padding: 15px;
            background: rgba(255, 193, 7, 0.1);
            border-radius: 10px;
            border: 1px solid rgba(255, 193, 7, 0.3);
            animation: countdownSlide 1s ease-out 1.3s both;
        }

        @keyframes countdownSlide {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .countdown p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin: 0;
        }

        .countdown-number {
            color: #ffc107;
            font-weight: 700;
            font-size: 1.1rem;
        }

        /* Floating Particles */
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
            width: 4px;
            height: 4px;
            background: rgba(76, 175, 80, 0.6);
            border-radius: 50%;
            animation: float 8s infinite linear;
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

        .particle:nth-child(1) { left: 10%; animation-delay: 0s; background: rgba(76, 175, 80, 0.6); }
        .particle:nth-child(2) { left: 20%; animation-delay: 1s; background: rgba(102, 126, 234, 0.6); }
        .particle:nth-child(3) { left: 30%; animation-delay: 2s; background: rgba(255, 193, 7, 0.6); }
        .particle:nth-child(4) { left: 40%; animation-delay: 3s; background: rgba(76, 175, 80, 0.6); }
        .particle:nth-child(5) { left: 50%; animation-delay: 4s; background: rgba(102, 126, 234, 0.6); }
        .particle:nth-child(6) { left: 60%; animation-delay: 5s; background: rgba(255, 193, 7, 0.6); }
        .particle:nth-child(7) { left: 70%; animation-delay: 6s; background: rgba(76, 175, 80, 0.6); }
        .particle:nth-child(8) { left: 80%; animation-delay: 7s; background: rgba(102, 126, 234, 0.6); }
        .particle:nth-child(9) { left: 90%; animation-delay: 0.5s; background: rgba(255, 193, 7, 0.6); }

        /* Confetti Animation */
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: #4caf50;
            animation: confetti-fall 3s linear infinite;
        }

        @keyframes confetti-fall {
            0% {
                transform: translateY(-100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }

        .confetti:nth-child(1) { left: 10%; animation-delay: 0s; background: #4caf50; }
        .confetti:nth-child(2) { left: 20%; animation-delay: 0.3s; background: #2196f3; }
        .confetti:nth-child(3) { left: 30%; animation-delay: 0.6s; background: #ff9800; }
        .confetti:nth-child(4) { left: 40%; animation-delay: 0.9s; background: #e91e63; }
        .confetti:nth-child(5) { left: 50%; animation-delay: 1.2s; background: #9c27b0; }
        .confetti:nth-child(6) { left: 60%; animation-delay: 1.5s; background: #4caf50; }
        .confetti:nth-child(7) { left: 70%; animation-delay: 1.8s; background: #2196f3; }
        .confetti:nth-child(8) { left: 80%; animation-delay: 2.1s; background: #ff9800; }
        .confetti:nth-child(9) { left: 90%; animation-delay: 2.4s; background: #e91e63; }

        /* Mobile Responsive */
        @media (max-width: 600px) {
            .success-container {
                padding: 30px 20px;
                margin: 10px;
                border-radius: 25px;
            }

            .success-title {
                font-size: 2rem;
            }

            .success-message {
                font-size: 1.1rem;
            }

            .nav-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .success-check {
                width: 80px;
                height: 80px;
            }

            .success-check i {
                font-size: 2.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Particles -->
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

    <!-- Confetti -->
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>

    <!-- Success Container -->
    <div class="success-container">
        <div class="success-icon">
            <div class="success-check">
                <i class="fas fa-check"></i>
            </div>
        </div>

        <h1 class="success-title">Payment Successful!</h1>
        <p class="success-message">
            Thank you for your purchase! Your order has been successfully processed and you will receive a confirmation email shortly.
        </p>

        <div class="order-details">
            <h3><i class="fas fa-receipt"></i> Order Summary</h3>
            <div class="order-info">
                <span>Order ID:</span>
                <strong>#<%= java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase() %></strong>
            </div>
            <div class="order-info">
                <span>Payment Status:</span>
                <strong style="color: #4caf50;">Confirmed</strong>
            </div>
            <div class="order-info">
                <span>Processing Time:</span>
                <strong>1-2 Business Days</strong>
            </div>
        </div>

        <div class="nav-buttons">
            <a href="index.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i>
                Back to Home
            </a>
            <a href="products?action=list" class="btn btn-secondary">
                <i class="fas fa-shopping-bag"></i>
                Continue Shopping
            </a>
        </div>

        <div class="countdown">
            <p>
                <i class="fas fa-clock"></i>
                Redirecting to home page in <span class="countdown-number" id="countdown">10</span> seconds...
            </p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Countdown timer
            let countdown = 10;
            const countdownElement = document.getElementById('countdown');
            
            const timer = setInterval(() => {
                countdown--;
                countdownElement.textContent = countdown;
                
                if (countdown <= 0) {
                    clearInterval(timer);
                    window.location.href = 'index.jsp';
                }
            }, 1000);

            // Add click sound effect simulation
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('click', function() {
                    this.style.transform = 'translateY(-1px) scale(0.98)';
                    setTimeout(() => {
                        this.style.transform = 'translateY(-3px) scale(1)';
                    }, 100);
                });
            });

            // Add extra celebration after 1 second
            setTimeout(() => {
                // Create additional confetti burst
                for (let i = 0; i < 20; i++) {
                    createConfetti();
                }
            }, 1000);

            function createConfetti() {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.backgroundColor = getRandomColor();
                confetti.style.animationDelay = Math.random() * 3 + 's';
                document.body.appendChild(confetti);
                
                setTimeout(() => {
                    confetti.remove();
                }, 3000);
            }

            function getRandomColor() {
                const colors = ['#4caf50', '#2196f3', '#ff9800', '#e91e63', '#9c27b0', '#ffc107'];
                return colors[Math.floor(Math.random() * colors.length)];
            }

            // Prevent accidental page reload
            window.addEventListener('beforeunload', function(e) {
                if (countdown > 0) {
                    e.preventDefault();
                    e.returnValue = '';
                }
            });
        });
    </script>
</body>
</html>