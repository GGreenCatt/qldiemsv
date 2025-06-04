<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thông tin sinh viên</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        out.println("ID sinh viên không hợp lệ.");
        return;
    }

    String MA_SV = "";
    String TEN_SV = "";
    String NGAY_SINH = "";
    String GIOITINH = "";
    String DIACHI = "";
    String SDT = "";
    String GMAIL = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        // Lấy dữ liệu sinh viên theo ID
        String selectSQL = "SELECT MA_SV, TEN_SV, NGAYSINH, GIOITINH, DIACHI, SDT, GMAIL FROM sinhvien WHERE ID_SV = ?";
        pstmt = conn.prepareStatement(selectSQL);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            MA_SV = rs.getString("MA_SV");
            TEN_SV = rs.getString("TEN_SV");
            NGAY_SINH = rs.getString("NGAYSINH");
            GIOITINH = rs.getString("GIOITINH");
            DIACHI = rs.getString("DIACHI");
            SDT = rs.getString("SDT");
            GMAIL = rs.getString("GMAIL");
        } else {
            out.println("Không tìm thấy sinh viên với ID này.");
            return;
        }
        rs.close();
        pstmt.close();

        // Xử lý cập nhật khi nhấn nút Lưu
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String masv = request.getParameter("masv");
            String tensv = request.getParameter("tensv");
            String diachi = request.getParameter("diachi");
            String sdt = request.getParameter("sdt");
            String gmail = request.getParameter("email");
            String gioitinh = request.getParameter("gioitinh");
            String ngaysinh = request.getParameter("ngaysinh");

            String updateSQL = "UPDATE sinhvien SET MA_SV = ?, TEN_SV = ?, SDT = ?, DIACHI = ?, GIOITINH = ?, NGAYSINH = ?, GMAIL = ? WHERE ID_SV = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, masv);
            pstmt.setString(2, tensv);
            pstmt.setString(3, sdt);
            pstmt.setString(4, diachi);
            pstmt.setString(5, gioitinh);
            pstmt.setString(6, ngaysinh);
            pstmt.setString(7, gmail);
            pstmt.setString(8, id);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Thành công');</script>");
                // Cập nhật lại các biến hiển thị
                MA_SV = masv;
                TEN_SV = tensv;
                DIACHI = diachi;
                SDT = sdt;
                GMAIL = gmail;
                GIOITINH = gioitinh;
                NGAY_SINH = ngaysinh;
            } else {
                out.println("<script>alert('Thất bại');</script>");
            }
            pstmt.close();
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
                <h5>Thông tin sinh viên</h5><hr>
                <div class="contaner">
                    <div class="col-right">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Họ và Tên</p>
                                <input type="text" value="<%= TEN_SV %>" name="tensv" placeholder="Nguyễn Văn A" />
                            </div>
                            <div class="mb-3">
                                <p>Ngày sinh &amp; Giới tính</p>
                                <input style="width: 65%" type="date" name="ngaysinh" value="<%= NGAY_SINH %>" placeholder="21/06/2004" />
                                <input style="width: 30%; margin-left: 4%;" type="text" name="gioitinh" value="<%= GIOITINH %>" placeholder="" />
                            </div>
                            <div class="mb-3">
                                <p>Email</p>
                                <input type="text" name="email" value="<%= GMAIL %>" placeholder="Hello@gmail.com" />
                            </div>
                            <div class="mb-3">
                                <p>Địa chỉ</p>
                                <input type="text" name="diachi" value="<%= DIACHI %>" />
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Số điện thoại</p>
                                <input type="text" name="sdt" value="<%= SDT %>" placeholder="123456789" />
                            </div>
                            <div class="mb-3">
                                <p>Mã sinh viên</p>
                                <input type="text" name="masv" value="<%= MA_SV %>" placeholder="000123" />
                            </div>
                            <div class="add-button">
                                <button type="submit" name="save">Lưu</button>
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
