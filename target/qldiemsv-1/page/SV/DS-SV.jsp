<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    // Kiểm tra đăng nhập
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    // Kiểm tra tham số id
    String id = request.getParameter("id");
    if (id == null || id.isEmpty()) {
        response.sendRedirect("DS-LOP.jsp");
        return;
    }

    Connection conn = null;
    Statement stmt = null;
    ResultSet result = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách sinh viên</title>
</head>
<body>

    <%@include file="../../Extend/sidebar-SV.jsp" %>

    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
        <div class="screen">
            <div class="row-2">
                <form class="example" method="post" style="max-width:300px">
                    <input style="width: 250px;" type="text" placeholder="Tên sinh viên..." name="search2" id="myInput" onkeyup="myFunction()">
                </form>
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
              try {
                  conn = DatabaseConnection.getConnection();
                  stmt = conn.createStatement();
                  String sql = "SELECT thamgiahoc.MA_SV, MA_LOP, sinhvien.* FROM thamgiahoc " +
                               "INNER JOIN sinhvien ON sinhvien.MA_SV = thamgiahoc.MA_SV " +
                               "WHERE MA_LOP = '" + id + "'";
                  result = stmt.executeQuery(sql);
                  int stt = 1;

                  while (result.next()) {
              %>
                <tr>
                    <td><%= stt++ %></td>
                    <td><%= result.getString("MA_SV") %></td>
                    <td><%= result.getString("TEN_SV") %></td>
                    <td><%= result.getString("NGAYSINH") %></td>
                    <td><%= result.getString("GIOITINH") %></td>
                    <td><%= result.getString("DIACHI") %></td>
                    <td><%= result.getString("SDT") %></td>
                    <td><%= result.getString("GMAIL") %></td>
                    <td></td>
                </tr>
              <%
                  }
              } catch (Exception e) {
                  out.println("Lỗi: " + e.getMessage());
              } finally {
                  if (result != null) result.close();
                  if (stmt != null) stmt.close();
                  if (conn != null) conn.close();
              }
              %>

            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>

</body>
</html>
