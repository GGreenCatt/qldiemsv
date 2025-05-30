package controller; // Đảm bảo package đúng

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/qldiemsv"; // Thay YourDatabase bằng tên DB của bạn
    private static final String USER = "root"; // Thay bằng user của MySQL
    private static final String PASSWORD = "123456"; // Thay bằng password của MySQL

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load driver
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Lỗi: Không tìm thấy Driver JDBC!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Lỗi kết nối MySQL! Kiểm tra URL, username, password.");
            e.printStackTrace();
        }
        return conn;
    }
}