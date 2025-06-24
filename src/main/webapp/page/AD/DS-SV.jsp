<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Danh sách sinh viên</title>
</head>
<body>
<%
    if(session == null || session.getAttribute("username") == null){
        response.sendRedirect("../../index.jsp");
        return;
    }
    
    String id = request.getParameter("id"); // Đây là MA_LOP của lớp hiện tại
    if(id == null || id.trim().isEmpty()){
        response.sendRedirect("DS-LOP.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String searchText = null;
    boolean isSearch = false;

    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("timkiem") != null) {
        searchText = request.getParameter("search2");
        isSearch = (searchText != null && !searchText.trim().isEmpty());
    }

    try {
        conn = DatabaseConnection.getConnection();

        if(isSearch) {
            String sqlSearch = "SELECT ID_SV, MA_SV, TEN_SV, DIACHI, SDT, GMAIL, GIOITINH, NGAYSINH FROM sinhvien " +
                               "WHERE MA_SV LIKE ? OR TEN_SV LIKE ? OR DIACHI LIKE ? OR SDT LIKE ? OR GMAIL LIKE ?";
            ps = conn.prepareStatement(sqlSearch);
            String pattern = "%" + searchText.trim() + "%";
            for(int i = 1; i <= 5; i++){
                ps.setString(i, pattern);
            }
            rs = ps.executeQuery();
        } else {
            // Lấy thông tin sinh viên thuộc lớp hiện tại
            String sql = "SELECT thamgiahoc.MA_SV, MA_LOP, sinhvien.ID_SV, sinhvien.TEN_SV, sinhvien.NGAYSINH, sinhvien.GIOITINH, sinhvien.DIACHI, sinhvien.SDT, sinhvien.GMAIL " +
                         "FROM thamgiahoc INNER JOIN sinhvien ON sinhvien.MA_SV = thamgiahoc.MA_SV WHERE MA_LOP = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, id); // id ở đây là MA_LOP
            rs = ps.executeQuery();
        }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
                <input style="width: 250px;" type="text" placeholder="Họ tên..." name="search2" id="myInput" onkeyup="myFunction()" value="<%= (searchText != null) ? searchText : "" %>">
            </form>
            <button class="Add"><a class="Add" href="Them-SV.jsp?malop=<%= id %>">+Thêm sinh viên</a></button>
        </div>

        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã SV</th>
                <th>Họ tên</th>
                <th>Ngày sinh</th>
                <th>Giới tính</th>
                <th>Quê quán</th>
                <th>SĐT</th>
                <th>GMAIL</th>
                <th></th>
            </tr>
<%
        int stt = 1;
        while(rs.next()) {
%>
            <tr>
                <td><%= stt++ %></td>
                <td><%= rs.getString("MA_SV") %></td>
                <td><%= rs.getString("TEN_SV") %></td>
                <td><%= rs.getDate("NGAYSINH") %></td>
                <td><%= rs.getString("GIOITINH") %></td>
                <td><%= rs.getString("DIACHI") %></td>
                <td><%= rs.getString("SDT") %></td>
                <td><%= rs.getString("GMAIL") %></td>
                <td><a href="Update-SV.jsp?id=<%= rs.getString("ID_SV") %>">Chỉnh sửa</a></td>
            </tr>
<%
        }
    } catch(Exception e){
        out.println("Lỗi truy vấn dữ liệu: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignored) {}
        if(ps != null) try { ps.close(); } catch(Exception ignored) {}
        if(conn != null) try { conn.close(); } catch(Exception ignored) {}
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