<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
  <?php session_start();
//header("Location: page/".$_SESSION["ROLE"]."/TTC.php");
  if(!isset($_SESSION["username"])){
    header("location:../../page/login.php");
  }
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Trang chủ</h2>
            </div>

            <ul class="menu">
                <li><span class="material-symbols-outlined">search</span></li>
                <li><span class="material-symbols-outlined">light_mode</span></li>
                <li><span class="material-symbols-outlined">fullscreen</span></li>
                <li><span class="material-symbols-outlined">chat</span></li>
                <li><span class="material-symbols-outlined">notifications</span></li>
                <li><span class="material-symbols-outlined">settings</span></li>
                <li class="user_DRD"><img src="" alt=""><?php echo $_SESSION["username"];?>
                  <div class="user_DRD_CT">
                  <a href="../../PHP/logout.php">Đăng xuất</a>
                  </div>
              </li>
            </ul>
        </div>
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
                      <h3>Giảng dạy</h3>
                      <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                    </div>
                </div>
                <div class="card">
                  <img src="../../Pic/giang-day.png" alt="">
                  <div class="text">
                    <h3>Giảng dạy</h3>
                    <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                  </div>
              </div>
              <div class="card">
                <img src="../../Pic/giang-day.png" alt="">
                <div class="text">
                  <h3>Giảng dạy</h3>
                  <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
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
              Dịch vụ cho giảng viên
          </h1>
          <div class="box">
              <div class="card">
                  <img src="../../Pic/giang-day.png" alt="">
                  <div class="text">
                    <h3>Giảng dạy</h3>
                    <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                  </div>
              </div>
              <div class="card">
                <img src="../../Pic/giang-day.png" alt="">
                <div class="text">
                  <h3>Giảng dạy</h3>
                  <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
                </div>
            </div>
            <div class="card">
              <img src="../../Pic/giang-day.png" alt="">
              <div class="text">
                <h3>Giảng dạy</h3>
                <p>Thời khóa biểu, phân công giảng dạy, điểm danh</p>
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
      <div class="footer">

      </div>
    </div>

    <script src="../../JS.JS"></script>
</body>
</html>