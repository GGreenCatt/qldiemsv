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
    String search = request.getParameter("search2");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Danh sách môn học</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%@include file="../../Extend/sidebar-AD.jsp" %>

<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>

    <div class="screen">
        <div class="row-2">
            <form class="example" method="get" style="max-width:300px;">
                <input style="width: 250px;" type="text" placeholder="Tìm tên môn..." name="search2" value="<%= (search != null) ? search : "" %>">
            </form>

            <button class="Add"><a class="Add" href="Them-MH.jsp">+Thêm môn học</a></button>
        </div>

        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã môn học</th>
                <th>Tên môn học</th>
                <th>Hành động</th>
            </tr>

            <%
                try {
                    conn = DatabaseConnection.getConnection();
                    String sql = "SELECT ID_MH, MA_MH, TEN_MH FROM monhoc";

                    if (search != null && !search.trim().isEmpty()) {
                        sql += " WHERE MA_MH LIKE ? OR TEN_MH LIKE ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, "%" + search + "%");
                        ps.setString(2, "%" + search + "%");
                    } else {
                        ps = conn.prepareStatement(sql);
                    }

                    rs = ps.executeQuery();
                    int stt = 1;
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= rs.getString("MA_MH") %></td>
                    <td><%= rs.getString("TEN_MH") %></td>
                    <td><a href="Update-MH.jsp?id=<%= rs.getInt("ID_MH") %>">Chỉnh sửa</a></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Lỗi: " + e.getMessage() + "</td></tr>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (conn != null) conn.close(); } catch (Exception e) {}
                }
            %>
        </table>

    </div>
        <div class="footer" style="bottom:0">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>  
</div>

<script src="../../JS.JS"></script>
</body>
</html>
