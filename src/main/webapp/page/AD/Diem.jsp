<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="controller.DatabaseConnection" %>
<%
    String username = (String) session.getAttribute("username");
    String ID = (String) session.getAttribute("ID");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách lớp</title>
</head>
<body>
<%@include file="../../Extend/sidebar-AD.jsp" %>

<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
            </form>
        </div>
        <div class="contaner-4x">
            <%
                String id = request.getParameter("id");
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DatabaseConnection.getConnection();

                    String sql = "SELECT * FROM lopcv WHERE MA_KH = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, id);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String maLop = rs.getString("MA_LOPCV");
                        String tenLop = rs.getString("TEN_LOPCV");
            %>
                        <div class='list-box'>
                            <div class='class-picture'></div>
                            <div class='class-content'>
                                <h2>Tên lớp: <%= tenLop %></h2>
                                <div style='display: flex; justify-content: space-around;'> 
                                    <a class='button' href='Xemdiem.jsp?id=<%= maLop %>'>Chi tiết</a>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } catch(Exception e) {
                    out.println("Lỗi: " + e.getMessage());
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception e) {}
                    try { if(ps != null) ps.close(); } catch(Exception e) {}
                    try { if(conn != null) conn.close(); } catch(Exception e) {}
                }
            %>
        </div>

    </div>
                <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
