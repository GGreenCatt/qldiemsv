<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }
%>
  <%@include file="../../Extend/sidebar-AD.jsp" %>
    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
        <div class="screen" style="padding: 0;">
            <div class="slideshow-container">
            <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)),url(../../Pic/Banner-3.jpg);">
                </div>
                
                <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)),url(../../Pic/Banner-1.jpg);">
                </div>
                
                <div class="mySlides" style="background-image: linear-gradient(rgba(0, 0, 0, 0.25), rgba(0, 0, 0, 0.25)),url(../../Pic/Banner-2.jpg);">
                </div>
                
            <div class="dotcenter">
                <div style="text-align:center">
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                    <span class="dot"></span> 
                </div>
            </div>
        </div>
        <div class="row-5">
            <h1>
                Dịch vụ cho giảng viên
            </h1>
            <div class="box">
                <div class="card">
                    <img src="../../Pic/giang-day.png" alt="">
                    <div class="text">
                      <h3>Xem điểm </h3>
                      <p>Tra cứu điểm sinh viên các lớp cố vấn và lớp giảng dạy.</p>
                    </div>
                </div>
                <div class="card">
                  <img src="../../Pic/giang-day.png" alt="">
                  <div class="text">
                    <h3>Quản lý Lớp học</h3>
                    <p>Xem danh sách sinh viên, thông tin các lớp đang giảng dạy.</p>
                  </div>
              </div>
              <div class="card">
                <img src="../../Pic/giang-day.png" alt="">
                <div class="text">
                  <h3>Phản hồi Sinh viên</h3>
                  <p>Xem và trả lời các câu hỏi, phản hồi từ sinh viên.</p>
                </div>
            </div>
            <div class="card">
              <img src="../../Pic/giang-day.png" alt="">
              <div class="text">
                <h3>Giảng dạy</h3>
                <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
              </div>
          </div>
            </div>
        </div>

        <div class="row-5">
          <h1>
              Tiện ích khác
          </h1>
          <div class="box">
              <div class="card">
                  <img src="../../Pic/giang-day.png" alt="">
                  <div class="text">
                    <h3>Thông tin cá nhân</h3>
                          <p>Xem và cập nhật thông tin cá nhân, tài khoản.</p>
                  </div>
              </div>
              <div class="card">
                <img src="../../Pic/giang-day.png" alt="">
                <div class="text">
                  <h3>Tài liệu Môn học</h3>
                          <p>Quản lý và chia sẻ tài liệu, giáo trình cho sinh viên.</p>
                </div>
            </div>
            <div class="card">
              <img src="../../Pic/giang-day.png" alt="">
              <div class="text">
                <h3>Lịch làm việc</h3>
                          <p>Xem lịch coi thi, chấm bài, các sự kiện của khoa/trường.</p>
              </div>
          </div>
          <div class="card">
            <img src="../../Pic/giang-day.png" alt="">
            <div class="text">
              <h3>Nghiên cứu Khoa học</h3>
                          <p>Thông tin về các đề tài, dự án nghiên cứu khoa học.</p>

            </div>
        </div>
          </div>
      </div>
    </div>
        <div class="footer">
            <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
</div>
    <script src="../../JS.JS"></script>
</body>
</html>