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
    <title>Cập nhật điểm sinh viên</title>
</head>
<body>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect("Diem.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String MASV = "";
    String TEN_SV = "";
    String MA_MH = "";
    String TEN_MH = "";
    String CC = "";
    String KT1 = "";
    String KT2 = "";
    String KT3 = "";
    String THI1 = "";
    String THI2 = "";
    String THI3 = "";

    String message = "";

    try {
        conn = DatabaseConnection.getConnection();

        // Lấy dữ liệu điểm theo SBD = id
        String sqlSelect = "SELECT diem.*, sinhvien.TEN_SV, monhoc.TEN_MH FROM diem " +
                           "INNER JOIN sinhvien ON sinhvien.MA_SV = diem.MA_SV " +
                           "INNER JOIN monhoc ON monhoc.MA_MH = diem.MA_MH " +
                           "WHERE SBD = ?";
        pstmt = conn.prepareStatement(sqlSelect);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            MASV = rs.getString("MA_SV");
            TEN_SV = rs.getString("TEN_SV");
            MA_MH = rs.getString("MA_MH");
            TEN_MH = rs.getString("TEN_MH");
            CC = rs.getString("CC");
            KT1 = rs.getString("KT1");
            KT2 = rs.getString("KT2");
            KT3 = rs.getString("KT3");
            THI1 = rs.getString("THI1");
            THI2 = rs.getString("THI2");
            THI3 = rs.getString("THI3");
        } else {
            out.println("Không tìm thấy điểm với SBD này.");
            return;
        }
        rs.close();
        pstmt.close();

        // Xử lý cập nhật khi submit form
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            CC = request.getParameter("CC");
            KT1 = request.getParameter("KT1");
            KT2 = request.getParameter("KT2");
            KT3 = request.getParameter("KT3");
            THI1 = request.getParameter("THI1");
            THI2 = request.getParameter("THI2");
            THI3 = request.getParameter("THI3");

            String sqlUpdate = "UPDATE diem SET CC=?, KT1=?, KT2=?, KT3=?, THI1=?, THI2=?, THI3=? WHERE MA_SV=? AND MA_MH=?";
            pstmt = conn.prepareStatement(sqlUpdate);
            pstmt.setString(1, CC);
            pstmt.setString(2, KT1);
            pstmt.setString(3, KT2);
            pstmt.setString(4, KT3);
            pstmt.setString(5, THI1);
            pstmt.setString(6, THI2);
            pstmt.setString(7, THI3);
            pstmt.setString(8, MASV);
            pstmt.setString(9, MA_MH);

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                message = "Cập nhật thành công";
            } else {
                message = "Cập nhật thất bại";
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
            <div class="row-3" style="height: 570px;">
                <h5>Cập nhật điểm sinh viên: <%= TEN_SV %></h5>
                <h5>Môn học: <%= TEN_MH %></h5>
                <hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Chuyên cần</p>
                                <input type="text" name="CC" value="<%= CC %>" />
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 1</p>
                                <input type="text" name="KT1" value="<%= KT1 %>" />
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 2</p>
                                <input type="text" name="KT2" value="<%= KT2 %>" />
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 3</p>
                                <input type="text" name="KT3" value="<%= KT3 %>" />
                            </div>
                        </div>
                        <div class="col-1" style="height: 500px;">
                            <div class="mb-3">
                                <p>Thi 1</p>
                                <input type="text" name="THI1" value="<%= THI1 %>" />
                            </div>
                            <div class="mb-3">
                                <p>Thi 2</p>
                                <input type="text" name="THI2" value="<%= THI2 %>" />
                            </div>
                            <div class="mb-3">
                                <p>Thi 3</p>
                                <input type="text" name="THI3" value="<%= THI3 %>" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="add-button">
                <button type="submit" name="save">Lưu</button>
            </div>
        </form>
    <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<% if (!message.isEmpty()) { %>
<script>
    alert('<%= message %>');
</script>
<% } %>

<script src="../../JS.JS"></script>
</body>
</html>
