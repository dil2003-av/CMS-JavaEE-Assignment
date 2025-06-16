package com.assignment.controller;

import com.assignment.model.UserDTO;
import com.assignment.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/loginServlet")
public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Populate UserDTOa
                UserDTO user = new UserDTO();
                user.setId(rs.getInt("id")); // Or setUserId() if your field is String
                user.setName(rs.getString("username"));
                user.setPassword(null); // Don't store password in session
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));

                HttpSession session = request.getSession();
                session.setAttribute("user", user); // ✅ Correct object
                session.setAttribute("role", user.getRole());

                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/Jsp/admin-dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Jsp/employee-dashboard.jsp");
                }

            } else {
                response.getWriter().write("<script>alert('Invalid credentials');window.location='Jsp/login.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred during login.");
        }
    }
}
