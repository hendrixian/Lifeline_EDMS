package JavaFiles;
import java.util.logging.LogManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
//import java.util.logging.ConsoleHandler;
//import java.util.logging.Handler;
//import java.io.FileInputStream;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
@MultipartConfig
@WebServlet(name = "AddAskHelp", urlPatterns = {"/AddAskHelp"})
public class AddAskHelp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//private static final Logger LOGGER = Logger.getLogger(AddAskHelp.class.getName());
	private static final Logger logger = Logger.getLogger(AddAskHelp.class.getName());

	public static class ShelterUtils {

		public static String getShelterName(String username, Connection con) throws SQLException {
			String sheltername = null;
			String sql = "SELECT Sheltername FROM representative WHERE Representativename = ?";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, username);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				sheltername = rs.getString("Sheltername");
			}

			return sheltername;
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;


		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInRepresentative") == null) {
			// If session doesn't exist or representative is not logged in, redirect to login
			request.setAttribute("message", "Session expired. Please log in again.");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			return;
		}

		// Fetch representative name directly from session
		String username = (String) session.getAttribute("loggedInRepresentative");

		try {
			// Connect to the database
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/disaster1", "root", "");
			if (con == null || con.isClosed()) {
				logger.info("Database connection is null or closed!");
				// You can also send an error message to the user or log this error
				request.setAttribute("message", "Database connection issue. Please try again later.");
				request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
				return; // Exit if connection is not valid
			}


			// Fetch shelter name for the logged-in representative
			String sheltername = ShelterUtils.getShelterName(username, con);

			if (sheltername != null && !sheltername.isEmpty()) {
				// Automatically populate shelterName in session
				session.setAttribute("shelterName", sheltername);
				request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
			} else {
				session.setAttribute("message", "Shelter not found for the user.");
			}

			// Also set the representative name in the session
			session.setAttribute("loggedInRepresentative", username);

			// Forward to the JSP page
			request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", "Error: " + e.getMessage());
			request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;

		// Extract form parameters
		String description = request.getParameter("Description");
		String ams = request.getParameter("help-am");
		String afs = request.getParameter("help-af");
		String acs = request.getParameter("help-ac");

		// Convert string inputs to integers
		int am = Integer.parseInt(ams);
		int af = Integer.parseInt(afs);
		int ac = Integer.parseInt(acs);

		HttpSession session = request.getSession(false);
		if (session == null ||  session.getAttribute("loggedInRepresentative") == null) {
			request.setAttribute("message", "Session expired. Please log in again.");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
			return;
		}

		// Retrieve Representative name and Shelter name from session
		String representativename = (String) session.getAttribute("loggedInRepresentative");
		String sheltername = (String) session.getAttribute("shelterName");


		try {
			// Load MySQL Driver
			Class.forName("org.mariadb.jdbc.Driver");

			// Establish database connection
			con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/disaster1", "root", "");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			request.setAttribute("message", "Database connection error: " + e.getMessage());
			request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
			return;
		}

		// Get image parts from the request
		Part part1 = request.getPart("ImageName1");
		Part part2 = request.getPart("ImageName2");

		// Validate image formats
		if (!isValidImage(part1.getContentType())) {
			request.setAttribute("message", "Provide a proper image (Photo 1)");
			request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
			return;
		} else if (!isValidImage(part2.getContentType())) {
			request.setAttribute("message", "Provide a proper image (Photo 2)");
			request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
			return;
		}

		try (InputStream is1 = part1.getInputStream(); InputStream is2 = part2.getInputStream()) {
			// Prepare SQL query to insert into the database
			String sql = "INSERT INTO user_loc_1_askhelp (Representativename, sheltername, Description, Photo1, Photo2, affectedmale, affectedfemale, affectedchildren, Date, Second) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, representativename);
			ps.setString(2, sheltername);
			ps.setString(3, description);
			ps.setBlob(4, is1);
			ps.setBlob(5, is2);
			ps.setInt(6, am);
			ps.setInt(7, af);
			ps.setInt(8, ac);

			// Get current date and format it
			Date currentDate = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // Correct format
			String formattedDateTime = dateFormat.format(currentDate);
			ps.setString(9, formattedDateTime);

			// Convert date to seconds since epoch for 'Second' field
			long secondsSinceEpoch = currentDate.getTime() / 1000;
			ps.setLong(10, secondsSinceEpoch);

			// Execute update
			int rowsInserted = ps.executeUpdate();
			if (rowsInserted > 0) {
				request.setAttribute("message", "Data saved successfully!");
				// Redirect to the location profile page (or any other page)
				response.sendRedirect("Home.jsp"); // Adjust the URL to the correct page
			} else {
				request.setAttribute("message", "Failed to save data. Please try again.");
				// Redirect or forward to a confirmation page
				request.getRequestDispatcher("AddAskHelp.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "Error during data insertion: " + e.getMessage());
		} finally
		{
			try {
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}


	}

	private boolean isValidImage(String contentType) {
		// Validate image content type
		return contentType != null && (contentType.startsWith("image/jpeg") ||  contentType.startsWith("image/png") ||
				contentType.startsWith("image/gif") ||  contentType.startsWith("image/jpg") ||
				contentType.startsWith("image/svg") || contentType.startsWith("image/webp"));
	}
}
