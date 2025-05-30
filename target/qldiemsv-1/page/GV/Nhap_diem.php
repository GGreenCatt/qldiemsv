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
$ROLE = $_SESSION["ROLE"];
$filename = basename(__FILE__);

require_once '../../PHP/connect.php';
$ID = $_SESSION["ID"];
  if(!isset($_SESSION["username"])){
    header("location:../../page/login.php");
  }
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Chọn lớp</h2>
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
          <?php 
          $sql = "SELECT * FROM lop
          WHERE MA_GV = $ID";
          $result = $conn->query($sql);

          if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
              echo 
              "<div class='list-box'>
                    <div class='class-picture'></div>
                    <div class='class-content'>
                    <h2>Tên lớp: ".$row['TEN_LOP']."</h2>
                    <p>Mã lớp: ".$row['MA_LOP']."</p>
                        <p>Sĩ số: ".$row['SISO']." sinh viên</p>
                        <div style='display: flex; justify-content: space-around;'> 
                        <a class='button'href="."'DS-ND.php?id=". $row["MA_LOP"]."'>Chi tiết</a>
                        </div>
                    </div>
                </div>";
                
            }};
          
          ?>
            </div>
            </div>
        </div>
    </div>

    <script src="../../JS.JS"></script>

</body>
</html>