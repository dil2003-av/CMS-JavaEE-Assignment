package com.assignment.dao;

import com.assignment.model.UserDTO;
import com.assignment.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public UserDTO authenticate(String email, String password) {
        String sql = "SELECT * FROM users WHERE LOWER(email) = LOWER(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (dbPassword.equals(password)) {
                    return extractUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createUser(UserDTO user) {
        String sql = "INSERT INTO users (id, name, password, email, role) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setString(2, user.getName());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getRole());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                userList.add(extractUser(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public UserDTO extractUser(ResultSet rs) throws SQLException {
        UserDTO user = new UserDTO();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        return user;
    }
}
