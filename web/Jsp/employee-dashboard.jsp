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
        <a href="${pageContext.request.contextPath}/logout.jsp">Logout</a>
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

    <h3>My Complaints</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Dept</th>
            <th>Priority</th>
            <th>Status</th>
            <th>Assigned To</th>
            <th>Remarks</th>
            <th>Created At</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (complaints != null && !complaints.isEmpty()) {
                for (ComplaintDTO c : complaints) {
        %>
        <tr>
            <td><%= c.getComplaintId() %></td>
            <td><%= c.getTitle() %></td>
            <td><%= c.getDepartment() %></td>
            <td><%= c.getPriority() %></td>
            <td><%= c.getStatus() %></td>
            <td><%= c.getAssignedToName() != null ? c.getAssignedToName() : "-" %></td>
            <td><%= c.getAdminRemarks() != null ? c.getAdminRemarks() : "-" %></td>
            <td><%= c.getCreatedAt() != null ? c.getCreatedAt() : "-" %></td>

            <td class="action-btns">
                <form action="view-complaint.jsp" method="get">
                    <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
                    <button class="view-btn">👁️ View</button>
                </form>
                <form action="edit-complaint.jsp" method="get">
                    <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
                    <button class="edit-btn">✏️ Edit</button>
                </form>
                <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
                <form action="delete-complaint.jsp" method="post">
                    <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
                    <button class="delete-btn">🗑️ Delete</button>
                </form>
                <% } else { %>
                <button class="delete-btn" disabled style="opacity:0.5;">🗑️ Delete</button>
                <% } %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="9" style="text-align:center;">No complaints found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
