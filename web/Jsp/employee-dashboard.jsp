<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%@ page import="com.assignment.model.UserDTO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !user.getRole().equals("Employee")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");
    if (complaints == null) {
        ComplaintDAO dao = new ComplaintDAO();
        complaints = dao.getComplaintsByUser(String.valueOf(user.getId()));
    }
%>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="../CSS/employee-dashboard.css">
</head>
<body>
<div class="container">
    <div class="navbar">
        <a href="../Jsp/employee-dashboard.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/log">Logout</a>
    </div>

    <h2>Welcome, Employee: <%= user.getName() %></h2>

    <h3>Submit New Complaint</h3>
    <form action="${pageContext.request.contextPath}/AddComplaintServlet" method="post">
        <input type="hidden" name="submittedBy" value="<%= user.getId() %>">

        <label>Title</label>
        <input type="text" name="title" required>

        <label>Description</label>
        <textarea name="description" rows="3" required></textarea>

        <label>Department</label>
        <select name="department" required>
            <option value="IT">IT</option>
            <option value="HR">HR</option>
            <option value="Admin">Admin</option>
        </select>

        <label>Priority</label>
        <select name="priority" required>
            <option value="Low">Low</option>
            <option value="Medium">Medium</option>
            <option value="High">High</option>
        </select>

        <label>Status</label>
        <select name="status" required>
            <option value="Pending">Pending</option>
            <option value="In Progress">In Progress</option>
            <option value="Resolved">Resolved</option>
        </select>

        <button type="submit">Save Complaint</button>
    </form>


</div>
</body>
</html>
