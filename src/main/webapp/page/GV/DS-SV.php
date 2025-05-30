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
  if(!isset($_GET['id'])){
    header("location:DS-LOP.php");
  }
  require_once '../../PHP/connect.php';
  $id = $_GET['id'];
    $xuat = "SELECT thamgiahoc.MA_SV, MA_LOP,sinhvien.* FROM thamgiahoc
    inner join sinhvien on sinhvien.MA_SV = thamgiahoc.MA_SV
    WHERE MA_LOP = '$id'
    ";
    $result = $conn->query( $xuat );
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Danh sách sinh viên</h2>
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
                <th>Mã SV</th>
                <th>Họ tên</th>
                <th>Ngày sinh</th>
                <th>Giới tính</th>
                <th>Quê quán</th>
                <th>SĐT</th>
                <th>GMAIL</th>
                <th></th>
              </tr>
              <?php 
              
              if(isset($_POST['timkiem'])){
                $thongtin=$_POST['search2'];
  
                $tim_kiem = "SELECT ID_SV,MA_SV,TEN_SV,DIACHI,SDT,GMAIL,GIOITINH,NGAYSINH FROM sinhvien
                WHERE MA_SV like '%$thongtin%' 
                OR TEN_SV like '%$thongtin%'
                OR DIACHI like  '%$thongtin%'
                OR SDT like  '%$thongtin%'
                OR GMAIL like  '%$thongtin%'";
              }
              else{
                if ($result->num_rows > 0) {
                  while($row = $result->fetch_assoc()) {
                    echo "<tr>"."<td></td>" .
                    "<td>".$row['MA_SV']. "</td>" .
                    "<td>". $row["TEN_SV"]."</td>".
                    "<td>". $row["NGAYSINH"]."</td>". 
                    "<td>". $row["GIOITINH"]."</td>". 
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