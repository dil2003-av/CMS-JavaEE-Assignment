package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/AddComplaintServlet")
public class AddComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String department = req.getParameter("department");
        String priority = req.getParameter("priority");
        String status = req.getParameter("status");
        String submittedBy = req.getParameter("submittedBy");

        ComplaintDTO complaint = new ComplaintDTO();
        complaint.setComplaintId(UUID.randomUUID().toString());
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setDepartment(department);
        complaint.setPriority(priority);
        complaint.setStatus(status);
        complaint.setSubmittedBy(submittedBy);

        ComplaintDAO dao = new ComplaintDAO();
        boolean isSaved = dao.createComplaint(complaint);

        if (isSaved) {
            List<ComplaintDTO> complaints = dao.getComplaintsByUser(submittedBy);
            req.setAttribute("complaints", complaints);

            HttpSession session = req.getSession(false);
            if (session != null) {
                req.setAttribute("user", session.getAttribute("user"));
            }

            req.getRequestDispatcher("/Jsp/my-complaints.jsp").forward(req, resp);

        } else {
            req.setAttribute("error", "Failed to save complaint.");
            req.getRequestDispatcher("/Jsp/my-complaints.jsp").forward(req, resp); // ✅ FIXED PATH
        }
    }
}
