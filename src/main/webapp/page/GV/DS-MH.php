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
    $xuat = "SELECT * FROM monhoc";
    $result = $conn->query( $xuat );
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Danh sách môn học</h2>
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
                    <input style="width: 250px;" type="text" placeholder="Tên môn học..." name="search2" id="myInput" onkeyup="myFunction()">
                  </form>

            </div>

            <table class="list"  id="myTable">
              <tr>
                <th>STT</th>
                <th>Mã môn học</th>
                <th>Tên môn học</th>
                <th></th>
              </tr>
              
              <?php 
              
                if(isset($_POST['timkiem'])){
                  $thongtin=$_POST['search2'];
    
                  $tim_kiem = "SELECT ID_MH, MA_MH,TEN_MH FROM monhoc
                  WHERE MA_MH like '%$thongtin%'   
                  OR TEN_MH like '%$thongtin%'";
         
              $result = $conn->query($tim_kiem);

              if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                  echo "<tr>".
                  "<td></td>" . 
                  "<td>".$row['MA_MH']. "</td>" .
                  "<td>". $row["TEN_MH"]. "</td>" .
                  "<br>";
                }};
                }
                else{
                  if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                      echo "<tr>".
                  "<td></td>" . 
                  "<td>".$row['MA_MH']. "</td>" .
                  "<td>". $row["TEN_MH"]. "</td>" .
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