package com.assignment.controller;

import com.assignment.dao.ComplaintDAO;
import com.assignment.model.ComplaintDTO;
import com.assignment.model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/EmployeeDashboardServlet")
public class EmployeeDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null || !"Employee".equals(user.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        ComplaintDAO dao = new ComplaintDAO();
        List<ComplaintDTO> complaints = dao.getComplaintsByUser(String.valueOf(user.getId()));
        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("/Jsp/employee-dashboard.jsp").forward(req, resp);
    }
}
