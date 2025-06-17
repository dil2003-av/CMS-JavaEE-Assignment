package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/AdminRemarkServlet")
public class AdminRemarkServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get parameters from form
        String complaintId = request.getParameter("id");
        String action = request.getParameter("action"); // approve or decline
        String remark = request.getParameter("remark");

        // Null check and action type verification
        if (complaintId != null && action != null && remark != null &&
                (action.equalsIgnoreCase("approve") || action.equalsIgnoreCase("decline"))) {

            ComplaintDAO dao = new ComplaintDAO();
            dao.updateStatusAndRemark(complaintId, action, remark);
        }

        // Redirect to admin dashboard after update
        response.sendRedirect("../Jsp/admin-dashboard.jsp"); // ✅ Make sure this path is correct
    }
}
