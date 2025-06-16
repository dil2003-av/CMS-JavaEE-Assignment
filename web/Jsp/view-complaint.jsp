<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/15/2025
  Time: 10:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%
  String id = request.getParameter("id");
  ComplaintDAO dao = new ComplaintDAO();
  ComplaintDTO c = dao.getComplaintById(id);
%>
<h2>Complaint Details</h2>
<link rel="stylesheet" href="../CSS/employee-dashboard.css">
<p><strong>ID:</strong> <%= c.getComplaintId() %></p>
<p><strong>Title:</strong> <%= c.getTitle() %></p>
<p><strong>Description:</strong> <%= c.getDescription() %></p>
<p><strong>Department:</strong> <%= c.getDepartment() %></p>
<p><strong>Priority:</strong> <%= c.getPriority() %></p>
<p><strong>Status:</strong> <%= c.getStatus() %></p>
<p><strong>Assigned To:</strong> <%= c.getAssignedToName() != null ? c.getAssignedToName() : "-" %></p>
<p><strong>Remarks:</strong> <%= c.getAdminRemarks() != null ? c.getAdminRemarks() : "-" %></p>
<p><strong>Created At:</strong> <%= c.getCreatedAt() %></p>
