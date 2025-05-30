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
  require_once '../../PHP/connect.php';
  $role= $_SESSION['ROLE'];
  $ID = $_SESSION['ID'];
  $id= $_GET['id'];

  $sql = "SELECT phanhoi.*, sinhvien.TEN_SV FROM phanhoi
  inner join sinhvien on sinhvien.MA_SV = phanhoi.MA_SV
  where MA_NguoiNhan = $ID";
  $result = $conn->query( $sql );

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
             $TEN_PH= $row['TEN_PH'];
             $TEN_SV = $row["TEN_SV"];
             $TINNHAN = $row["TinNhan"];
    }};
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Phản hồi</h2>
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
              <div class="row-2"><h1 style="color: white;">Câu hỏi:  <?php echo $TEN_PH ?> </h1></div>
              <div style="height: fit-content;" class="row-6">
                <h3 style="margin-top: 15px;">Từ sinh viên: <?php echo $TEN_SV ?></h3>
                <h5><?php echo $TINNHAN ?></r></h5>
              </div>
              <div class="row-6" style="height: 350px; padding: 30px;">
                <form class="traloi" action="" method="post">
                <h3>Trả Lời</h3>
                  <textarea name="TraLoi" id="" cols="30" rows="10"></textarea>
                  <button type="submit" name="save">Gửi</button>
                </form>
              </div>
        </div>
        <?php 
    if(isset($_POST['save'])){
      $TRALOI = $_POST['TraLoi'];

        $sql = "UPDATE phanhoi
        SET TraLoi = N'$TRALOI'
        WHERE MA_PH = $id";
        
        if ($conn-> query($sql) === true){
            $message = "Gửi thành công";
            echo "<script type='text/javascript'>alert('$message');</script>";
        }
        else{
          $message = "Gửi thất bại".$conn->error;
          echo "<script type='text/javascript'>alert('$message');</script>";
        }
    }
?>

<script src="../../JS.JS"></script>
</body>
</html>