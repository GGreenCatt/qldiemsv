<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, controller.DatabaseConnection" %>
<%
    HttpSession ss = request.getSession();
    if(ss.getAttribute("username") == null){
        response.sendRedirect("../../index.jsp");
        return;
    }

    String id = request.getParameter("id");
    if(id == null){
        response.sendRedirect("DS-ND.jsp");
        return;
    }

    String MA = "", TEN = "";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null, rs2 = null;

    try {
        conn = DatabaseConnection.getConnection();
        String xuat = "SELECT thamgiahoc.MA_SV, sinhvien.TEN_SV FROM thamgiahoc " +
                      "INNER JOIN lop ON lop.MA_LOP = thamgiahoc.MA_LOP " +
                      "INNER JOIN sinhvien ON sinhvien.MA_SV =  thamgiahoc.MA_SV " +
                      "WHERE thamgiahoc.MA_SV LIKE ?";
        ps = conn.prepareStatement(xuat);
        ps.setString(1, id);
        rs = ps.executeQuery();
        if (rs.next()) {
            MA = rs.getString("MA_SV");
            TEN = rs.getString("TEN_SV");
        }

        String MH = "SELECT * FROM monhoc";
        ps = conn.prepareStatement(MH);
        rs2 = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<jsp:include page="../../Extend/sidebar-AD.jsp" />
<div class="main">
    <jsp:include page="../../Extend/controllpanel.jsp" />
    <div class="screen">
        <form method="post">
            <div class="row-3" style="height: 570px;">
                <h5>Nhập điểm sinh viên: <%= TEN %></h5>
                <h5>Môn học: 
                    <select class="input" style="width: 30%;" name="monhoc">
                        <option value="#"></option>
                        <%
                            while (rs2.next()) {
                        %>
                            <option value="<%= rs2.getString("MA_MH") %>"><%= rs2.getString("TEN_MH") %></option>
                        <%
                            }
                        %>
                    </select>
                </h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Kiểm tra 1</p>
                                <input type="text" name="KT1">
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 2</p>
                                <input type="text" name="KT2">
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 3</p>
                                <input type="text" name="KT3">
                            </div>
                            <div style="padding-top: 22px;" class="add-button">
                                <button type="submit" name="save">Lưu</button>
                            </div>
                        </div>
                        <div class="col-1" style="height: 500px;">
                            <div class="mb-3">
                                <p>Thi 1</p>
                                <input type="text" name="THI1">
                            </div>
                            <div class="mb-3">
                                <p>Thi 2</p>
                                <input type="text" name="THI2">
                            </div>
                            <div class="mb-3">
                                <p>Thi 3</p>
                                <input type="text" name="THI3">
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

<%
    } catch(Exception e) {
        out.println("Lỗi: " + e.getMessage());
    } finally {
        if (rs2 != null) rs2.close();
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<%
    if(request.getParameter("save") != null){
        String Monhoc = request.getParameter("monhoc");
        String KT1 = request.getParameter("KT1");
        String KT2 = request.getParameter("KT2");
        String KT3 = request.getParameter("KT3");
        String THI1 = request.getParameter("THI1");
        String THI2 = request.getParameter("THI2");
        String THI3 = request.getParameter("THI3");

        Connection connSave = null;
        PreparedStatement psSave = null;

        try {
            connSave = DatabaseConnection.getConnection();
            String sqlInsert = "INSERT INTO diem (MA_SV, MA_MH, KT1, KT2, KT3, THI1, THI2, THI3) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            psSave = connSave.prepareStatement(sqlInsert);
            psSave.setString(1, id);
            psSave.setString(2, Monhoc);
            psSave.setString(3, KT1);
            psSave.setString(4, KT2);
            psSave.setString(5, KT3);
            psSave.setString(6, THI1);
            psSave.setString(7, THI2);
            psSave.setString(8, THI3);

            int row = psSave.executeUpdate();
            if(row > 0){
%>
<script>alert('Thêm thành công');</script>
<%
            }
        } catch(Exception ex) {
            out.println("Lỗi thêm điểm: " + ex.getMessage());
        } finally {
            if (psSave != null) psSave.close();
            if (connSave != null) connSave.close();
        }
    }
%>

<script src="../../JS.JS"></script>
</body>
</html>
