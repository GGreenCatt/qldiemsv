<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<?php session_start();
  if(!isset($_SESSION["username"])){
    header("location:../../page/login.php");
  }
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Thông tin chung</h2>
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
        <div class="screen">
          <div class="contaner-4x">
            <div class="status-box" style="background-color: rgb(37, 150, 190);"> 
              <h1>Lớp</h1>
              <div class="more"><a href="DS-LOP.php">Xem thêm</a></div>
              <span class="material-symbols-outlined icon">
                meeting_room
                </span>
            </div>
            <div class="status-box" style="background-color: green;"> 
              <h1>Điểm</h1>
              <div class="more"><a href="Diem.php">Xem thêm</a></div>
              <span class="material-symbols-outlined icon">
                school
                </span>
            </div>
            <div class="status-box" style="background-color: orange;">
              <h1>Môn học</h1>
              <div class="more"><a href="DS-MH.php">Xem thêm</a></div>
              <span class="material-symbols-outlined icon">
                subject
                </span>
            </div>
            <div class="status-box" style="background-color: rosybrown;">
              <h1>Giảng viên</h1>
              <div class="more"><a href="DS-GV.php">Xem thêm</a></div>
              <span class="material-symbols-outlined icon">
                groups
                </span>
            </div>
          </div>

          <div class="contaner-2x">
            <div class="box">
              <canvas id="myChart1" style="width:100%;height: 400px;"></canvas>
            </div>

            <div class="box">
              <canvas id="myChart2" style="width:100%;height: 390px;"></canvas>
            </div>
          </div>
      </div>
    </div>

    <script src="../../JS.JS"></script>

<script>
  const x1 = ["Xuất xắc", "Giỏi", "Khá", "Trung bình", "Yếu"];
  const y1 = [2, 7, 30, 15, 4];
  const x2 = ["Đạt", "Thi lại", "Học lại"];
  const y2 = [55, 4, 1];
  const barColors = ["red", "green","blue","orange","brown"];
  
  new Chart("myChart1", {
  
    type: "bar",
    data: {
      labels: x1,
      datasets: [{
        backgroundColor: barColors,
        data: y1
      }]
    },
    options: {
      legend: {display: false},
      title: {
        display: true,
        text: "Kết quả học tập"
      }
    }
  });
  new Chart("myChart2", {
  type: "pie",
  data: {
    labels: x2,
    datasets: [{
      backgroundColor: barColors,
      data: y2
    }]
  },
  options: {
    title: {
      display: true,
      text: "Kết quả đánh giá"
    }
  }
});
  </script>
</body>
</html>