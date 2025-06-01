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
    <title>Phản hồi</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String role = (String) session.getAttribute("ROLE");
    String ID = (String) session.getAttribute("ID");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        String sql = "SELECT phanhoi.*, sinhvien.TEN_SV FROM phanhoi " +
                     "INNER JOIN sinhvien ON sinhvien.MA_SV = phanhoi.MA_SV " +
                     "WHERE NguoiNhan = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, role);
        rs = pstmt.executeQuery();
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="contaner-4x">
            <%
                boolean hasData = false;
                while(rs.next()) {
                    hasData = true;
                    String maPH = rs.getString("MA_PH");
                    String tenPH = rs.getString("TEN_PH");
                    String tenSV = rs.getString("TEN_SV");
            %>
            <div class="list-box">
                <div class="class-picture"></div>
                <div class="class-content">
                    <h2 style="text-align: center;">Câu hỏi: <%= tenPH %></h2>
                    <p>Sinh Viên: <%= tenSV %></p>
                    <div style="display: flex; justify-content: space-around;">
                        <a class="button" href="traloi.jsp?id=<%= maPH %>">Chi tiết</a>
                    </div>
                </div>
            </div>
            <%
                }
                if (!hasData) {
            %>
                <p>Không có phản hồi nào.</p>
            <%
                }
            %>
        </div>
    <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<%
    } catch(Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<script src="../../JS.JS"></script>
</body>
</html>
