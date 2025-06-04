<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
String id = request.getParameter("id");
if (session.getAttribute("username") == null) {
    response.sendRedirect("../../index.jsp");
    return;
}
PreparedStatement ps = null;
Connection conn = null;
ResultSet result = null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DatabaseConnection.getConnection();
String sql = "SELECT diem.*, monhoc.TEN_MH, " +
    "ROUND(IF(monhoc.SOTC = 3, " +
        "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
        "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) AS TK10, " +
    "CASE " +
        "WHEN ROUND(IF(monhoc.SOTC = 3, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) >= 8.5 THEN 'A' " +
        "WHEN ROUND(IF(monhoc.SOTC = 3, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) >= 7 THEN 'B' " +
        "WHEN ROUND(IF(monhoc.SOTC = 3, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) >= 5.5 THEN 'C' " +
        "WHEN ROUND(IF(monhoc.SOTC = 3, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) >= 4 THEN 'D' " +
        "ELSE 'F' END AS TKCH, " +
    "CASE " +
        "WHEN ROUND(IF(monhoc.SOTC = 3, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.6, " +
            "CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0)) * 0.5), 1) >= 4 THEN 'Đạt' " +
        "ELSE 'Trượt' END AS KQTK " +
    "FROM diem " +
    "INNER JOIN monhoc ON diem.MA_MH = monhoc.MA_MH " +
    "WHERE MA_SV = ?";

    ps = conn.prepareStatement(sql);
    ps.setString(1, id);
    result=ps.executeQuery();
%>

<jsp:include page="../../Extend/sidebar-AD.jsp" />
<div class="main">
    <jsp:include page="../../Extend/controllpanel.jsp" />
    <div class="screen">
        <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
                <input style="width: 250px;" type="text" placeholder="Tên môn..." name="search2" id="myInput" onkeyup="myFunction()">
            </form>
        </div>
        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã môn học</th>
                <th>Tên môn học</th>
                <th>Chuyên cần</th>
                <th>Kiểm tra 1</th>
                <th>Kiểm tra 2</th>
                <th>Kiểm tra 3</th>
                <th>Thi 1</th>
                <th>Thi 2</th>
                <th>Thi 3</th>
                <th>Tổng kết(10)</th>
                <th>Tổng kết(CH)</th>
                <th>Kết quả</th>
                <th></th>
            </tr>
<%
    int stt = 1;
    while (result.next()) {
%>
            <tr>
                <td><%= stt++ %></td>
                <td><%= result.getString("MA_MH") %></td>
                <td><%= result.getString("TEN_MH") %></td>
                <td><%= result.getString("CC") %></td>
                <td><%= result.getString("KT1") %></td>
                <td><%= result.getString("KT2") %></td>
                <td><%= result.getString("KT3") %></td>
                <td><%= result.getString("THI1") %></td>
                <td><%= result.getString("THI2") %></td>
                <td><%= result.getString("THI3") %></td>
                <td><%= result.getString("TK10") %></td>
                <td><%= result.getString("TKCH") %></td>
                <td><%= result.getString("KQTK") %></td>
                <td><a href="update-DIEM.jsp?id=<%= result.getString("SBD") %>">Cập nhật</a></td>
            </tr>
<%
    }
} catch(Exception e) {
    out.println("Lỗi: " + e.getMessage());
} finally {
    if (result != null) result.close();
    if (ps != null) ps.close();
    if (conn != null) conn.close();
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
