package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/EditComplaintServlet")
public class EditComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String complaintId = req.getParameter("complaintId"); // ✅ this is correct
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String department = req.getParameter("department");
        String priority = req.getParameter("priority");
        String status = req.getParameter("status");

        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(complaintId);

        if (complaint != null && "Pending".equalsIgnoreCase(complaint.getStatus())) {
            complaint.setTitle(title);
            complaint.setDescription(description);
            complaint.setDepartment(department);
            complaint.setPriority(priority);
            complaint.setStatus(status);

            boolean isUpdated = dao.updateComplaint(complaint);

            if (isUpdated) {
                resp.sendRedirect("employee-dashboard.jsp");
            } else {
                req.setAttribute("error", "Failed to update complaint.");
                req.getRequestDispatcher("../Jsp/edit-complaint.jsp?id=" + complaintId).forward(req, resp);
            }

        } else {
            req.setAttribute("error", "Only pending complaints can be edited.");
            req.getRequestDispatcher("../Jsp/edit-complaint.jsp?id=" + complaintId).forward(req, resp);
        }
    }
}
