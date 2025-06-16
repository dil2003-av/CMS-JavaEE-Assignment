<%@ page import="java.util.List" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%@ page import="com.assignment.model.UserDTO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  UserDTO user = (UserDTO) session.getAttribute("user");
  List<ComplaintDTO> complaints = (List<ComplaintDTO>) request.getAttribute("complaints");

  if (user == null || !user.getRole().equals("Employee")) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>My Complaints</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #f9fbff, #e9f1ff);
      color: #333;
    }

    .container {
      max-width: 1200px;
      margin: 30px auto;
      background: #ffffff;
      border-radius: 16px;
      padding: 30px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    h3 {
      color: #1e3a8a;
      margin-bottom: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
      background-color: #fff;
    }

    th, td {
      padding: 14px 12px;
      border-bottom: 1px solid #e0e0e0;
      text-align: left;
    }

    th {
      background-color: #007bff;
      color: #fff;
      text-transform: uppercase;
      font-size: 13px;
    }

    tr:hover {
      background-color: #f1f1f1;
    }

    .action-btns form {
      display: inline;
    }

    .edit-btn, .delete-btn, .view-btn {
      border: none;
      padding: 8px 12px;
      border-radius: 20px;
      color: white;
      font-weight: 600;
      cursor: pointer;
      margin-right: 5px;
      font-size: 13px;
      transition: 0.3s;
    }

    .edit-btn {
      background-color: #28a745;
    }

    .edit-btn:hover {
      background-color: #218838;
    }

    .delete-btn {
      background-color: #dc3545;
    }

    .delete-btn:hover {
      background-color: #c82333;
    }

    .view-btn {
      background-color: #17a2b8;
    }

    .view-btn:hover {
      background-color: #138496;
    }
  </style>
</head>
<body>
<div class="container">
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
        <form action="edit-complaint.jsp" method="get">
          <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
          <button class="edit-btn">Edit</button>
        </form>

        <% if ("Pending".equalsIgnoreCase(c.getStatus())) { %>
        <form action="delete-complaint.jsp" method="post">
          <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
          <button class="delete-btn">Delete</button>
        </form>
        <% } else { %>
        <button class="delete-btn" disabled style="opacity:0.5;">Delete</button>
        <% } %>

        <form action="view-complaint.jsp" method="get">
          <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
          <button class="view-btn">View</button>
        </form>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr><td colspan="9" style="text-align:center;">No complaints found.</td></tr>
    <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
