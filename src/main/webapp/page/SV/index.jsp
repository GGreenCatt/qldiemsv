<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Icon -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang giảng viên</title>
</head>
<body>

<%@ include file="../../Extend/sidebar-SV.jsp" %>

<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>

    <div class="screen" style="padding: 0">
        <!-- Slideshow -->
        <div class="slideshow-container">
            <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url('../../Pic/Banner-3.jpg');"></div>
            <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url('../../Pic/Banner-1.jpg');"></div>
            <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)), url('../../Pic/Banner-2.jpg');"></div>

            <div class="dotcenter">
                <div style="text-align:center">
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                </div>
            </div>
        </div>

        <!-- Dịch vụ -->
        <div class="row-5">
            <h1>Dịch vụ cho giảng viên</h1>
            <div class="box">
                <% for (int i = 0; i < 4; i++) { %>
                <div class="card">
                    <img src="../../Pic/giang-day.png" alt="">
                    <div class="text">
                        <h3>Giảng dạy</h3>
                        <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

        <!-- Dịch vụ lặp lại -->
        <div class="row-5">
            <h1>Dịch vụ cho giảng viên</h1>
            <div class="box">
                <% for (int i = 0; i < 4; i++) { %>
                <div class="card">
                    <img src="../../Pic/giang-day.png" alt="">
                    <div class="text">
                        <h3>Giảng dạy</h3>
                        <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                    </div>
                </div>
                <% } %>
            </div>
        </div>

    <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
    </div>
    </div>
</div>

<script src="../../JS.JS"></script>
</body>
</html>
