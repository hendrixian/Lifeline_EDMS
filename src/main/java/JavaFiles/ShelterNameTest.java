package JavaFiles;

import java.sql.*;

public class ShelterNameTest {
    public static void main(String[] args) {
        Connection con = null;
        String sheltername = "";

        // Use a hardcoded username for testing
        String username = "hello"; // Test with 'hello' as the username

        try {

            // Establish database connection
            con = getConnection.connect();
            System.out.println("Database connection established.");

            // Fetch sheltername based on the hardcoded username
            String sql = "SELECT sheltername FROM representative WHERE Representativename = ?";
            assert con != null;
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username); // Set the username for the query

            // Execute the query
            ResultSet rs = ps.executeQuery();

            // Check if sheltername is found
            if (rs.next()) {
                sheltername = rs.getString("sheltername");
                System.out.println("Shelter Name Fetched: " + sheltername);
            } else {
                System.out.println("No shelter found for Representativename: " + username);
            }

        } catch (SQLException e) {
            // Handle errors
            System.out.println("Database connection error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close the connection and other resources
            try {
                if (con != null) {
                    con.close();
                    System.out.println("Database connection closed.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
