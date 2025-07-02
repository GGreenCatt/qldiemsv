<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--Icon-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin chung</title>
</head>
<body>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int totalClasses = 0;
    int totalSubjects = 0;
    int totalTeachers = 0;
    int totalStudents = 0;

    // Dữ liệu cho biểu đồ kết quả học tập (ví dụ: Xuất sắc, Giỏi, Khá, Trung bình, Yếu)
    // Giả định bạn có cách tính điểm cuối cùng cho sinh viên
    // Đây là phần phức tạp nhất, cần xác định công thức tính điểm cuối cùng (final_score)
    // Tôi sẽ giả định một cách tính điểm đơn giản hoặc bạn sẽ cần thay thế logic này
    Map<String, Integer> academicResults = new LinkedHashMap<>();
    academicResults.put("Xuất sắc", 0);
    academicResults.put("Giỏi", 0);
    academicResults.put("Khá", 0);
    academicResults.put("Trung bình", 0);
    academicResults.put("Yếu", 0);

    // Dữ liệu cho biểu đồ kết quả đánh giá (Đạt, Thi lại, Học lại)
    Map<String, Integer> evaluationResults = new LinkedHashMap<>();
    evaluationResults.put("Đạt", 0);
    evaluationResults.put("Thi lại", 0);
    evaluationResults.put("Học lại", 0);


    try {
        conn = DatabaseConnection.getConnection();

        // 1. Lấy tổng số lớp
        String sqlTotalClasses = "SELECT COUNT(*) AS total FROM lop";
        pstmt = conn.prepareStatement(sqlTotalClasses);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalClasses = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        // 2. Lấy tổng số môn học
        String sqlTotalSubjects = "SELECT COUNT(*) AS total FROM monhoc";
        pstmt = conn.prepareStatement(sqlTotalSubjects);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalSubjects = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        // 3. Lấy tổng số giảng viên
        String sqlTotalTeachers = "SELECT COUNT(*) AS total FROM giangvien";
        pstmt = conn.prepareStatement(sqlTotalTeachers);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalTeachers = rs.getInt("total");
        }
        rs.close();
        pstmt.close();

        // 4. Lấy tổng số sinh viên
        String sqlTotalStudents = "SELECT COUNT(*) AS total FROM sinhvien";
        pstmt = conn.prepareStatement(sqlTotalStudents);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalStudents = rs.getInt("total");
        }
        rs.close();
        pstmt.close();
        
        // 5. Tính toán dữ liệu cho biểu đồ Kết quả học tập và Đánh giá
        // Đây là phần phức tạp và có thể cần điều chỉnh tùy theo công thức tính điểm của bạn
        // Giả định: Điểm cuối cùng được tính từ (CC * x% + KT * y% + THI * z%)
        // và bạn có một cách để lấy điểm cuối cùng cho mỗi sinh viên/môn học.
        // Tôi sẽ thực hiện một truy vấn để lấy tất cả các điểm và tính toán
        // dựa trên một giả định về công thức tính điểm (ví dụ: trung bình đơn giản)
        
        // Truy vấn lấy điểm của tất cả sinh viên cho mỗi môn
        String sqlStudentScores = "SELECT d.MA_SV, d.CC, d.KT1, d.KT2, d.KT3, d.THI1, d.THI2, d.THI3, m.`%TINH` " +
                                  "FROM diem d INNER JOIN monhoc m ON d.MA_MH = m.MA_MH";
        pstmt = conn.prepareStatement(sqlStudentScores);
        rs = pstmt.executeQuery();

        int totalPass = 0;
        int totalRetakeExam = 0; // Thi lại
        int totalRetakeCourse = 0; // Học lại
        
        // Sử dụng Map để lưu điểm cuối cùng của mỗi sinh viên cho từng môn để tránh tính toán lại
        Map<String, Double> studentSubjectFinalScores = new LinkedHashMap<>();

        while (rs.next()) {
            double cc = rs.getFloat("CC");
            double kt1 = rs.getFloat("KT1");
            double kt2 = rs.getFloat("KT2");
            double kt3 = rs.getFloat("KT3");
            double thi1 = rs.getFloat("THI1");
            double thi2 = rs.getFloat("THI2");
            double thi3 = rs.getFloat("THI3");
            String tiLeTinhDiem = rs.getString("%TINH"); // Ví dụ: "40-60", "50-50"

            double finalScore = 0;
            // Phân tích tỷ lệ tính điểm và tính điểm cuối cùng
            if (tiLeTinhDiem != null && tiLeTinhDiem.contains("-")) {
                String[] parts = tiLeTinhDiem.split("-");
                if (parts.length == 2) {
                    try {
                        double tiLeCCKT = Double.parseDouble(parts[0]) / 100.0;
                        double tiLeThi = Double.parseDouble(parts[1]) / 100.0;
                        
                        double diemKT = 0;
                        int ktCount = 0;
                        if (kt1 >= 0) { diemKT += kt1; ktCount++; }
                        if (kt2 >= 0) { diemKT += kt2; ktCount++; }
                        if (kt3 >= 0) { diemKT += kt3; ktCount++; }
                        if (ktCount > 0) diemKT /= ktCount; // Trung bình điểm KT

                        double diemThi = 0;
                        int thiCount = 0;
                        if (thi1 >= 0) { diemThi += thi1; thiCount++; }
                        if (thi2 >= 0) { diemThi += thi2; thiCount++; }
                        if (thi3 >= 0) { diemThi += thi3; thiCount++; }
                        if (thiCount > 0) diemThi /= thiCount; // Trung bình điểm Thi

                        // Giả định CC (chuyên cần) là điểm thành phần hoặc được tính vào KT
                        // Nếu CC là điểm riêng, bạn cần điều chỉnh công thức.
                        // Ví dụ đơn giản: Điểm thành phần = (CC + DiemKT) / 2
                        // Hoặc bỏ qua CC nếu nó chỉ là yếu tố chuyên cần không ảnh hưởng trực tiếp đến điểm số
                        double diemThanhPhan = diemKT; // Giả định KT là điểm thành phần
                        if (cc >= 0) diemThanhPhan = (diemKT + cc) / 2; // Nếu CC là điểm có trọng số

                        finalScore = (diemThanhPhan * tiLeCCKT) + (diemThi * tiLeThi);
                        
                        // Nếu có thể, làm tròn điểm cuối cùng
                        finalScore = Math.round(finalScore * 100.0) / 100.0;

                    } catch (NumberFormatException ex) {
                        System.err.println("Lỗi phân tích tỷ lệ tính điểm: " + tiLeTinhDiem);
                        finalScore = 0; // Mặc định nếu lỗi
                    }
                }
            } else {
                // Xử lý trường hợp không có tỷ lệ tính điểm hoặc định dạng khác
                // Ví dụ: chỉ lấy điểm thi nếu không có tỷ lệ rõ ràng
                if (thi1 >= 0) finalScore = thi1;
            }

            // Gán loại kết quả học tập
            if (finalScore >= 9) {
                academicResults.put("Xuất sắc", academicResults.get("Xuất sắc") + 1);
            } else if (finalScore >= 8) {
                academicResults.put("Giỏi", academicResults.get("Giỏi") + 1);
            } else if (finalScore >= 6.5) {
                academicResults.put("Khá", academicResults.get("Khá") + 1);
            } else if (finalScore >= 5) {
                academicResults.put("Trung bình", academicResults.get("Trung bình") + 1);
            } else {
                academicResults.put("Yếu", academicResults.get("Yếu") + 1);
            }

            // Gán loại kết quả đánh giá
            if (finalScore >= 5) { // Điểm đạt là >= 5
                totalPass++;
            } else if (finalScore >= 3.5 && finalScore < 5) { // Giả định thi lại từ 3.5 đến dưới 5
                totalRetakeExam++;
            } else { // Học lại nếu dưới 3.5
                totalRetakeCourse++;
            }
        }
        
        evaluationResults.put("Đạt", totalPass);
        evaluationResults.put("Thi lại", totalRetakeExam);
        evaluationResults.put("Học lại", totalRetakeCourse);


    } catch (SQLException e) {
        System.err.println("Lỗi khi truy vấn thống kê dữ liệu: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }

    // Chuyển đổi Map sang mảng JavaScript để truyền vào Chart.js
    StringBuilder x1Labels = new StringBuilder("[");
    StringBuilder y1Data = new StringBuilder("[");
    boolean first = true;
    for (Map.Entry<String, Integer> entry : academicResults.entrySet()) {
        if (!first) { x1Labels.append(", "); y1Data.append(", "); }
        x1Labels.append("\"").append(entry.getKey()).append("\"");
        y1Data.append(entry.getValue());
        first = false;
    }
    x1Labels.append("]");
    y1Data.append("]");

    StringBuilder x2Labels = new StringBuilder("[");
    StringBuilder y2Data = new StringBuilder("[");
    first = true;
    for (Map.Entry<String, Integer> entry : evaluationResults.entrySet()) {
        if (!first) { x2Labels.append(", "); y2Data.append(", "); }
        x2Labels.append("\"").append(entry.getKey()).append("\"");
        y2Data.append(entry.getValue());
        first = false;
    }
    x2Labels.append("]");
    y2Data.append("]");
%>

    <%@include file="../../Extend/sidebar-AD.jsp" %>
    <div class="main">
        <%@include file="../../Extend/controllpanel.jsp" %>
                <div class="screen">
        <div class="contaner-4x">
            <div class="status-box" style="background-color: rgb(37, 150, 190);">
                <h1>Lớp</h1>
                <p style="font-size: 3em; margin-left: 10px;"><%= totalClasses %></p>
                <div class="more"><a href="DS-LOP.jsp">Xem thêm</a></div>
                <span class="material-symbols-outlined icon">
                    meeting_room
                    </span>
            </div>
            <div class="status-box" style="background-color: green;">
                <h1>Môn học</h1> <%-- Đổi thành Môn học --%>
                <p style="font-size: 3em; margin-left: 10px;"><%= totalSubjects %></p>
                <div class="more"><a href="DS-MH.jsp">Xem thêm</a></div>
                <span class="material-symbols-outlined icon">
                    subject <%-- Đổi icon nếu cần --%>
                    </span>
            </div>
            <div class="status-box" style="background-color: orange;">
                <h1>Giảng viên</h1> <%-- Đổi thành Giảng viên --%>
                <p style="font-size: 3em; margin-left: 10px;"><%= totalTeachers %></p>
                <div class="more"><a href="DS-GV.jsp">Xem thêm</a></div>
                <span class="material-symbols-outlined icon">
                    groups <%-- Đổi icon nếu cần --%>
                    </span>
            </div>
            <div class="status-box" style="background-color: rosybrown;">
                <h1>Sinh viên</h1> <%-- Đổi thành Sinh viên --%>
                <p style="font-size: 3em; margin-left: 10px;"><%= totalStudents %></p>
                <div class="more"><a href="DS-SV.jsp">Xem thêm</a></div>
                <span class="material-symbols-outlined icon">
                    school <%-- Đổi icon nếu cần --%>
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
                <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>      
    </div>

    <script src="../../JS.JS"></script>
<script>
    // Dữ liệu được truyền từ JSP
    const x1 = <%= x1Labels.toString() %>;
    const y1 = <%= y1Data.toString() %>;
    const x2 = <%= x2Labels.toString() %>;
    const y2 = <%= y2Data.toString() %>;
    
    const barColors1 = ["#00bcd4", "#8bc34a", "#ffc107", "#ff9800", "#f44336"]; // Màu sắc cho biểu đồ cột
    const barColors2 = ["#4caf50", "#ffeb3b", "#f44336"]; // Màu sắc cho biểu đồ tròn (Đạt, Thi lại, Học lại)
    
    // Biểu đồ Kết quả học tập (Cột)
    new Chart("myChart1", {
        type: "bar",
        data: {
            labels: x1,
            datasets: [{
                backgroundColor: barColors1,
                data: y1
            }]
        },
        options: {
            legend: {display: false},
            title: {
                display: true,
                text: "Kết quả học tập theo xếp loại"
            },
            scales: { // Thêm cấu hình scales để hiển thị giá trị trên trục Y
                yAxes: [{
                    ticks: {
                        beginAtZero: true,
                        callback: function(value) {if (value % 1 === 0) {return value;}} // Chỉ hiển thị số nguyên
                    }
                }]
            }
        }
    });

    // Biểu đồ Kết quả đánh giá (Tròn)
    new Chart("myChart2", {
        type: "pie",
        data: {
            labels: x2,
            datasets: [{
                backgroundColor: barColors2,
                data: y2
            }]
        },
        options: {
            title: {
                display: true,
                text: "Kết quả đánh giá chung"
            }
        }
    });
</script>
</body>
</html>