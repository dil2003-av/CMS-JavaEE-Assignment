package com.assignment.controller;



import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;
import com.assignment.model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AdminDeleteComplaintServlet")
public class AdminDeleteComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check if user is admin
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String complaintId = req.getParameter("id");

        if (complaintId == null || complaintId.isEmpty()) {
            resp.sendRedirect("../Jsp/admin-dashboard.jsp");  // Redirect to admin dashboard
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(complaintId);

        if (complaint != null) {
            boolean deleted = dao.deleteComplaint(complaintId);
            if (!deleted) {
                req.setAttribute("error", "Failed to delete complaint.");
                req.getRequestDispatcher("../Jsp/admin-dashboard.jsp").forward(req, resp);
                return;
            }
        } else {
            req.setAttribute("error", "Complaint not found.");
            req.getRequestDispatcher("../Jsp/admin-dashboard.jsp").forward(req, resp);
            return;
        }

        // After successful delete redirect back to admin dashboard
        resp.sendRedirect("../Jsp/admin-dashboard.jsp");
    }
}
