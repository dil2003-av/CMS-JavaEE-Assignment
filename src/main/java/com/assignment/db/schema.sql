create database complaint_db;

use complaint_db;

use complaint_db;

CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       email VARCHAR(150) NOT NULL,
                       role VARCHAR(20) NOT NULL
);

select * from users;

CREATE TABLE complaints (
                            complaint_id VARCHAR(50) PRIMARY KEY,
                            title VARCHAR(255) NOT NULL,
                            description TEXT NOT NULL,
                            department VARCHAR(100) NOT NULL,
                            priority VARCHAR(20) NOT NULL,
                            status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
                            submitted_by VARCHAR(100) NOT NULL,
                            submitted_by_name VARCHAR(100),
                            assigned_to VARCHAR(100),
                            assigned_to_name VARCHAR(100),
                            admin_remarks TEXT,
                            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                            updated_at DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
);

select * from complaints;