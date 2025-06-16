<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/15/2025
  Time: 10:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%
    String id = request.getParameter("id");
    ComplaintDTO complaint = null;
    if (id != null && !id.trim().isEmpty()) {
        ComplaintDAO dao = new ComplaintDAO();
        complaint = dao.getComplaintById(id);
    }

    if (complaint == null) {
%>
<h3 style="color: red;">Invalid Complaint ID or complaint not found!</h3>
<a href="../Jsp/employee-dashboard.jsp">Back</a>
<link rel="stylesheet" href="../CSS/employee-dashboard.css">
<%
        return; // stop executing below code if complaint is null
    }
%>

<form action="${pageContext.request.contextPath}/EditComplaintServlet" method="post">
    <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">

    <label>Title</label>
    <input type="text" name="title" value="<%= complaint.getTitle() %>" required>

    <label>Description</label>
    <textarea name="description"><%= complaint.getDescription() %></textarea>

    <label>Department</label>
    <select name="department">
        <option value="IT" <%= "IT".equals(complaint.getDepartment()) ? "selected" : "" %>>IT</option>
        <option value="HR" <%= "HR".equals(complaint.getDepartment()) ? "selected" : "" %>>HR</option>
        <option value="Admin" <%= "Admin".equals(complaint.getDepartment()) ? "selected" : "" %>>Admin</option>
    </select>

    <label>Priority</label>
    <select name="priority">
        <option value="Low" <%= "Low".equals(complaint.getPriority()) ? "selected" : "" %>>Low</option>
        <option value="Medium" <%= "Medium".equals(complaint.getPriority()) ? "selected" : "" %>>Medium</option>
        <option value="High" <%= "High".equals(complaint.getPriority()) ? "selected" : "" %>>High</option>
    </select>

    <label>Status</label>
    <select name="status">
        <option value="Pending" <%= "Pending".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
        <option value="In Progress" <%= "In Progress".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
        <option value="Resolved" <%= "Resolved".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
    </select>

    <button type="submit">Update</button>
</form>
