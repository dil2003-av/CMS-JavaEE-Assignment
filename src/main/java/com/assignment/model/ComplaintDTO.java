package com.assignment.model;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ComplaintDTO {
    private String complaintId;
    private String title;
    private String description;
    private String department;
    private String priority;
    private String status;
    private String submittedBy;
    private String submittedByName;
    private String assignedTo;
    private String assignedToName;
    private String adminRemarks;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
