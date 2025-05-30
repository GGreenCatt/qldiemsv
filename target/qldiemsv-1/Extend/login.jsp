<%-- 
    Document   : login
    Created on : Apr 2, 2025, 11:29:13 AM
    Author     : Laptop K1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>

<%
    // Lấy thông tin username và password từ form POST
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Kết nối đến cơ sở dữ liệu
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        // Kết nối cơ sở dữ liệu
        conn = DatabaseConnection.getConnection();  // Giả sử DatabaseConnection là lớp bạn đã tạo để kết nối cơ sở dữ liệu

        // Câu truy vấn SQL
        String sql = "SELECT * FROM taikhoan WHERE username=? AND password=?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);

        // Thực hiện truy vấn
        rs = stmt.executeQuery();

        // Kiểm tra kết quả truy vấn
        if (rs.next()) {
            String ten = rs.getString("TEN");
            String role = rs.getString("ROLE");
            String ID = username.substring(username.length() - 5);
            
            // Kiểm tra vai trò của người dùng và lưu vào session
            if ("3".equals(role)) {
                session.setAttribute("username", ten + " - Sinh Viên");
                session.setAttribute("ID", ID);
                session.setAttribute("ROLE", "SV");
                response.sendRedirect("../page/SV/index.jsp");
            } else if ("2".equals(role)) {
                session.setAttribute("username", ten + " - Giảng viên");
                session.setAttribute("ID", ID);
                session.setAttribute("ROLE", "GV");
                response.sendRedirect("../page/GV/index.jsp");
            } else if ("1".equals(role)) {
                session.setAttribute("username", ten + " - ADMIN");
                session.setAttribute("ID", ID);
                session.setAttribute("ROLE", "AD");
                response.sendRedirect("../page/AD/index.jsp");
            } else {
                out.println("Username or password incorrect");
            }
        } else {
            out.println("Username or password incorrect");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while processing your request.");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
