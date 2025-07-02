<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,1,0" />
    <link rel="stylesheet" href="../../css.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Thông tin sinh viên</title>
</head>
<body>
<%
    // Kiểm tra phiên đăng nhập
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    String message = "";
    // Lấy thông báo từ request nếu có (sau khi redirect)
    if (request.getParameter("message") != null) {
        // Cần decode để hiển thị đúng ký tự tiếng Việt hoặc ký tự đặc biệt
        message = new String(java.net.URLDecoder.decode(request.getParameter("message"), "UTF-8"));
    }

    String defaultMaLop = request.getParameter("malop"); // Lấy mã lớp từ URL nếu có
    boolean isClassSpecific = (defaultMaLop != null && !defaultMaLop.isEmpty());

    // --- Xử lý POST request để thêm sinh viên (form thủ công) ---
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("save") != null) {
        String MASV = request.getParameter("masv");
        String TENSV = request.getParameter("tensv");
        String DIACHI = request.getParameter("diachi");
        String SDT = request.getParameter("sdt");
        String GMAIL = request.getParameter("gmail"); // Đổi từ "email" sang "gmail"
        String GIOITINH = request.getParameter("gioitinh");
        String NGAYSINH = request.getParameter("ngaysinh");
        String selectedMaLop = request.getParameter("malop");
        String selectedMaKH = request.getParameter("makh"); // Lấy mã khóa học

        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmtThamGiaHoc = null; 
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); 

            // 1. Chèn vào bảng sinhvien (bao gồm cả MA_KH)
            String sqlInsertSV = "INSERT INTO sinhvien (MA_SV, TEN_SV, SDT, DIACHI, GIOITINH, NGAYSINH, GMAIL, MA_KH) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlInsertSV);
            try {
                 pstmt.setInt(1, Integer.parseInt(MASV)); 
            } catch (NumberFormatException e) {
                message = "Lỗi: Mã sinh viên không hợp lệ.";
                throw e; 
            }
            pstmt.setString(2, TENSV);
            try {
                if (SDT != null && !SDT.isEmpty()) {
                    pstmt.setInt(3, Integer.parseInt(SDT)); 
                } else {
                    pstmt.setNull(3, java.sql.Types.INTEGER);
                }
            } catch (NumberFormatException e) {
                message = "Lỗi: Số điện thoại không hợp lệ.";
                throw e; 
            }
            pstmt.setString(4, DIACHI);
            pstmt.setString(5, GIOITINH);
            pstmt.setString(6, NGAYSINH); 
            pstmt.setString(7, GMAIL);
            pstmt.setString(8, selectedMaKH); // Thêm MA_KH

            int rowSV = pstmt.executeUpdate();

            // 2. Chèn vào bảng thamgiahoc nếu selectedMaLop có giá trị
            if (rowSV > 0 && selectedMaLop != null && !selectedMaLop.isEmpty()) {
                String sqlInsertThamGiaHoc = "INSERT INTO thamgiahoc (MA_LOP, MA_SV) VALUES (?, ?)";
                pstmtThamGiaHoc = conn.prepareStatement(sqlInsertThamGiaHoc);
                pstmtThamGiaHoc.setString(1, selectedMaLop);
                pstmtThamGiaHoc.setInt(2, Integer.parseInt(MASV)); 

                int rowThamGiaHoc = pstmtThamGiaHoc.executeUpdate();
                if (rowThamGiaHoc > 0) {
                    conn.commit(); 
                    message = "Thêm sinh viên và phân lớp thành công!";
                } else {
                    conn.rollback(); 
                    message = "Thêm sinh viên thất bại: Không thể phân lớp.";
                }
            } else if (rowSV > 0) {
                 conn.commit(); 
                 message = "Thêm sinh viên thành công!";
            }
            else {
                conn.rollback(); 
                message = "Thêm sinh viên thất bại.";
            }

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); 
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            if (e.getMessage().contains("Duplicate entry") && e.getMessage().contains("for key 'sinhvien.MA_SV'")) {
                 message = "Lỗi: Mã sinh viên đã tồn tại. Vui lòng chọn mã khác.";
            } else {
                 message = "Lỗi cơ sở dữ liệu: " + e.getMessage();
            }
            e.printStackTrace();
        } catch (NumberFormatException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            message = "Lỗi định dạng dữ liệu: Mã sinh viên hoặc Số điện thoại phải là số.";
            e.printStackTrace();
        } catch (Exception e) { 
             if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            message = "Lỗi không xác định: " + e.getMessage();
            e.printStackTrace();
        } finally {
            if (pstmtThamGiaHoc != null) try { pstmtThamGiaHoc.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
        
        // --- CHUYỂN HƯỚNG SAU KHI XỬ LÝ POST ---
        String redirectUrl = "Them-SV.jsp?message=" + URLEncoder.encode(message, "UTF-8");
        if (defaultMaLop != null && !defaultMaLop.isEmpty()) {
            redirectUrl += "&malop=" + URLEncoder.encode(defaultMaLop, "UTF-8");
        }
        response.sendRedirect(redirectUrl);
        return; 
    }

    // --- Lấy danh sách các lớp để điền vào dropdown ---
    List<String[]> classes = new ArrayList<>(); 
    Connection connClasses = null;
    PreparedStatement pstmtClasses = null;
    ResultSet rsClasses = null;
    try {
        connClasses = DatabaseConnection.getConnection();
        String sqlSelectClasses = "SELECT MA_LOP, TEN_LOP FROM lop ORDER BY TEN_LOP";
        pstmtClasses = connClasses.prepareStatement(sqlSelectClasses);
        rsClasses = pstmtClasses.executeQuery();
        while (rsClasses.next()) {
            classes.add(new String[]{rsClasses.getString("MA_LOP"), rsClasses.getString("TEN_LOP")});
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi tải danh sách lớp: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rsClasses != null) try { rsClasses.close(); } catch (SQLException ignored) {}
        if (pstmtClasses != null) try { pstmtClasses.close(); } catch (SQLException ignored) {}
        if (connClasses != null) try { connClasses.close(); } catch (SQLException ignored) {}
    }

    // --- Lấy danh sách các khóa học để điền vào dropdown ---
    List<String[]> courses = new ArrayList<>(); 
    Connection connCourses = null;
    PreparedStatement pstmtCourses = null;
    ResultSet rsCourses = null;
    try {
        connCourses = DatabaseConnection.getConnection();
        String sqlSelectCourses = "SELECT MA_KH, TEN_KH FROM khoahoc ORDER BY TEN_KH"; 
        pstmtCourses = connCourses.prepareStatement(sqlSelectCourses);
        rsCourses = pstmtCourses.executeQuery();
        while (rsCourses.next()) {
            courses.add(new String[]{rsCourses.getString("MA_KH"), rsCourses.getString("TEN_KH")});
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi tải danh sách khóa học: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (rsCourses != null) try { rsCourses.close(); } catch (SQLException ignored) {}
        if (pstmtCourses != null) try { pstmtCourses.close(); } catch (SQLException ignored) {}
        if (connCourses != null) try { connCourses.close(); } catch (SQLException ignored) {}
    }
%>

<%@ include file="../../Extend/sidebar-AD.jsp" %>
<div class="main">
    <%@ include file="../../Extend/controllpanel.jsp" %>
    <div class="screen">
        <form action="" method="post">
            <div class="row-3" style="height: 650px;">
                <h5>Thông tin sinh viên</h5><hr>
                <div class="contaner">
                    <div class="col-right">
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Họ và Tên</p>
                                <input type="text" name="tensv" placeholder="Họ tên..." required />
                            </div>
                            <div class="mb-3">
                                <p>Ngày sinh <span style="margin-left: 53%">Giới tính</span></p>
                                <input style="width: 65%" type="date" name="ngaysinh" placeholder="Ngày sinh..." />
                                <input style="width: 30%; margin-left: 4%" type="text" name="gioitinh" placeholder="Giới tính..." />
                            </div>
                            <div class="mb-3">
                                <p>Email</p>
                                <input type="text" name="gmail" placeholder="Gmail..." />
                            </div>
                            <div class="mb-3">
                                <p>Địa chỉ</p>
                                <textarea name="diachi" cols="30" rows="10"></textarea>
                            </div>
                        </div>
                        <div class="col-1">
                            <div class="mb-3">
                                <p>Số điện thoại</p>
                                <input type="text" name="sdt" placeholder="Số điện thoại..." />
                            </div>
                            <div class="mb-3">
                                <p>Mã sinh viên</p>
                                <input type="text" name="masv" placeholder="Mã sinh viên..." required />
                            </div>
                            <div class="mb-3">
                                <p>Mã khóa học</p>
                                <select name="makh" required>
                                    <option value="">-- Chọn khóa học --</option>
                                    <%
                                        for (String[] course : courses) {
                                            String maKH = course[0];
                                            String tenKH = course[1];
                                    %>
                                            <option value="<%= maKH %>"><%= tenKH %> (<%= maKH %>)</option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-3">
                                <p>Mã lớp</p>
                                <select name="malop" <%= isClassSpecific ? "disabled" : "" %>>
                                    <option value="">-- Chọn lớp --</option>
                                    <%
                                        for (String[] cls : classes) {
                                            String maLop = cls[0];
                                            String tenLop = cls[1];
                                            String selected = "";
                                            if (isClassSpecific && maLop.equals(defaultMaLop)) {
                                                selected = "selected";
                                            }
                                    %>
                                            <option value="<%= maLop %>" <%= selected %>><%= tenLop %> (<%= maLop %>)</option>
                                    <%
                                        }
                                    %>
                                </select>
                                <% if (isClassSpecific) { %>
                                    <input type="hidden" name="malop" value="<%= defaultMaLop %>">
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="add-button" style="margin-left: 4px">
                    <button type="submit" name="save">Lưu</button>
                    
                </div>
            </div>
        </form>
        <% if (message != null && !message.isEmpty()) { %>
            <script>
                // Thoát chuỗi JavaScript an toàn
                var escapedMessage = "<%= message.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r") %>";
                alert(escapedMessage);
            </script>
        <% } %>

        <div id="excelImportModal" class="modal">
            <div class="modal-content">
                <span class="close-button">&times;</span>
                <h2>Nhập sinh viên từ File Excel</h2>
                <p>Vui lòng tải xuống file mẫu, điền dữ liệu và tải lên:</p>
                <p><a href="../../files/Student_Import_Template.xlsx" download>Tải file Excel mẫu</a></p>
                <form action="processExcelImport.jsp" method="post" enctype="multipart/form-data">
                    <input type="file" name="excelFile" accept=".xls,.xlsx" required>
                    <% if (isClassSpecific) { %>
                        <input type="hidden" name="maLopToAssign" value="<%= defaultMaLop %>">
                    <% } %>
                    <button type="submit" name="uploadExcel">Tải lên</button>
                </form>
            </div>
        </div>

        <div class="footer">
        <p>Copyright © Thiết kế & Xây dựng bởi Dung & Long 2025</p>
        </div>
    </div>
</div>

<script src="../../JS.JS"></script>

</body>
</html>