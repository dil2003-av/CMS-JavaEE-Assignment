<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Login</title>
    <link rel="stylesheet" type="text/css" href="../CSS/login.css">
</head>
<body>

<%
    String signupStatus = request.getParameter("signup");
    if ("success".equals(signupStatus)) {
%>
<div style="color: green; font-weight: bold;">
    Signup successful! Please login now.
</div>
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
