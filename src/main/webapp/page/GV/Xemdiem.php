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
    header("location:Diem.php");
  }
  require_once '../../PHP/connect.php';
  $id = $_GET['id'];
  $name = $_GET['name'];
  
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
              <?php 
                if($name == "CV"){
                  echo 
                  "<tr>
                  <th>STT</th>
                  <th>Mã SV</th>
                  <th>Họ tên</th>
                  <th>Số điện thoại</th>
                  <th>Giới tính</th>
                  <th>Gmail</th>
                  <th></th>
                </tr>";
                }
                else{
                  echo 
                  "<tr>
                  <th>STT</th>
                  <th>Mã SV</th>
                  <th>Họ tên</th>
                  <th>Chuyên cần</th>
                  <th>Kiểm tra 1</th>
                  <th>Kiểm tra 2</th>
                  <th>Kiểm tra 3</th>
                  <th></th>
                </tr>";
                }             
              ?>
              <?php 
if($name=="CV"){
  $xuat = "SELECT sinhvien_lopcv.*, sinhvien.* FROM sinhvien_lopcv
  inner join sinhvien on sinhvien.MA_SV = sinhvien_lopcv.MA_SV
  WHERE MA_LOPCV = $id ";
  $result = $conn->query( $xuat );

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      echo 
      "<tr>"."<td></td>" .
      "<td>".$row['MA_SV']. "</td>" .
      "<td>". $row["TEN_SV"]."</td>".
      "<td>". $row["SDT"]."</td>". 
      "<td>". $row["GIOITINH"]."</td>". 
      "<td>". $row["GMAIL"]."</td>". 
      "<td>"."<a href ="."Diem-SV.php?id=". $row["MA_SV"].">Xem điểm</a></td>";
}};
}
else{
  $xuat = "SELECT thamgiahoc.MA_SV, thamgiahoc.MA_LOP,sinhvien.*,diem.*, lop.TEN_LOP FROM thamgiahoc
  inner join sinhvien on sinhvien.MA_SV = thamgiahoc.MA_SV
  inner join diem on diem.MA_SV = thamgiahoc.MA_SV
  inner join lop on lop.MA_LOP = thamgiahoc.MA_LOP
  WHERE thamgiahoc.MA_LOP = '$id'
  and lop.MA_MH = diem.MA_MH
  ";
  $result = $conn->query( $xuat );

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      echo 
      "<tr>"."<td></td>" .
      "<td>".$row['MA_SV']. "</td>" .
      "<td>". $row["TEN_SV"]."</td>".
      "<td>". $row["CC"]."</td>".
      "<td>". $row["KT1"]."</td>". 
      "<td>". $row["KT2"]."</td>". 
      "<td>". $row["KT3"]."</td>";}};
}
                
                
              ?>
            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>
       
</body>
</html>