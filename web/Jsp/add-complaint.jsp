<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/15/2025
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%@ page import="com.assignment.model.UserDTO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !user.getRole().equals("Employee")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Add Complaint</title>
    <link rel="stylesheet" href="../CSS/employee-dashboard.css">
</head>
<body>
<div class="container">
    <h2>Add New Complaint</h2>
    <form action="${pageContext.request.contextPath}/AddComplaintServlet" method="post">
        <input type="hidden" name="submittedBy" value="<%= user.getId() %>">

        <label>Title</label><br>
        <input type="text" name="title" required><br><br>

        <label>Description</label><br>
        <textarea name="description" rows="4" required></textarea><br><br>

        <label>Department</label><br>
        <select name="department" required>
            <option value="IT">IT</option>
            <option value="HR">HR</option>
            <option value="Admin">Admin</option>
        </select><br><br>

        <label>Priority</label><br>
        <select name="priority" required>
            <option value="Low">Low</option>
            <option value="Medium">Medium</option>
            <option value="High">High</option>
        </select><br><br>

        <label>Status</label><br>
        <select name="status" required>
            <option value="Pending" selected>Pending</option>
            <option value="In Progress">In Progress</option>
            <option value="Resolved">Resolved</option>
        </select><br><br>

        <button type="submit">Submit Complaint</button>
    </form>

    <br>
    <a href="employee-dashboard.jsp">Back to Dashboard</a>
</div>
</body>
</html>

