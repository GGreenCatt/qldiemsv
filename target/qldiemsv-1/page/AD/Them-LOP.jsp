<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>

<%
    // Kiểm tra session
    String username_session = (String) session.getAttribute("username");
    if (username_session == null) {
        response.sendRedirect("../../index.jsp"); // hoặc login.jsp
        return;
    }

    Connection conn = null;
    Statement stmt_gv = null;
    ResultSet rs_gv = null;
    Statement stmt_mh = null;
    ResultSet rs_mh = null;
    PreparedStatement ps_insert = null;

    List<HashMap<String, String>> danhSachGiangVien = new ArrayList<>();
    List<HashMap<String, String>> danhSachMonHoc = new ArrayList<>();
    String message = "";

    // Lấy giá trị người dùng đã chọn trước đó (nếu form được submit lại)
    // để có thể đánh dấu 'selected' cho dropdown
    String submitted_MA_GV = request.getParameter("MA_GV");
    String submitted_MA_MH = request.getParameter("MA_MH");

    try {
        conn = DatabaseConnection.getConnection();

        // Lấy danh sách giảng viên
        String sql_gv = "SELECT MA_GV, TEN_GV FROM giangvien ORDER BY TEN_GV ASC";
        stmt_gv = conn.createStatement();
        rs_gv = stmt_gv.executeQuery(sql_gv);
        while (rs_gv.next()) {
            HashMap<String, String> gv = new HashMap<>();
            gv.put("MA_GV", rs_gv.getString("MA_GV"));
            gv.put("TEN_GV", rs_gv.getString("TEN_GV"));
            danhSachGiangVien.add(gv);
        }

        // Lấy danh sách môn học
        String sql_mh = "SELECT MA_MH, TEN_MH FROM monhoc ORDER BY TEN_MH ASC";
        stmt_mh = conn.createStatement();
        rs_mh = stmt_mh.executeQuery(sql_mh);
        while (rs_mh.next()) {
            HashMap<String, String> mh = new HashMap<>();
            mh.put("MA_MH", rs_mh.getString("MA_MH"));
            mh.put("TEN_MH", rs_mh.getString("TEN_MH"));
            danhSachMonHoc.add(mh);
        }

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
            String maLOP_param = request.getParameter("maLOP");
            String tenLOP_param = request.getParameter("tenLOP");
            // submitted_MA_MH và submitted_MA_GV đã được lấy ở trên
            String SISO_param = request.getParameter("SISO");

            if (maLOP_param == null || maLOP_param.trim().isEmpty() ||
                tenLOP_param == null || tenLOP_param.trim().isEmpty() ||
                submitted_MA_MH == null || submitted_MA_MH.trim().isEmpty() || // Sử dụng biến đã lấy ở trên
                submitted_MA_GV == null || submitted_MA_GV.trim().isEmpty() || // Sử dụng biến đã lấy ở trên
                SISO_param == null || SISO_param.trim().isEmpty()) {
                message = "Vui lòng nhập đầy đủ thông tin.";
            } else {
                String sql_insert = "INSERT INTO lop (TEN_LOP, MA_LOP, MA_MH, MA_GV, SISO) VALUES (?, ?, ?, ?, ?)";
                ps_insert = conn.prepareStatement(sql_insert);
                ps_insert.setString(1, tenLOP_param);
                ps_insert.setString(2, maLOP_param);
                ps_insert.setString(3, submitted_MA_MH); // Sử dụng biến đã lấy ở trên
                ps_insert.setString(4, submitted_MA_GV); // Sử dụng biến đã lấy ở trên
                
                try {
                    int siSoInt = Integer.parseInt(SISO_param);
                     if (siSoInt < 0) {
                         message = "Sĩ số không được là số âm.";
                    } else {
                        ps_insert.setInt(5, siSoInt);
                        int row = ps_insert.executeUpdate();
                        if (row > 0) {
                            message = "Thêm lớp học thành công!";
                            // Cân nhắc redirect hoặc làm trống các trường sau khi thành công
                            // response.sendRedirect("DS-LOP.jsp"); // Ví dụ
                        } else {
                            message = "Thêm lớp học thất bại.";
                        }
                    }
                } catch (NumberFormatException nfe) {
                    message = "Sĩ số phải là một số nguyên hợp lệ.";
                }
            }
        }
    } catch (SQLException se) {
        message = "Lỗi SQL: " + se.getMessage();
        se.printStackTrace(); 
    } catch (Exception e) {
        message = "Đã có lỗi xảy ra: " + e.getMessage();
        e.printStackTrace(); 
    } finally {
        if (rs_gv != null) try { rs_gv.close(); } catch (SQLException e) { /* ignored */ }
        if (stmt_gv != null) try { stmt_gv.close(); } catch (SQLException e) { /* ignored */ }
        if (rs_mh != null) try { rs_mh.close(); } catch (SQLException e) { /* ignored */ }
        if (stmt_mh != null) try { stmt_mh.close(); } catch (SQLException e) { /* ignored */ }
        if (ps_insert != null) try { ps_insert.close(); } catch (SQLException e) { /* ignored */ }
        if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignored */ }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm lớp học</title>
    <style>
        .mb-3 select {
            width: 100%;
            padding: 15px;
            background-color: rgba(32,32,32,255);
            border: none;
            outline: 1px solid gray;
            border-radius: 5px;
            color: white;
            box-sizing: border-box;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23dddddd%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.4-12.8z%22%2F%3E%3C%2Fsvg%3E');
            background-repeat: no-repeat;
            background-position: right .7em top 50%;
            background-size: .65em auto;
        }
    </style>
</head>
<body>
<%@include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="Them-LOP.jsp" method="post">
            <div class="row-3" style="height: auto; min-height: 420px; padding-bottom: 20px;">
                <h5>Thêm lớp học</h5>
                <hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Tên lớp</p>
                                <input type="text" name="tenLOP" required value="<%= request.getParameter("tenLOP") != null ? request.getParameter("tenLOP") : "" %>">
                            </div>
                            <div class="mb-3">
                                <p>Mã lớp</p>
                                <input type="text" name="maLOP" required value="<%= request.getParameter("maLOP") != null ? request.getParameter("maLOP") : "" %>">
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Mã giảng viên</p>
                                <select name="MA_GV" required>
                                    <option value="">-- Chọn giảng viên --</option>
                                    <% 
                                        // submitted_MA_GV đã được lấy từ request.getParameter("MA_GV") ở đầu trang
                                        for (HashMap<String, String> gv : danhSachGiangVien) {
                                            String selectedOpt = (submitted_MA_GV != null && submitted_MA_GV.equals(gv.get("MA_GV"))) ? "selected" : "";
                                    %>
                                        <option value="<%= gv.get("MA_GV") %>" <%=selectedOpt%>>
                                            <%= gv.get("MA_GV") + " - " + gv.get("TEN_GV") %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <p>Mã môn học</p>
                                <select name="MA_MH" required>
                                    <option value="">-- Chọn môn học --</option>
                                    <% 
                                        // submitted_MA_MH đã được lấy từ request.getParameter("MA_MH") ở đầu trang
                                        for (HashMap<String, String> mh : danhSachMonHoc) {
                                            String selectedOpt = (submitted_MA_MH != null && submitted_MA_MH.equals(mh.get("MA_MH"))) ? "selected" : "";
                                    %>
                                        <option value="<%= mh.get("MA_MH") %>" <%=selectedOpt%>>
                                            <%= mh.get("MA_MH") + " - " + mh.get("TEN_MH") %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <p>Sĩ số</p>
                                <input type="text" name="SISO" required min="0" value="<%= request.getParameter("SISO") != null ? request.getParameter("SISO") : "" %>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button">
                    <button type="submit" name="save">Lưu</button>
                </div>
            </div>
        </form>
        <% if (!message.isEmpty()) { %>
            <script>alert('<%=message.replace("'", "\\'") %>');</script>
        <% } %>

    </div>
        <div class="footer" style="position: relative; bottom: auto; margin-top: 20px;">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
</div>

<script src="../../JS.JS"></script>

</body>
</html>