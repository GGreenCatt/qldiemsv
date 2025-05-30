<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %><%
    // Kiểm tra session (giả định dùng session kiểu Java)
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp"); // hoặc login.jsp theo bạn
        return;
    }

    // Kết nối database
    Connection conn = DatabaseConnection.getConnection();

    String message = "";
    if (request.getParameter("save") != null) {
        String maLOP = request.getParameter("maLOP");
        String tenLOP = request.getParameter("tenLOP");
        String MA_MH = request.getParameter("MA_MH");
        String MA_GV = request.getParameter("MA_GV");
        String SISO = request.getParameter("SISO");

        String sql = "INSERT INTO lop (TEN_LOP, MA_LOP, MA_MH, MA_GV, SISO) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tenLOP);
            ps.setString(2, maLOP);
            ps.setString(3, MA_MH);
            ps.setString(4, MA_GV);
            ps.setString(5, SISO);

            int row = ps.executeUpdate();
            if (row > 0) {
                message = "Thành công";
            } else {
                message = "Thất bại";
            }
        } catch(Exception e) {
            message = "Lỗi: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm lớp học</title>
</head>
<body>
<%@include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-3" style="height: 420px;">
                <h5>Thêm lớp học</h5>
                <hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Tên lớp</p>
                                <input type="text" name="tenLOP" required>
                            </div>
                            <div class="mb-3">
                                <p>Mã lớp</p>
                                <input type="text" name="maLOP" required>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Mã giảng viên</p>
                                <input type="text" name="MA_GV" required>
                            </div>
                            <div class="mb-3">
                                <p>Mã môn học</p>
                                <input type="text" name="MA_MH" required>
                            </div>
                            <div class="mb-3">
                                <p>Sĩ số</p>
                                <input type="text" name="SISO">
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
            <script>alert("<%=message%>");</script>
        <% } %>
    </div>
</div>

<script src="../../JS.JS"></script>

</body>
</html>
