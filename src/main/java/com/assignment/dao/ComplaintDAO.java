package com.assignment.dao;

import com.assignment.model.ComplaintDTO;
import com.assignment.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {

    public boolean createComplaint(ComplaintDTO complaint) {
        String sql = "INSERT INTO complaints (complaint_id, title, description, department, priority, status, submitted_by, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaint.getComplaintId());
            pstmt.setString(2, complaint.getTitle());
            pstmt.setString(3, complaint.getDescription());
            pstmt.setString(4, complaint.getDepartment());
            pstmt.setString(5, complaint.getPriority());
            pstmt.setString(6, complaint.getStatus());
            pstmt.setString(7, complaint.getSubmittedBy());
            pstmt.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error creating complaint", e);
        }
    }

    public ComplaintDTO getComplaintById(String complaintId) {
        String sql = "SELECT * FROM complaints WHERE complaint_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToComplaint(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching complaint by ID", e);
        }
        return null;
    }

    public List<ComplaintDTO> getComplaintsByUser(String userId) {
        List<ComplaintDTO> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE submitted_by = ? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    complaints.add(mapResultSetToComplaint(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching complaints by user", e);
        }
        return complaints;
    }
    public boolean updateComplaint(ComplaintDTO complaint) {
        String sql = "UPDATE complaints SET title = ?, description = ?, department = ?, priority = ?, status = ?, updated_at = ? WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaint.getTitle());
            pstmt.setString(2, complaint.getDescription());
            pstmt.setString(3, complaint.getDepartment());
            pstmt.setString(4, complaint.getPriority());
            pstmt.setString(5, complaint.getStatus());
            pstmt.setTimestamp(6, Timestamp.valueOf(java.time.LocalDateTime.now()));
            pstmt.setString(7, complaint.getComplaintId());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error updating complaint", e);
        }
    }

    public boolean deleteComplaint(String complaintId) {
        String sql = "DELETE FROM complaints WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, complaintId);
            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException("Error deleting complaint", e);
        }
    }

    private ComplaintDTO mapResultSetToComplaint(ResultSet rs) throws SQLException {
        ComplaintDTO complaint = new ComplaintDTO();
        complaint.setComplaintId(rs.getString("complaint_id"));
        complaint.setTitle(rs.getString("title"));
        complaint.setDescription(rs.getString("description"));
        complaint.setDepartment(rs.getString("department"));
        complaint.setPriority(rs.getString("priority"));
        complaint.setStatus(rs.getString("status"));
        complaint.setSubmittedBy(rs.getString("submitted_by"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            complaint.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            complaint.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return complaint;
    }
}
