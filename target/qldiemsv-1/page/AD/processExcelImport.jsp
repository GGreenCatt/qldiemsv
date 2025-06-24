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

<%
    String message = "";
    Connection conn = null;
    PreparedStatement pstmtSV = null;
    PreparedStatement pstmtThamGiaHoc = null;

    // Kiểm tra đăng nhập
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp"); // Chuyển hướng về trang đăng nhập nếu chưa login
        return;
    }

    try {
        // Lấy file từ request
        Part filePart = request.getPart("excelFile"); // "excelFile" là tên của input type="file" trong form
        String fileName = filePart.getSubmittedFileName();

        if (fileName == null || fileName.isEmpty()) {
            message = "Vui lòng chọn một file Excel.";
            response.sendRedirect("Them-SV.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
            return;
        }

        // Chỉ chấp nhận file .xls hoặc .xlsx
        if (!fileName.toLowerCase().endsWith(".xls") && !fileName.toLowerCase().endsWith(".xlsx")) {
            message = "File không đúng định dạng. Vui lòng chọn file .xls hoặc .xlsx.";
            response.sendRedirect("Them-SV.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
            return;
        }

        InputStream fileContent = filePart.getInputStream();

        conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false); // Bắt đầu transaction

        Workbook workbook = WorkbookFactory.create(fileContent);
        Sheet sheet = workbook.getSheetAt(0); // Lấy sheet đầu tiên

        Iterator<Row> rowIterator = sheet.iterator();

        // Bỏ qua hàng tiêu đề (nếu hàng đầu tiên là tiêu đề)
        if (rowIterator.hasNext()) {
            rowIterator.next(); // Bỏ qua hàng đầu tiên
        }

        // Prepare SQL statements for batch insertion
        String sqlInsertSV = "INSERT INTO sinhvien (MA_SV, TEN_SV, SDT, DIACHI, GIOITINH, NGAYSINH, GMAIL) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String sqlInsertThamGiaHoc = "INSERT INTO thamgiahoc (MA_LOP, MA_SV) VALUES (?, ?)";
        pstmtSV = conn.prepareStatement(sqlInsertSV);
        pstmtThamGiaHoc = conn.prepareStatement(sqlInsertThamGiaHoc);

        int successfulImports = 0;
        StringBuilder errorDetails = new StringBuilder();

        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            if (row.getPhysicalNumberOfCells() == 0) continue; // Bỏ qua hàng trống

            try {
                // Đọc dữ liệu từ các cột
                // Điều chỉnh chỉ số cột (0-indexed) cho phù hợp với file Excel mẫu của bạn
                String maSv = getCellValueAsString(row.getCell(0));     // Cột A: MA_SV
                String tenSv = getCellValueAsString(row.getCell(1));    // Cột B: TEN_SV
                String ngaySinhStr = getCellValueAsString(row.getCell(2)); // Cột C: NGAYSINH (định dạng YYYY-MM-DD)
                String gioiTinh = getCellValueAsString(row.getCell(3)); // Cột D: GIOITINH
                String diaChi = getCellValueAsString(row.getCell(4));   // Cột E: DIACHI
                String sdtStr = getCellValueAsString(row.getCell(5));   // Cột F: SDT
                String gmail = getCellValueAsString(row.getCell(6));    // Cột G: GMAIL
                String maLop = getCellValueAsString(row.getCell(7));    // Cột H: MA_LOP (có thể trống nếu không gán lớp)

                // Basic Validation (có thể mở rộng thêm)
                if (maSv.isEmpty() || tenSv.isEmpty()) {
                    throw new IllegalArgumentException("Mã sinh viên hoặc Tên sinh viên không được trống.");
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
                pstmtSV.addBatch();

                // Thêm sinh viên vào bảng thamgiahoc nếu có mã lớp
                if (maLop != null && !maLop.isEmpty()) {
                    pstmtThamGiaHoc.setString(1, maLop);
                    pstmtThamGiaHoc.setInt(2, Integer.parseInt(maSv));
                    pstmtThamGiaHoc.addBatch();
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
                conn.rollback(); // Rollback nếu có lỗi tổng quát
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
    response.sendRedirect("Them-SV.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
%>

<%!
    // Helper method to get cell value as string (đặt trong scriptlet khai báo)
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
                    // Trả về giá trị số dưới dạng chuỗi, ví dụ cho mã sinh viên, SĐT
                    return String.valueOf(new Double(cell.getNumericCellValue()).longValue());
                }
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                // Cần thận trọng khi xử lý công thức, có thể cần evaluator
                try {
                    return String.valueOf(cell.getNumericCellValue()); // Cố gắng lấy giá trị số nếu là công thức số
                } catch (IllegalStateException e) {
                    return cell.getStringCellValue(); // Hoặc chuỗi nếu là công thức chuỗi
                }
            case BLANK:
                return "";
            default:
                return "";
        }
    }
%>