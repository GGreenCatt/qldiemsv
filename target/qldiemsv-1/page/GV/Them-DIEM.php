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
    header("location:Nhap_Diem.php");
  }
  require_once '../../PHP/connect.php';
  $id= $_GET['id'];
  $xuat = "SELECT diem.*, sinhvien.TEN_SV, monhoc.TEN_MH FROM diem
  inner join sinhvien on sinhvien.MA_SV = diem.MA_SV
  inner join monhoc on monhoc.MA_MH = diem.MA_MH
  WHERE SBD = $id";
    $result = $conn->query( $xuat );
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
          $MASV= $row['MA_SV'];
          $TEN_SV = $row["TEN_SV"];  
          $MA_MH = $row["MA_MH"];
          $TEN_MH = $row["TEN_MH"];
        }};
  
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Nhập điểm</h2>
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
          <form action="" method="post">
            <div class="row-3" style="height: 370px;">
                <h5>Nhập điểm sinh viên: <?php echo $TEN_SV; ?></h5><h5> Môn học: <?php echo $TEN_MH; ?></h5><hr>
                <div class="contaner">
                    <div class="col-right" style="width: 100%;">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Chuyên cần</p>
                                <input type="text" name="CC" >
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 1</p>
                                <input type="text" name="KT1" >
                            </div>

                        </div>
                        <div class="col-1" style="height: 500px;">
                           <div class="mb-3">
                                <p>Kiểm tra 2</p>
                                <input type="text" name="KT2">
                            </div>
                            <div class="mb-3">
                                <p>Kiểm tra 3</p>
                                <input type="text" name="KT3">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="add-button">
                <button type="submit" name="save">Lưu</button>
            </div>
            </form>
        </div>
    </div>

<?php 
if(isset($_POST['save'])){
  $CC = $_POST['CC'];
  $KT1 = $_POST['KT1'];
  $KT2 = $_POST['KT2'];
  $KT3 = $_POST['KT3'];

  $sql = "UPDATE diem
        SET MA_SV= N'$ID', MA_MH=N'$MH', CC=N'$CC', KT1=N'$KT1',KT2=N'$KT2',KT3=N'$KT3'
        WHERE SBD = N'$ID'";

        if ($conn-> query($sql) === true){
          $message = "Thành công";
          echo "<script type='text/javascript'>alert('$message');</script>";
      }
      else{
        $sql = "INSERT INTO diem (MA_SV,MA_MH, CC, KT1, KT2, KT3) 
  VALUES (N'$id',N'$MH', N'$CC', N'$KT1', N'$KT2', N'$KT3')";
            if ($conn-> query($sql) === true){
              $message = "Thành công";
              echo "<script type='text/javascript'>alert('$message');</script>";
          }
      }
}
?>
    <script src="../../JS.JS"></script>
        
</body>
</html>