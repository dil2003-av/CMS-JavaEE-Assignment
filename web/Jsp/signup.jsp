<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/13/2025
  Time: 7:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" type="text/css" href="../CSS/signup.css">
    <script src="../JS/signup-validation.js"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/SignupServlet" method="post"onsubmit="return validateSignupForm();">
    <h2>User Registration</h2>
    <input type="text" name="username" placeholder="Full Name" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="email" name="email" placeholder="Email" required>

    <select name="role" required>
        <option value="" disabled selected>Select Role</option>
        <option value="Employee">Employee</option>
        <option value="Admin">Admin</option>
    </select>
    <input type="submit" value="Sign Up">
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</form>
</body>
</html>

