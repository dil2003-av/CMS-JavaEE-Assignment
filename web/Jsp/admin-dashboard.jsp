<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/14/2025
  Time: 1:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%@ page import="com.assignment.model.UserDTO" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    ComplaintDAO dao = new ComplaintDAO();
    List<ComplaintDTO> complaints = dao.getAllComplaints();
%>

<html>
<head>
    <title>View Complaints</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 20px;
            color: #333;
        }
        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
            font-size: 14px;
        }
        th {
            background-color: #2980b9;
            color: white;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9fbfc;
        }
        tr:hover {
            background-color: #d3e4f1;
        }
        textarea {
            width: 90%;
            height: 60px;
            resize: vertical;
            padding: 8px;
            font-size: 13px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-family: Arial, sans-serif;
        }
        button {
            border: none;
            padding: 6px 12px;
            margin: 2px;
            cursor: pointer;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            color: white;
        }

        /* Dark green approve */
        .btn-approve {
            background-color: #218c74;
        }

        /* Dark red decline */
        .btn-decline {
            background-color: #e74c3c;
        }

        /* Delete - even darker red */
        .btn-delete {
            background-color: #c0392b;
        }

        button {
            border: none;
            padding: 6px 12px;
            margin: 2px;
            cursor: pointer;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
        }
        button[style*="green"] {
            background-color: #27ae60;
            color: white;
        }
        button[style*="red"] {
            background-color: #c0392b;
            color: white;
        }
        button[style*="darkred"] {
            background-color: #8b0000;
            color: white;
        }
        form {
            display: inline-block;
            margin: 0;
        }
    </style>
</head>
<body>
<h2>Welcome, Admin: <%= user.getName() %></h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Description</th>
        <th>Date Submitted</th>
        <th>Status</th>
        <th>Remark</th>
        <th>User ID</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (ComplaintDTO c : complaints) {
    %>
    <tr>
        <td><%= c.getComplaintId() %></td>
        <td><%= c.getDescription() %></td>
        <td><%= c.getCreatedAt() %></td>
        <td><%= c.getStatus() %></td>
        <td><%= c.getAdminRemarks() != null ? c.getAdminRemarks() : "no" %></td>
        <td><%= c.getSubmittedBy() %></td>
        <td>
            <%
                boolean isPending = !"approve".equalsIgnoreCase(c.getStatus()) && !"decline".equalsIgnoreCase(c.getStatus());
            %>

            <% if (isPending) { %>
            <form action="${pageContext.request.contextPath}/AdminRemarkServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
                <textarea name="remark" placeholder="Write your response..." required></textarea>
                <button class="btn-approve" name="action" value="approve">Approve</button>
                <button class="btn-decline" name="action" value="decline">Decline</button>
            </form>
            <% } %>

            <form action="${pageContext.request.contextPath}/AdminDeleteComplaintServlet" method="post" style="display:inline;">
                <input type="hidden" name="id" value="<%= c.getComplaintId() %>">
                <button class="btn-delete">Delete</button>
            </form>
        </td>

    </tr>
    <% } %>
    </tbody>
</table>
</body>
</html>


