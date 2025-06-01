<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("Diem.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sinh viên</title>
</head>
<body>

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
                <th>Số điện thoại</th>
                <th>Giới tính</th>
                <th>Gmail</th>
                <th></th>
            </tr>
            <%
                try {
                    conn = DatabaseConnection.getConnection(); // hoặc Class.forName & DriverManager nếu bạn không dùng class controller
                    String sql = "SELECT sinhvien_lopcv.*, sinhvien.* FROM sinhvien_lopcv " +
                                 "INNER JOIN sinhvien ON sinhvien.MA_SV = sinhvien_lopcv.MA_SV " +
                                 "WHERE MA_LOPCV = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, id);
                    rs = ps.executeQuery();
                    int stt = 1;
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= stt++ %></td>
                            <td><%= rs.getString("MA_SV") %></td>
                            <td><%= rs.getString("TEN_SV") %></td>
                            <td><%= rs.getString("SDT") %></td>
                            <td><%= rs.getString("GIOITINH") %></td>
                            <td><%= rs.getString("GMAIL") %></td>
                            <td><a href="Diem-SV.jsp?id=<%= rs.getString("MA_SV") %>">Xem điểm</a></td>
                        </tr>
            <%
                    }
                } catch(Exception e) {
                    out.println("<tr><td colspan='7'>Lỗi: " + e.getMessage() + "</td></tr>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
        </table>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
