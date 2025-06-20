<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" type="text/css" href="../CSS/login.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../JS/login-validation.js"></script>
</head>
<body>


<%
    String signupStatus = request.getParameter("signup");
    if ("success".equals(signupStatus)) {
%>
<script>
    alert("Signup successful! Please login now.");
</script>
<%
    }
%>

<form action="${pageContext.request.contextPath}/loginServlet" method="post">
    <h2>User Login</h2>
    <input type="email" name="email" placeholder="Enter your email" required>
    <input type="password" name="password" placeholder="Enter your password" required>
    <input type="submit" value="Login">
    <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
</form>

</body>
</html>
