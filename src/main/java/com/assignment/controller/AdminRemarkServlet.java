package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;
import com.assignment.model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/AdminRemarkServlet")
public class AdminRemarkServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

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
        String remark = req.getParameter("remark");
        String action = req.getParameter("action"); // approve or decline

        if (complaintId == null || remark == null || action == null) {
            String contextPath = req.getContextPath();
            resp.sendRedirect(contextPath + "/Jsp/admin-dashboard.jsp");
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(complaintId);

        if (complaint != null) {
            complaint.setAdminRemarks(remark);
            complaint.setStatus(action);
            boolean updated = dao.updateComplaintStatusAndRemark(complaint);
            if (!updated) {
                req.setAttribute("error", "Failed to update complaint.");
                req.getRequestDispatcher("../Jsp/admin-dashboard.jsp").forward(req, resp);
                return;
            }
        } else {
            req.setAttribute("error", "Complaint not found.");
            req.getRequestDispatcher("../Jsp/admin-dashboard.jsp").forward(req, resp);
            return;
        }

        if ("approve".equals(action)) {
            String contextPath = req.getContextPath();
            // Your approval logic here...
            resp.sendRedirect(contextPath + "/Jsp/admin-dashboard.jsp?status=approved");
        } else if ("decline".equals(action)) {
            String contextPath = req.getContextPath();
            // Your decline logic here...
            resp.sendRedirect(contextPath + "/Jsp/admin-dashboard.jsp?status=declined");
        }

    }
}
