<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thông tin sinh viên</title>
</head>
<body>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
        String MASV = request.getParameter("masv");
        String TENSV = request.getParameter("tensv");
        String DIACHI = request.getParameter("diachi");
        String SDT = request.getParameter("sdt");
        String GMAIL = request.getParameter("email");
        String GIOITINH = request.getParameter("gioitinh");
        String NGAYSINH = request.getParameter("ngaysinh");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO sinhvien (MA_SV, TEN_SV, SDT, DIACHI, GIOITINH, NGAYSINH, GMAIL) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, MASV);
            pstmt.setString(2, TENSV);
            pstmt.setString(3, SDT);
            pstmt.setString(4, DIACHI);
            pstmt.setString(5, GIOITINH);
            pstmt.setString(6, NGAYSINH);
            pstmt.setString(7, GMAIL);

            int row = pstmt.executeUpdate();
            if (row > 0) {
                message = "Thành công";
            } else {
                message = "Thất bại";
            }
        } catch (Exception e) {
            message = "Lỗi: " + e.getMessage();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-3" style="height: 650px;">
                <h5>Thông tin sinh viên</h5><hr>
                <div class="contaner">

                    <div class="col-right">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Họ và Tên</p>
                                <input type="text" name="tensv" placeholder="Họ tên..." required />
                            </div>
                            <div class="mb-3">
                                <p>Ngày sinh <span style="margin-left: 53%">Giới tính</span></p>
                                <input style="width: 65%" type="date" name="ngaysinh" placeholder="Ngày sinh..." />
                                <input style="width: 30%; margin-left: 4%" type="text" name="gioitinh" placeholder="Giới tính..." />
                            </div>
                            <div class="mb-3">
                                <p>Email</p>
                                <input type="text" name="email" placeholder="Gmail..." />
                            </div>
                            <div class="mb-3">
                                <p>Địa chỉ</p>
                                <textarea name="diachi" cols="30" rows="10"></textarea>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Số điện thoại</p>
                                <input type="text" name="sdt" placeholder="Số điện thoại..." />
                            </div>
                            <div class="mb-3">
                                <p>Mã sinh viên</p>
                                <input type="text" name="masv" placeholder="Mã sinh viên..." required />
                            </div>
                            <div class="mb-3">
                                <p>Mã lớp</p>
                                <input type="text" name="malop" placeholder="Mã lớp..." required />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button" style="margin-left: 4px">
                    <button type="submit" name="save">Lưu</button>
                </div>
            </div>
        </form>
        <% if (!message.isEmpty()) { %>
            <script>alert("<%= message %>");</script>
        <% } %>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>

</body>
</html>
