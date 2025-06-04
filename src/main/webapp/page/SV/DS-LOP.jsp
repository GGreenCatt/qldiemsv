<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String ID = session.getAttribute("ID").toString();

    Connection conn = null;
    Statement stmt = null;
    ResultSet result = null;

    try {
        conn = DatabaseConnection.getConnection();
        stmt = conn.createStatement();

        // Nếu MA_SV là chuỗi, phải có dấu nháy đơn trong SQL
        String sql = "SELECT lop.*, thamgiahoc.* FROM lop " +
                     "INNER JOIN thamgiahoc ON thamgiahoc.MA_LOP = lop.MA_LOP " +
                     "WHERE MA_SV = '" + ID + "'";

        result = stmt.executeQuery(sql);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách lớp</title>
</head>
<body>
    <%@include file="../../Extend/sidebar-SV.jsp" %>

    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
        <div class="screen">
            <div class="row-2"></div>

            <div class="contaner-4x">
                <%
                    while (result.next()) {
                %>
                    <div class="list-box">
                        <div class="class-picture"></div>
                        <div class="class-content">
                            <h2>Tên lớp: <%= result.getString("TEN_LOP") %></h2>
                            <p>Mã lớp: <%= result.getString("MA_LOP") %></p>
                            <p>Sĩ số: <%= result.getString("SISO") %> sinh viên</p>
                            <a class="button" href="DS-SV.jsp?id=<%= result.getString("MA_LOP") %>">Chi tiết</a>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
            <div class="footer" style="bottom: 0">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>   
    </div>

    <script src="../../JS.JS"></script>
</body>
</html>

<%
    } catch (Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (result != null) result.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
