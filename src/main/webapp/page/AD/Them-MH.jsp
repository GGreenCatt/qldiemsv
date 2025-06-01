<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm môn học</title>
</head>
<body>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    // Kết nối database, giả sử bạn có class DatabaseConnection trong package controller
    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = "";

    try {
        // Lấy kết nối từ class DatabaseConnection
        conn = controller.DatabaseConnection.getConnection();

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String tenMH = request.getParameter("tenMH");
            String maMH = request.getParameter("maMH");

            if (tenMH != null && maMH != null) {
                String sql = "INSERT INTO MONHOC (TEN_MH, MA_MH) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, tenMH);
                pstmt.setString(2, maMH);
                int row = pstmt.executeUpdate();

                if (row > 0) {
                    message = "Thành công";
                } else {
                    message = "Thất bại";
                }
            }
        }
    } catch(Exception e) {
        message = "Lỗi: " + e.getMessage();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-3" style="height: 350px;">
                <h5>Thêm môn học</h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Tên môn</p>
                                <input type="text" name="tenMH" required>
                            </div>
                            <div class="mb-3">
                                <p>Mã môn</p>
                                <input type="text" name="maMH" required>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button">
                    <button type="submit" name="save">Lưu</button>
                </div>
                <br>
                <% if (!message.isEmpty()) { %>
                    <script>alert("<%= message %>");</script>
                <% } %>
            </div>
        </form>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>

</body>
</html>
