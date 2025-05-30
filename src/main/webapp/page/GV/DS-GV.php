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
    $xuat = "SELECT * FROM giangvien";
    $result = $conn->query( $xuat );
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Danh sách giảng viên</h2>
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
            <div class="row-2">
            <form class="example" method="post" style="max-width:300px">
                    <input style="width: 250px;" type="text" placeholder="Họ tên..." name="search2" id="myInput" onkeyup="myFunction()">
                  </form>

            </div>

            <table class="list"  id="myTable">
              <tr>
                <th>STT</th>
                <th>Mã giảng viên</th>
                <th>Tên</th>
                <th>Địa chỉ</th>
                <th>SĐT</th>
                <th>EMAIL</th>
                <th></th>
              </tr>
              

              <?php 
              
                if(isset($_POST['timkiem'])){
                  $thongtin=$_POST['search2'];
    
                  $tim_kiem = "SELECT ID_GV,MA_GV,TEN_GV,DIACHI,SDT,GMAIL FROM GIANGVIEN
                  WHERE MA_GV like '%$thongtin%' 
                  OR TEN_GV like '%$thongtin%'
                  OR DIACHI like '%$thongtin%'
                  OR SDT like '%$thongtin%'
                  OR GMAIL like '%$thongtin%'";
         
              $result = $conn->query($tim_kiem);

              if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>".
                    "<td></td>" . 
                    "<td>".$row['MA_GV']. "</td>" .
                    "<td>". $row["TEN_GV"]. "</td>" .
                    "<td>". $row["DIACHI"]."</td>".
                    "<td>". $row["SDT"]."</td>". 
                    "<td>". $row["GMAIL"]."</td>".
                    "<br>";
                }};
                }
                else{
                  if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                      echo "<tr>".
                      "<td></td>" . 
                      "<td>".$row['MA_GV']. "</td>" .
                      "<td>". $row["TEN_GV"]. "</td>" .
                      "<td>". $row["DIACHI"]."</td>".
                      "<td>". $row["SDT"]."</td>". 
                      "<td>". $row["GMAIL"]."</td>".
                      "<br>";
                    }};
                }
                
              ?>
            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>
       
</body>
</html>