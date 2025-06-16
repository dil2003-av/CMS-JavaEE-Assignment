<%--
  Created by IntelliJ IDEA.
  User: dilmi kaushalya
  Date: 6/15/2025
  Time: 10:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.assignment.dao.ComplaintDAO" %>
<%@ page import="com.assignment.model.ComplaintDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String id = request.getParameter("id");

    if (id != null && !id.isEmpty()) {
        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(id);

        if (complaint != null && "Pending".equalsIgnoreCase(complaint.getStatus())) {
            dao.deleteComplaint(id);
        }
    }

    response.sendRedirect("../Jsp/employee-dashboard.jsp");
%>


