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
$id = $_GET['id'];

  if(!isset($_SESSION["username"])){
    header("location:../../page/login.php");
  }
  require_once '../../PHP/connect.php';
  ?>
<?php include '../../PHP/sidebar-GV.php'?>
    <div class="main">
        <div class="controlpanel">
            <div class="status">
                <h2>Điểm sinh viên </h2>
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
                    <input style="width: 250px;" type="text" placeholder="Tên môn..." name="search2" id="myInput" onkeyup="myFunction()">
                  </form>

            </div>
            <table class="list" id="myTable">
              <tr>
                <th>STT</th>
                <th>Mã môn học</th>
                <th>Tên môn học</th>
                <th>Chuyên cần</th>
                <th>Kiểm tra 1</th>
                <th>Kiểm tra 2</th>
                <th>Kiểm tra 3</th>
                <th>Thi 1</th>
                <th>Thi 2</th>
                <th>Thi 3</th>
                <th>Tổng kết(10)</th>
                <th>Tổng kết(CH)</th>
                <th>Kết quả</th>
                <th></th>

              </tr>
              <?php 


              $sql = "SELECT diem.*, monhoc.TEN_MH, 
               ROUND(IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5),1) AS TK10 ,

              CASE
                WHEN IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5) >= 8.5 THEN 'A'
                WHEN IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5) >=7  THEN 'B'
                WHEN IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5) >= 5.5  THEN 'C'
                WHEN IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5) >=4 THEN 'D'
                ELSE 'F'
              END AS TKCH,

              CASE
                WHEN IF(monhoc.SOTC = 3, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.3 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.6, CC * 0.1 + GREATEST(KT1, IFNULL(KT2, 0), IFNULL(KT3, 0)) * 0.4 + GREATEST(THI1, IFNULL(THI2, 0), IFNULL(THI3, 0))*0.5) >=4 THEN 'Đạt'
                ELSE 'Trượt'
              END AS KQTK
              FROM diem
              inner join monhoc ON diem.MA_MH = monhoc.MA_MH
              WHERE MA_SV = $id";
    
              $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                  while($row = $result->fetch_assoc()) {
                    echo 
                    "<tr>"."<td></td>" .
                    "<td>".$row['MA_MH']. "</td>" .
                    "<td>". $row["TEN_MH"]. "</td>" .
                    "<td>". $row["CC"]."</td>".
                    "<td>". $row["KT1"]."</td>". 
                    "<td>". $row["KT2"]."</td>". 
                    "<td>". $row["KT3"]."</td>".
                    "<td>". $row["THI1"]."</td>".
                    "<td>". $row["THI2"]."</td>". 
                    "<td>". $row["THI3"]."</td>". 
                    "<td>". $row["TK10"]."</td>". 
                    "<td>". $row["TKCH"]."</td>". 
                    "<td>". $row["KQTK"]."</td>";            }};
                
              ?>
            </table>
        </div>
    </div>

    <script src="../../JS.JS"></script>
       
</body>
</html>