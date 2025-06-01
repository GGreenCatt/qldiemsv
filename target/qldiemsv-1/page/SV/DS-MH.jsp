<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet result = null;

    try {
        conn = DatabaseConnection.getConnection();
        stmt = conn.createStatement();
        String xuat = "SELECT * FROM monhoc";
        result = stmt.executeQuery(xuat);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách môn học</title>
</head>
<body>

    <%@include file="../../Extend/sidebar-SV.jsp" %>

    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
        <div class="screen">
            <div class="row-2">
                <form class="example" method="post" style="max-width:300px">
                    <input style="width: 250px;" type="text" placeholder="Tên môn học..." name="search2" id="myInput" onkeyup="myFunction()">
                </form>
            </div>

            <table class="list" id="myTable">
              <tr>
                <th>STT</th>
                <th>Mã môn học</th>
                <th>Tên môn học</th>
                <th></th>
              </tr>

              <%
                  int stt = 1;
                  while(result.next()) {
              %>
                  <tr>
                      <td><%= stt++ %></td>
                      <td><%= result.getString("MA_MH") %></td>
                      <td><%= result.getString("TEN_MH") %></td>
                      <td></td>
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

    <script src="../../JS.JS"></script>

</body>
</html>

<%
    } catch(Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (result != null) result.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
