<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
    if(session == null || session.getAttribute("username") == null){
        response.sendRedirect("../../index.jsp");
        return;
    }
    String role = (String) session.getAttribute("ROLE");
    String idStr = (String) session.getAttribute("ID");
    int ID = Integer.parseInt(idStr);

    Connection conn = null;
    Statement stmt = null;
    ResultSet result = null;
    ResultSet result2 = null;

    try {
        conn = DatabaseConnection.getConnection();

        stmt = conn.createStatement();

        // Lấy danh sách giảng viên
        String sql = "SELECT * FROM giangvien";
        result = stmt.executeQuery(sql);
%>
<%@ include file="../../Extend/sidebar-SV.jsp" %>

<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-6" style="height: 635px;">
                <h5>Gửi phản hồi</h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p style="margin: 10px 0;">Chủ đề phản hồi</p>
                                <input class="input" type="text" name="CD" required>
                            </div>
                            <p style="margin: 10px 0;">Chọn bộ phận xử lý</p>
                            <select class="input" name="ROLE" id="roleSelect" onchange="showAdditionalSelect()">
                                <option value=""></option>
                                <option value="AD">Viện Công nghệ thông tin</option>
                                <option value="GV">Giảng viên</option>
                            </select>
                            <div id="additionalSelect" style="display: none;">
                                <p style="margin: 10px 0;">chọn giảng viên</p>
                                <select class="input" name="GV" id="additionalRole">
                                    <option value="0"></option>
                                    <%
                                        while(result.next()){
                                            String maGV = result.getString("MA_GV");
                                            String tenGV = result.getString("TEN_GV");
                                    %>
                                    <option value="<%=maGV%>"><%=tenGV%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <p style="margin: 10px 0;">Tin nhắn</p>
                                <textarea name="TN" cols="30" rows="10"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button">
                    <button type="submit" name="save">Lưu</button>
                </div>
            </div>
        </form>

        <div>
            <h1 style="color: white;">Lịch sử gửi</h1>
            <table class="list">
                <tr>
                    <th>STT</th>
                    <th>Câu hỏi</th>
                    <th>Tin nhắn</th>
                    <th>Phản hồi</th>
                    <th></th>
                </tr>
                <%
                    String sql2 = "SELECT * FROM phanhoi WHERE MA_SV = " + ID;
                    result2 = stmt.executeQuery(sql2);
                    int stt = 1;
                    while(result2.next()){
                %>
                <tr>
                    <td><%=stt++ %></td>
                    <td><%=result2.getString("TEN_PH") %></td>
                    <td><%=result2.getString("TinNhan") %></td>
                    <td><%=result2.getString("TraLoi") %></td>
                    <td></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
    </div>
    </div>
</div>

<%
    // Xử lý submit form
    if(request.getParameter("save") != null){
        String TEN_PH = request.getParameter("CD");
        String NguoiGui = String.valueOf(ID);
        String NguoiNhan= request.getParameter("ROLE");
        String MA_NguoiNhan = request.getParameter("GV");
        String TinNhan = request.getParameter("TN");

        String insertSql = "INSERT INTO phanhoi (TEN_PH, MA_SV, NguoiNhan, MA_NguoiNhan, TinNhan) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(insertSql);
        pstmt.setString(1, TEN_PH);
        pstmt.setString(2, NguoiGui);
        pstmt.setString(3, NguoiNhan);
        pstmt.setString(4, MA_NguoiNhan);
        pstmt.setString(5, TinNhan);

        int rows = pstmt.executeUpdate();
        if(rows > 0){
%>
            <script>alert("Gửi thành công");</script>
<%
        } else {
%>
            <script>alert("Gửi thất bại");</script>
<%
        }
        pstmt.close();
    }
} catch(Exception e){
    out.println("Lỗi: " + e.getMessage());
} finally {
    if(result != null) try { result.close(); } catch(Exception e) {}
    if(result2 != null) try { result2.close(); } catch(Exception e) {}
    if(stmt != null) try { stmt.close(); } catch(Exception e) {}
    if(conn != null) try { conn.close(); } catch(Exception e) {}
}
%>

<script src="../../JS.JS"></script>
<script>
function showAdditionalSelect() {
    var role = document.getElementById("roleSelect").value;
    var additionalSelect = document.getElementById("additionalSelect");
    if (role === "GV") {
        additionalSelect.style.display = "block";
    } else {
        additionalSelect.style.display = "none";
    }
}
</script>
</body>
</html>
