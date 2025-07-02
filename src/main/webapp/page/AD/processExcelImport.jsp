<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="controller.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.ss.usermodel.WorkbookFactory" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page import="org.apache.poi.ss.usermodel.DateUtil" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>

<%!
    // Helper method to get cell value as string (đã di chuyển lên đầu file)
    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng ngày tháng
                    return sdf.format(cell.getDateCellValue());
                } else {
                    // Trả về giá trị số dưới dạng chuỗi (ví dụ cho ID, SĐT)
                    return String.valueOf(new java.math.BigDecimal(cell.getNumericCellValue()).toPlainString());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    // Cố gắng lấy giá trị số nếu là công thức số, nếu không thì chuỗi
                    return String.valueOf(new java.math.BigDecimal(cell.getNumericCellValue()).toPlainString());
                } catch (IllegalStateException e) {
                    return cell.getStringCellValue();
                } catch (Exception e) {
                    return ""; // Fallback an toàn
                }
            case BLANK:
                return "";
            default:
                return "";
        }
    }
%>

<%
    String message = "";
    Connection conn = null;
    PreparedStatement pstmtSV = null;
    PreparedStatement pstmtThamGiaHoc = null;

    // Lấy mã lớp để gán tất cả sinh viên vào (nếu có từ Them-SV.jsp)
    String maLopFromRequest = request.getParameter("maLopToAssign"); 

    // Kiểm tra đăng nhập
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp"); 
        return;
    }

    try {
        // Lấy file từ request
        Part filePart = request.getPart("excelFile"); 
        
        // --- THAY ĐỔI Ở ĐÂY: Thêm kiểm tra null cho filePart ---
        if (filePart == null) {
            message = "Lỗi: Không tìm thấy file được gửi lên. Vui lòng chọn file.";
            System.err.println("ERROR: filePart is NULL in processExcelImport.jsp!");
            response.sendRedirect("Them-SV.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return; // Dừng xử lý
        }

        String fileName = filePart.getSubmittedFileName();

        if (fileName == null || fileName.isEmpty()) {
            message = "Vui lòng chọn một file Excel.";
            response.sendRedirect("Them-SV.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }

        if (!fileName.toLowerCase().endsWith(".xls") && !fileName.toLowerCase().endsWith(".xlsx")) {
            message = "File không đúng định dạng. Vui lòng chọn file .xls hoặc .xlsx.";
            response.sendRedirect("Them-SV.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }

        InputStream fileContent = filePart.getInputStream();

        conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false); // Bắt đầu transaction

        Workbook workbook = WorkbookFactory.create(fileContent);
        Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên

        Iterator<Row> rowIterator = sheet.iterator();

        // Bỏ qua hàng tiêu đề
        if (rowIterator.hasNext()) {
            rowIterator.next(); 
        }

        // Prepare SQL statements for batch insertion
        String sqlInsertSV = "INSERT INTO sinhvien (MA_SV, TEN_SV, SDT, DIACHI, GIOITINH, NGAYSINH, GMAIL, MA_KH) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        String sqlInsertThamGiaHoc = "INSERT INTO thamgiahoc (MA_LOP, MA_SV) VALUES (?, ?)";
        pstmtSV = conn.prepareStatement(sqlInsertSV);
        pstmtThamGiaHoc = conn.prepareStatement(sqlInsertThamGiaHoc);

        int successfulImports = 0;
        StringBuilder errorDetails = new StringBuilder();

        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            if (row.getPhysicalNumberOfCells() == 0) continue; // Bỏ qua hàng trống

            String maLopExcel = ""; 
            
            try {
                // Đọc dữ liệu từ các cột
                String maSv = getCellValueAsString(row.getCell(0));     // Cột A: MA_SV
                String tenSv = getCellValueAsString(row.getCell(1));    // Cột B: TEN_SV
                String ngaySinhStr = getCellValueAsString(row.getCell(2)); // Cột C: NGAYSINH (định dạng underscored-MM-DD)
                String gioiTinh = getCellValueAsString(row.getCell(3)); // Cột D: GIOITINH
                String diaChi = getCellValueAsString(row.getCell(4));   // Cột E: DIACHI
                String sdtStr = getCellValueAsString(row.getCell(5));   // Cột F: SDT
                String gmail = getCellValueAsString(row.getCell(6));    // Cột G: GMAIL
                maLopExcel = getCellValueAsString(row.getCell(7)); // Cột H: MA_LOP (nếu có trong Excel)
                String maKH = getCellValueAsString(row.getCell(8));    // Cột I: MA_KH (Mã khóa học)

                // Basic Validation
                if (maSv.isEmpty() || tenSv.isEmpty() || maKH.isEmpty()) { 
                    throw new IllegalArgumentException("Mã sinh viên, Tên sinh viên hoặc Mã khóa học không được trống.");
                }

                // Thêm sinh viên vào bảng sinhvien
                pstmtSV.setInt(1, Integer.parseInt(maSv));
                pstmtSV.setString(2, tenSv);
                if (sdtStr != null && !sdtStr.isEmpty()) {
                    pstmtSV.setInt(3, Integer.parseInt(sdtStr));
                } else {
                    pstmtSV.setNull(3, java.sql.Types.INTEGER);
                }
                pstmtSV.setString(4, diaChi);
                pstmtSV.setString(5, gioiTinh);
                pstmtSV.setString(6, ngaySinhStr);
                pstmtSV.setString(7, gmail);
                pstmtSV.setString(8, maKH); 
                pstmtSV.addBatch();

                // Logic gán lớp: ưu tiên maLopFromRequest (từ URL), nếu không có thì dùng từ Excel
                String finalMaLopForAssignment = maLopFromRequest;
                if (finalMaLopForAssignment == null || finalMaLopForAssignment.isEmpty()) {
                    finalMaLopForAssignment = maLopExcel; 
                }

                // Thêm sinh viên vào bảng thamgiahoc nếu có mã lớp để gán
                if (finalMaLopForAssignment != null && !finalMaLopForAssignment.isEmpty()) {
                    pstmtThamGiaHoc.setString(1, finalMaLopForAssignment);
                    pstmtThamGiaHoc.setInt(2, Integer.parseInt(maSv));
                    pstmtThamGiaHoc.addBatch();
                } else {
                    errorDetails.append("Hàng ").append(row.getRowNum() + 1).append(": Không có mã lớp để gán.<br>");
                }

                successfulImports++;

            } catch (Exception e) {
                errorDetails.append("Hàng ").append(row.getRowNum() + 1)
                            .append(": Lỗi - ").append(e.getMessage()).append("<br>");
            }
        }

        // Thực thi batch
        pstmtSV.executeBatch();
        pstmtThamGiaHoc.executeBatch();

        conn.commit(); // Commit transaction
        message = "Nhập dữ liệu thành công. " + successfulImports + " sinh viên được thêm.";
        if (errorDetails.length() > 0) {
            message += "<br>Tuy nhiên, có lỗi ở một số hàng:<br>" + errorDetails.toString();
        }

    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback(); 
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        message = "Lỗi khi nhập dữ liệu từ file Excel: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (pstmtSV != null) try { pstmtSV.close(); } catch (SQLException ignored) {}
        if (pstmtThamGiaHoc != null) try { pstmtThamGiaHoc.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }

    // Chuyển hướng về trang Them-SV.jsp với thông báo
    String redirectUrl = "Them-SV.jsp?message=" + URLEncoder.encode(message, "UTF-8");
    if (maLopFromRequest != null && !maLopFromRequest.isEmpty()) {
        redirectUrl += "&malop=" + URLEncoder.encode(maLopFromRequest, "UTF-8");
    }
    response.sendRedirect(redirectUrl);
    return;
%>