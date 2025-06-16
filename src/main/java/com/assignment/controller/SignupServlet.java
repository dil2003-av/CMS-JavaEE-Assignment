package com.assignment.controller;

import com.assignment.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        try (Connection con = DBConnection.getConnection()) {

            // 1. Check for duplicate username or email
            String checkSql = "SELECT username FROM users WHERE username = ? OR email = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkSql)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    response.getWriter().write("Username or Email already exists.");
                    return;
                }
            }

            // 2. Insert new user
            String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setString(4, role);

                int result = ps.executeUpdate();

                if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/Jsp/login.jsp?signup=success");
                } else {
                    response.getWriter().write("Signup failed. Please try again.");
                }
            }

        } catch (SQLIntegrityConstraintViolationException dupEx) {
            response.getWriter().write("Username or Email already exists. Please try again.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error occurred during signup.");
        }
    }
}
