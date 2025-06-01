<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sinh viên lớp chuyên đề</title>
</head>
<body>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendRedirect("Nhap_Diem.jsp");
        return;
    }

    int id = Integer.parseInt(idStr);

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();
        String sql = "SELECT sv.MA_SV, sv.TEN_SV, sv.GIOITINH " +
                     "FROM sinhvien_lopcv slcv " +
                     "JOIN sinhvien sv ON sv.MA_SV = slcv.MA_SV " +
                     "WHERE slcv.MA_LOPCV = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();
%>

<!-- Sidebar và Control Panel -->
<%@include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>

    <div class="screen">
        <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
                <input style="width: 250px;" type="text" placeholder="Họ tên..." name="search2" id="myInput" onkeyup="myFunction()">
            </form>
        </div>

        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã SV</th>
                <th>Họ tên</th>
                <th>Giới tính</th>
                <th>Hành động</th>
            </tr>

            <%
                int stt = 1;
                while (rs.next()) {
            %>
            <tr>
                <td><%= stt++ %></td>
                <td><%= rs.getString("MA_SV") %></td>
                <td><%= rs.getString("TEN_SV") %></td>
                <td><%= rs.getString("GIOITINH") %></td>
                <td><a href="Them-DIEM.jsp?id=<%= rs.getString("MA_SV") %>">Nhập điểm</a></td>
            </tr>
            <%
                }
            %>
        </table>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<%
    } catch (Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (ps != null) try { ps.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>

<script src="../../JS.JS"></script>
</body>
</html>
