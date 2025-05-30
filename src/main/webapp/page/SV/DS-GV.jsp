<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username") == null) {
    response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet result = null;
        conn = DatabaseConnection.getConnection();
        stmt = conn.createStatement();
        result = stmt.executeQuery("SELECT * FROM giangvien");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách giảng viên</title>
</head>
<body>
    <%@include file="../../Extend/sidebar-SV.jsp" %>

    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
        <div class="screen">
            <div class="row-2">
                <form class="example" method="post" style="max-width:300px">
                    <input style="width: 250px;" type="text" placeholder="Tên giảng viên..." name="search2" id="myInput" onkeyup="myFunction()">
                </form>
            </div>

            <table class="list" id="myTable">
                <tr>
                    <th>STT</th>
                    <th>Mã giảng viên</th>
                    <th>Tên</th>
                    <th>Địa chỉ</th>
                    <th>SĐT</th>
                    <th>Email</th>
                    <th></th>
                </tr>
                <%
                    int stt = 1;
                    if (result != null) {
                        while (result.next()) {
                %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= result.getString("MA_GV") %></td>
                    <td><%= result.getString("TEN_GV") %></td>
                    <td><%= result.getString("DIACHI") %></td>
                    <td><%= result.getString("SDT") %></td>
                    <td><%= result.getString("GMAIL") %></td>
                    <td></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>
</body>
</html>
<%
    if (result != null) result.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
%>
