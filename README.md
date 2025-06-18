# Complaint Management System (CMS)

## 📌 Project Overview

The Complaint Management System (CMS) is a web-based full-stack Java application designed for internal use by the Municipal IT Division. It facilitates the submission, tracking, and resolution of complaints raised by employees and managed by administrators. The system adheres strictly to synchronous form-based interaction using JSP and Servlets with the Jakarta EE platform, following the MVC architectural pattern.

---

## ⚙️ Technologies Used

- **Frontend**: JSP, HTML, CSS, JavaScript (for validation only)
- **Backend**: Jakarta EE (Servlets)
- **Database**: MySQL
- **Connection Pooling**: Apache Commons DBCP
- **Server**: Apache Tomcat

---

## 🧠 Key Features

### 🧑 Employee Role
- Register and log in
- Submit new complaints
- View personal submitted complaints
- Edit/delete complaints (if status is *Pending*)

### 👨‍💼 Admin Role
- Log in as Admin
- View all submitted complaints
- Update complaint status and add remarks
- Delete any complaint

---

## 📐 Architecture

This application follows the **Model-View-Controller (MVC)** pattern:

- **Model**: JavaBeans (DTO classes) + DAO classes for database operations
- **View**: JSP pages
- **Controller**: Servlets handling HTTP requests/responses

---

## 🚀 Setup and Configuration

### 🖥️ Prerequisites

- JDK 17+
- Apache Tomcat 10+
- MySQL 8+
- Maven or IntelliJ IDEA (or Eclipse)
- Internet connection to load jQuery CDN (optional)

### 🔧 MySQL Configuration

1. Create a database named `cms_db`
2. Execute the provided SQL script (`schema.sql`) to create required tables (`users`, `complaints`)

### 🗃️ Database Connection Pooling

The app uses **Apache Commons DBCP**. Configure connection pool in a utility class, e.g., `DBCPDataSource.java`.

```java
// Sample
BasicDataSource ds = new BasicDataSource();
ds.setUrl("jdbc:mysql://localhost:3306/cms_db");
ds.setUsername("root");
ds.setPassword("your_password");
