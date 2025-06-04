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
    <title>Cập nhật lớp</title>
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
    String SISO = "";
    String MA_GV = "";
    String MA_MH = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        String selectSQL = "SELECT * FROM lop WHERE ID_LOP = ?";
        pstmt = conn.prepareStatement(selectSQL);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            MA = rs.getString("MA_LOP");
            TEN = rs.getString("TEN_LOP");
            SISO = rs.getString("SISO");
            MA_GV = rs.getString("MA_GV");
            MA_MH = rs.getString("MA_MH");
        } else {
            out.println("Không tìm thấy lớp với ID này.");
            return;
        }
        rs.close();
        pstmt.close();

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String maLOP = request.getParameter("maLOP");
            String tenLOP = request.getParameter("tenLOP");
            String siso = request.getParameter("SISO");

            String updateSQL = "UPDATE lop SET MA_LOP = ?, TEN_LOP = ?, SISO = ? WHERE ID_LOP = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, maLOP);
            pstmt.setString(2, tenLOP);
            pstmt.setString(3, siso);
            pstmt.setString(4, id);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Thành công');</script>");
                // Cập nhật lại dữ liệu hiển thị trên form
                MA = maLOP;
                TEN = tenLOP;
                SISO = siso;
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
            <div class="row-3" style="height: 420px;">
                <h5>Cập nhật thông tin</h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Tên lớp</p>
                                <input type="text" value="<%= TEN %>" name="tenLOP" />
                            </div>
                            <div class="mb-3">
                                <p>Mã lớp</p>
                                <input type="text" value="<%= MA %>" name="maLOP" />
                            </div>
                            <div class="add-button">
                                <button type="submit" name="save">Lưu</button>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Mã giảng viên</p>
                                <input type="text" value="<%= MA_GV %>" name="MA_GV" readonly />
                            </div>
                            <div class="mb-3">
                                <p>Mã môn học</p>
                                <input type="text" value="<%= MA_MH %>" name="MA_MH" readonly />
                            </div>
                            <div class="mb-3">
                                <p>Sĩ số</p>
                                <input type="text" value="<%= SISO %>" name="SISO" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
        <div class="footer" style="bottom: 0">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>                   
</div>

<script src="../../JS.JS"></script>
</body>
</html>
