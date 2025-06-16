package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/ViewComplaintServlet")
public class ViewComplaintServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String complaintId = req.getParameter("id");
        if (complaintId == null || complaintId.isEmpty()) {
            resp.sendRedirect("../Jsp/employee-dashboard.jsp");
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();
        ComplaintDTO complaint = dao.getComplaintById(complaintId);

        if (complaint == null) {
            req.setAttribute("error", "Complaint not found");
            req.getRequestDispatcher("../Jsp/employee-dashboard.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("complaint", complaint);
        req.getRequestDispatcher("../Jsp/view-complaint.jsp").forward(req, resp);
    }
}
