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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cập nhật thông tin giảng viên</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("ID không hợp lệ.");
        return;
    }

    String MA = "";
    String TEN = "";
    String DIACHI = "";
    String SDT = "";
    String GMAIL = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();
        String selectSQL = "SELECT MA_GV, TEN_GV, DIACHI, SDT, GMAIL FROM giangvien WHERE ID_GV = ?";
        pstmt = conn.prepareStatement(selectSQL);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            MA = rs.getString("MA_GV");
            TEN = rs.getString("TEN_GV");
            DIACHI = rs.getString("DIACHI");
            SDT = rs.getString("SDT");
            GMAIL = rs.getString("GMAIL");
        } else {
            out.println("Không tìm thấy giảng viên với ID này.");
            return;
        }
        rs.close();
        pstmt.close();

        String message = "";
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String maGV = request.getParameter("maGV");
            String tenGV = request.getParameter("tenGV");
            String diachi = request.getParameter("DIACHI");
            String sdt = request.getParameter("SDT");
            String email = request.getParameter("EMAIL");

            String updateSQL = "UPDATE giangvien SET MA_GV = ?, TEN_GV = ?, SDT = ?, DIACHI = ?, GMAIL = ? WHERE ID_GV = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, maGV);
            pstmt.setString(2, tenGV);
            pstmt.setString(3, sdt);
            pstmt.setString(4, diachi);
            pstmt.setString(5, email);
            pstmt.setString(6, id);

            int row = pstmt.executeUpdate();
            if (row > 0) {
                message = "Thành công";
                // Cập nhật lại dữ liệu để hiển thị
                MA = maGV;
                TEN = tenGV;
                DIACHI = diachi;
                SDT = sdt;
                GMAIL = email;
            } else {
                message = "Thất bại";
            }
            pstmt.close();

            out.println("<script>alert('" + message + "');</script>");
        }

    } catch (Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-3">
                <h5>Cập nhật thông tin</h5>
                <hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Họ và Tên</p>
                                <input type="text" name="tenGV" value="<%= TEN %>" placeholder="Nguyễn Văn A" />
                            </div>
                            <div class="mb-3">
                                <p>Email</p>
                                <input type="text" name="EMAIL" value="<%= GMAIL %>" placeholder="Hello@gmail.com" />
                            </div>
                            <div class="mb-3">
                                <p>Địa chỉ</p>
                                <input type="text" name="DIACHI" value="<%= DIACHI %>" />
                            </div>
                            <div class="add-button">
                                <button type="submit" name="save">Lưu</button>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Mã giảng viên</p>
                                <input type="text" name="maGV" value="<%= MA %>" placeholder="GV000123" />
                            </div>
                            <div class="mb-3">
                                <p>Số điện thoại</p>
                                <input type="text" name="SDT" value="<%= SDT %>" placeholder="123456789" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
