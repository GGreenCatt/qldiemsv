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
    <title>Cập nhật môn học</title>
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

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();

        String selectSQL = "SELECT MA_MH, TEN_MH FROM monhoc WHERE ID_MH = ?";
        pstmt = conn.prepareStatement(selectSQL);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            MA = rs.getString("MA_MH");
            TEN = rs.getString("TEN_MH");
        } else {
            out.println("Không tìm thấy môn học với ID này.");
            return;
        }
        rs.close();
        pstmt.close();

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String maMH = request.getParameter("maMH");
            String tenMH = request.getParameter("tenMH");

            String updateSQL = "UPDATE monhoc SET MA_MH = ?, TEN_MH = ? WHERE ID_MH = ?";
            pstmt = conn.prepareStatement(updateSQL);
            pstmt.setString(1, maMH);
            pstmt.setString(2, tenMH);
            pstmt.setString(3, id);

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Thành công');</script>");
                MA = maMH;
                TEN = tenMH;
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
            <div class="row-3" style="height: 350px;">
                <h5>Cập nhật thông tin</h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Tên môn</p>
                                <input type="text" value="<%= TEN %>" name="tenMH" />
                            </div>
                            <div class="mb-3">
                                <p>Mã môn</p>
                                <input type="text" value="<%= MA %>" name="maMH" />
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
