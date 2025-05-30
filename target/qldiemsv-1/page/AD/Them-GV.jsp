<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    if(session.getAttribute("username") == null){
        response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = "";

    try {
        conn = DatabaseConnection.getConnection();

        if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null){
            String maGV = request.getParameter("maGV");
            String tenGV = request.getParameter("tenGV");
            String DIACHI = request.getParameter("DIACHI");
            String SDT = request.getParameter("SDT");
            String GMAIL = request.getParameter("EMAIL");

            String sql = "INSERT INTO giangvien (MA_GV, TEN_GV, DIACHI, SDT, GMAIL) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, maGV);
            pstmt.setString(2, tenGV);
            pstmt.setString(3, DIACHI);
            pstmt.setString(4, SDT);
            pstmt.setString(5, GMAIL);

            int row = pstmt.executeUpdate();
            message = (row > 0) ? "Thành công" : "Thất bại";
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "Lỗi kết nối hoặc truy vấn!";
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch(Exception ignore) {}
        if(conn != null) try { conn.close(); } catch(Exception ignore) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thêm giảng viên</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<jsp:include page="../../Extend/sidebar-AD.jsp" />
<div class="main">
    <jsp:include page="../../Extend/controllpanel.jsp" />
    <div class="screen">
        <form action="" method="post">
            <div class="row-3" style="height: 600px;">
                <h5>Thông tin giảng viên</h5>
                <hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Họ và Tên</p>
                                <input type="text" name="tenGV" placeholder="Họ tên..." required>
                            </div>
                            <div class="mb-3">
                                <p>Email</p>
                                <input type="text" name="EMAIL" placeholder="Gmail...">
                            </div>
                            <div class="mb-3">
                                <p>Địa chỉ</p>
                                <textarea name="DIACHI" cols="30" rows="10"></textarea>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Mã giảng viên</p>
                                <input type="text" name="maGV" placeholder="Mã giảng viên..." required>
                            </div>
                            <div class="mb-3">
                                <p>Số điện thoại</p>
                                <input type="text" name="SDT" placeholder="Số điện thoại...">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button">
                    <button type="submit" name="save">Lưu</button>
                </div>
                <% if (!message.isEmpty()) { %>
                    <script>alert("<%= message %>");</script>
                <% } %>
            </div>
        </form>
    </div>
</div>
<script src="../../JS.JS"></script>
</body>
</html>
