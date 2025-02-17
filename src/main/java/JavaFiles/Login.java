package JavaFiles;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.io.Serial;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    @Serial
    private static final long serialVersionUID = 1L;

    private static final Logger LOGGER = Logger.getLogger(Login.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("log_username");
        String password = request.getParameter("log_password");
        String rememberMe = request.getParameter("remember_me");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            request.setAttribute("message", "Username and password are required.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        try (Connection con = getConnection.connect()) { // Ensure this method exists
            LOGGER.info("Database connection successful.");

            if (authenticateUser(con, username, password)) {
                HttpSession session = request.getSession();

                // Store the correct session attribute based on user type
                if (isUserInTable(con, username)) {
                    session.setAttribute("loggedInUser", username);
                } else if (isRepresentativeInTable(con, username)) {
                    session.setAttribute("loggedInRepresentative", username);
                }

                // Handle "Remember Me" functionality
                Cookie userCookie = new Cookie("username", "on".equals(rememberMe) ? username : "");
                userCookie.setMaxAge("on".equals(rememberMe) ? 7 * 24 * 60 * 60 : 0);
                response.addCookie(userCookie);

                // Debugging logs
                LOGGER.info("Session loggedInRepresentative: " + session.getAttribute("loggedInRepresentative"));
                LOGGER.info("Session loggedInUser: " + session.getAttribute("loggedInUser"));

                String redirectURL = (String) session.getAttribute("redirectURL");
                response.sendRedirect(redirectURL != null ? redirectURL : "Home.jsp");
            } else {
                request.setAttribute("message", "Invalid username or password.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "An error occurred during login.", e);
            request.setAttribute("message", "An error occurred. Please try again later.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    private boolean isUserInTable(Connection con, String username) throws Exception {
        String query = "SELECT Username FROM user WHERE Username = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    private boolean isRepresentativeInTable(Connection con, String username) throws Exception {
        String query = "SELECT Representativename FROM representative WHERE Representativename = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Login.jsp");
    }

    private boolean authenticateUser(Connection con, String username, String password) throws Exception {
        String query = "SELECT Password FROM user WHERE Username = ? UNION SELECT Password FROM representative WHERE Representativename = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return BCrypt.checkpw(password, rs.getString("Password"));
                }
            }
        }
        LOGGER.warning("User not found: " + username);
        return false;
    }
}

//commented verify out since we dont do verify anymore - a chaw lay
    //for context, any user with over 20 contri_count is considered verified
/*
    private void verifyUser(Connection con, String username) throws Exception {
        String checkVerifiedQuery = "SELECT Username FROM verified WHERE Username = ?";
        try (PreparedStatement ps = con.prepareStatement(checkVerifiedQuery)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LOGGER.info("User already verified: " + username);
                    return;
                }
            }
        }

        int contributionCount = calculateContributionCount(con, username);

        if (contributionCount >= 20) {
            String verifyQuery = "INSERT INTO verified (Username) VALUES (?)";
            try (PreparedStatement ps = con.prepareStatement(verifyQuery)) {
                ps.setString(1, username);
                ps.executeUpdate();
                LOGGER.info("User verified: " + username);
            }
        } else {
            LOGGER.info("User not eligible for verification: " + username);
        }
    }
    //make it as comment because it is using the table that doesnt exist but might need for smth-TTW
    private int calculateContributionCount(Connection con, String username) throws Exception {
        int count = 0;
        String locationQuery = "SELECT LocationUsername FROM " + username + "_location";

        try (PreparedStatement stmt = con.prepareStatement(locationQuery);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                String locUsername = rs.getString("LocationUsername");
                String askHelpQuery = "SELECT COUNT(*) AS helpCount FROM " + locUsername + "_askhelp";
                try (PreparedStatement helpStmt = con.prepareStatement(askHelpQuery);
                     ResultSet helpRs = helpStmt.executeQuery()) {
                    if (helpRs.next()) {
                        count += helpRs.getInt("helpCount");
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error calculating contributions for user: " + username, e);
        }

        LOGGER.info("Total contributions for " + username + ": " + count);
        return count;
    }

 */

