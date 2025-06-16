<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/14/2025
  Time: 1:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.assignment.model.UserDTO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !user.getRole().equals("Admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h2>Welcome, Admin: <%= user.getName() %></h2>
<link rel="stylesheet" href="../CSS/admin-dashboard.css">


<nav>
    <a href="../Jsp/view-complaint.jsp">View All Complaints</a> |
    <a href="LogoutServlet">Logout</a>
</nav>

<hr>
<p>This is the admin panel. You can view all complaints submitted by employees.</p>

</body>
</html>

