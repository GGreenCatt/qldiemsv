<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<%
    // Kiểm tra session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String search = request.getParameter("search2");
    boolean hasSearch = search != null && !search.trim().isEmpty();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách giảng viên</title>
</head>
<body>

<%@include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <form class="example" method="get" style="max-width:300px">
                <input style="width: 250px;" type="text" placeholder="Họ tên..." name="search2" id="myInput">
            </form>
            <button class="Add"><a class="Add" href="Them-GV.jsp">+Thêm giảng viên</a></button>
        </div>

        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã giảng viên</th>
                <th>Tên</th>
                <th>Địa chỉ</th>
                <th>SĐT</th>
                <th>Email</th>
                <th>Chức năng</th>
            </tr>

            <%
                try {
                    conn = DatabaseConnection.getConnection();

                    String sql;
                    if (hasSearch) {
                        sql = "SELECT * FROM giangvien WHERE MA_GV LIKE ? OR TEN_GV LIKE ? OR DIACHI LIKE ? OR SDT LIKE ? OR GMAIL LIKE ?";
                        ps = conn.prepareStatement(sql);
                        for (int i = 1; i <= 5; i++) {
                            ps.setString(i, "%" + search + "%");
                        }
                    } else {
                        sql = "SELECT * FROM giangvien";
                        ps = conn.prepareStatement(sql);
                    }

                    rs = ps.executeQuery();
                    int stt = 1;
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= rs.getString("MA_GV") %></td>
                    <td><%= rs.getString("TEN_GV") %></td>
                    <td><%= rs.getString("DIACHI") %></td>
                    <td><%= rs.getString("SDT") %></td>
                    <td><%= rs.getString("GMAIL") %></td>
                    <td><a href="Update-GV.jsp?id=<%= rs.getInt("ID_GV") %>">Chỉnh sửa</a></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>Lỗi: " + e.getMessage() + "</td></tr>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
        </table>

    </div>
        <div class="footer" style="bottom: 0">
            <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>   
</div>

<script src="../../JS.JS"></script>
</body>
</html>
