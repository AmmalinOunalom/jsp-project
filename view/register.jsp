<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <title>Register</title>
        </head>

        <body>
            <h2>Register</h2>

            <!-- 🔴 Show error message in red if exists -->
            <c:if test="${not empty error}">
                <p style="color: red;">${error}</p>
            </c:if>

            <form action="register" method="post">
                Username: <input type="text" name="username" required /><br />
                Email: <input type="email" name="email" required /><br />
                Password: <input type="password" name="password" required /><br />
                <input type="submit" value="Register" />
            </form>

            <p>Already have an account? <a href="login">Login here</a></p>
        </body>

        </html>