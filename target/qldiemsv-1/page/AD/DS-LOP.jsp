<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<%
    // Kiểm tra đăng nhập
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách lớp học</title>
</head>
<body>
<%@include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <button class="Add"><a class="Add" href="Them-LOP.jsp">+Thêm lớp học</a></button>
        </div>
        <div class="contaner-4x">
        <%
            try {
                conn = DatabaseConnection.getConnection();

                String sql = "SELECT LOP.*, giangvien.TEN_GV, monhoc.TEN_MH FROM LOP " +
                             "INNER JOIN giangvien ON LOP.MA_GV = giangvien.MA_GV " +
                             "INNER JOIN monhoc ON LOP.MA_MH = monhoc.MA_MH";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
            <div class="list-box">
                <div class="class-picture"></div>
                <div class="class-content">
                    <h2>Tên lớp: <%= rs.getString("TEN_LOP") %></h2>
                    <p>Mã lớp: <%= rs.getString("MA_LOP") %></p>
                    <p>Sĩ số: <%= rs.getInt("SISO") %> sinh viên</p>
                    <p>Giảng viên: <%= rs.getString("TEN_GV") %></p>
                    <div style="display: flex; justify-content: space-around;"> 
                        <a class="button" href="DS-SV.jsp?id=<%= rs.getString("MA_LOP") %>">Chi tiết</a>
                        <a class="button" href="Update-LOP.jsp?id=<%= rs.getInt("ID_LOP") %>">Chỉnh sửa</a>
                    </div>
                </div>
            </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Lỗi: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (ps != null) ps.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
        </div>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
