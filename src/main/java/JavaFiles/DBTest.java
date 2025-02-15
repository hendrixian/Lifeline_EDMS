import java.sql.*;

public class DBTest {
    public static void main(String[] args) {
        Connection con = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/disaster1", "root", "");
            if (con != null) {
                System.out.println("Connection Test: Database connection established.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("Connection Test: Database connection failed.");
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
