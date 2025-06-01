<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chi tiết phản hồi</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("ID không hợp lệ.");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String TEN_PH = "";
    String TEN_SV = "";
    String TINNHAN = "";
    String message = "";

    try {
        conn = DatabaseConnection.getConnection();

        // Lấy thông tin phản hồi theo id
        String sqlSelect = "SELECT phanhoi.*, sinhvien.TEN_SV FROM phanhoi " +
                           "INNER JOIN sinhvien ON sinhvien.MA_SV = phanhoi.MA_SV " +
                           "WHERE MA_PH = ?";
        pstmt = conn.prepareStatement(sqlSelect);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            TEN_PH = rs.getString("TEN_PH");
            TEN_SV = rs.getString("TEN_SV");
            TINNHAN = rs.getString("TinNhan");
        } else {
            out.println("Không tìm thấy phản hồi với ID này.");
            return;
        }
        rs.close();
        pstmt.close();

        // Xử lý khi submit form trả lời
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String TRALOI = request.getParameter("TraLoi");
            if (TRALOI != null && !TRALOI.trim().isEmpty()) {
                String sqlUpdate = "UPDATE phanhoi SET TraLoi = ? WHERE MA_PH = ?";
                pstmt = conn.prepareStatement(sqlUpdate);
                pstmt.setString(1, TRALOI);
                pstmt.setString(2, id);
                int updated = pstmt.executeUpdate();
                if (updated > 0) {
                    message = "Gửi thành công";
                } else {
                    message = "Gửi thất bại";
                }
                pstmt.close();
            } else {
                message = "Vui lòng nhập trả lời.";
            }
        }

    } catch (Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <h1 style="color: white;">Câu hỏi: <%= TEN_PH %></h1>
        </div>
        <div style="height: fit-content;" class="row-6">
            <h3 style="margin-top: 15px;">Từ sinh viên: <%= TEN_SV %></h3>
            <h5><%= TINNHAN %></h5>
        </div>
        <div class="row-6" style="height: 350px; padding: 30px;">
            <form class="traloi" action="" method="post">
                <h3>Trả Lời</h3>
                <textarea name="TraLoi" cols="30" rows="10"></textarea>
                <br/>
                <button type="submit" name="save">Gửi</button>
            </form>
            <% if (!message.isEmpty()) { %>
                <script>alert('<%= message %>');</script>
            <% } %>
        </div>
    <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
