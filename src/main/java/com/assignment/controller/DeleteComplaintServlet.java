package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeleteComplaintServlet")
public class DeleteComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String complaintId = req.getParameter("id");

        if (complaintId == null || complaintId.isEmpty()) {
            resp.sendRedirect("../Jsp/employee-dashboard.jsp");
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(complaintId);

        if (complaint != null && "Pending".equalsIgnoreCase(complaint.getStatus())) {
            boolean deleted = dao.deleteComplaint(complaintId);
            if (!deleted) {
                // You can add error handling if needed here
                req.setAttribute("error", "Failed to delete complaint.");
                req.getRequestDispatcher("../Jsp/employee-dashboard.jsp").forward(req, resp);
                return;
            }
        } else {
            // Not allowed to delete if not pending
            req.setAttribute("error", "Only pending complaints can be deleted.");
            req.getRequestDispatcher("../Jsp/employee-dashboard.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect("../Jsp/employee-dashboard.jsp");
    }
}
