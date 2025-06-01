<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
</head>
<body>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Object ID = session.getAttribute("ID");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("<h3>Thiếu tham số id!</h3>");
        return;
    }

    try {
        conn = controller.DatabaseConnection.getConnection();

        String sql = "SELECT * FROM lopcv WHERE MA_KH = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, id);  // Sử dụng String thay vì int
        rs = ps.executeQuery();
%>
<!-- Phần hiển thị HTML như cũ -->
<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="contaner-4x">
            <%
                while (rs.next()) {
            %>
            <div class="list-box">
                <div class="class-picture"></div>
                <div class="class-content">
                    <h2>Tên lớp: <%= rs.getString("TEN_LOPCV") %></h2>
                    <div style="display: flex; justify-content: space-around;">
                        <a class="button" href="DS-ND.jsp?id=<%= rs.getString("MA_LOPCV") %>">Chi tiết</a>
                    </div>
                </div>
            </div>
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
        out.println("Lỗi truy vấn: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignore) {}
        if(ps != null) try { ps.close(); } catch(Exception ignore) {}
        if(conn != null) try { conn.close(); } catch(Exception ignore) {}
    }
%>
<script src="../../JS.JS"></script>

</body>
</html>
