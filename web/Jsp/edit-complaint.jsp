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
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Complaint</title>
    <style>
        body {
            background: linear-gradient(to right, #f9fbff, #e9f1ff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 50px;
        }

        .form-container {
            background-color: #ffffff;
            padding: 40px;
            max-width: 600px;
            margin: auto;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #1e3a8a;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: border 0.3s ease;
        }

        input[type="text"]:focus,
        textarea:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Edit Complaint</h2>
    <form action="${pageContext.request.contextPath}/EditComplaintServlet" method="post">
        <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">

        <label>Title</label>
        <input type="text" name="title" value="<%= complaint.getTitle() %>" required>

        <label>Description</label>
        <textarea name="description" rows="4"><%= complaint.getDescription() %></textarea>

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

        <button type="submit">Update Complaint</button>
    </form>
    <a href="../Jsp/my-complaints.jsp">← Back to My Complaints</a>
</div>
</body>
</html>
