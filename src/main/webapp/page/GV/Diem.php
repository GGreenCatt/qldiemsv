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
  if(!isset($_SESSION["username"])){
    header("location:../../page/login.php");
  }
  require_once '../../PHP/connect.php';
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
            <h1 style="color: white;">Lớp cố vấn: </h1><br>
            <div class="contaner-4x">
             
              <?php 
                $ID = $_SESSION['ID'];
                $sql2= "SELECT * FROM lopcv
                WHERE MA_GV = $ID";

                $result2 = $conn->query($sql2);
                if ($result2->num_rows > 0) {
                  while($row = $result2->fetch_assoc()) {
                    echo 
                    "<div class='list-box'>
                          <div class='class-picture'></div>
                          <div class='class-content'>
                              <h2>Tên lớp: ".$row['TEN_LOPCV']."</h2>
                              <div style='display: flex; justify-content: space-around;'> 
                              <a class='button'href="."'Xemdiem.php?id=". $row["MA_LOPCV"]."&name=CV'>Chi tiết</a>
                              </div>
                          </div>
                      </div>";
                  }};
                
              ?>
            </div>
                  <h1 style="color: white;">Lớp giảng dạy</h1><br>
            <div class="contaner-4x">
          <?php
          $ID = $_SESSION['ID'];
          $sql = "SELECT * FROM lop
          where MA_GV = $ID";

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
                        <a class='button'href="."'Xemdiem.php?id=". $row["MA_LOP"]."&name=GV'>Chi tiết</a>
                        </div>
                    </div>
                </div>";
            }};
          
          ?>
          </div>
              <?php 
                $ID = $_SESSION["ID"];
              ?>
            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>
       
</body>
</html>