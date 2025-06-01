<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
%>

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

<%@include file="../../Extend/sidebar-SV.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
                <input style="width: 250px;" type="text" placeholder="Tên môn..." name="search2" id="myInput" onkeyup="myFunction()">
            </form>
        </div>

        <table class="list" id="myTable">
            <tr>
                <th>STT</th>
                <th>Mã môn</th>
                <th>Tên môn</th>
                <th>CC</th>
                <th>KT1</th>
                <th>KT2</th>
                <th>KT3</th>
                <th>Thi lần 1</th>
                <th>Thi lần 2</th>
                <th>Thi lần 3</th>
                <th>TK(10)</th>
                <th>TK(CH)</th>
                <th>KQ</th>
            </tr>

            <%
                String ID = (String) session.getAttribute("ID");
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    conn = DatabaseConnection.getConnection();
                    stmt = conn.createStatement();

                    String query = "SELECT diem.*, monhoc.TEN_MH, " +
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
                        "WHERE MA_SV = '" + ID + "'";

                    rs = stmt.executeQuery(query);
                    int stt = 1;
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= rs.getString("MA_MH") %></td>
                    <td><%= rs.getString("TEN_MH") %></td>
                    <td><%= rs.getString("CC") %></td>
                    <td><%= rs.getString("KT1") %></td>
                    <td><%= rs.getString("KT2") %></td>
                    <td><%= rs.getString("KT3") %></td>
                    <td><%= rs.getString("THI1") %></td>
                    <td><%= rs.getString("THI2") %></td>
                    <td><%= rs.getString("THI3") %></td>
                    <td><%= rs.getString("TK10") %></td>
                    <td><%= rs.getString("TKCH") %></td>
                    <td><%= rs.getString("KQTK") %></td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Lỗi: " + e.getMessage());
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
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
