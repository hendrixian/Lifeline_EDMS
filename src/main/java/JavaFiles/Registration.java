package JavaFiles;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.mindrot.jbcrypt.BCrypt;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MultipartConfig
@WebServlet(name="Registration",urlPatterns= {"/Registration"})
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PrintWriter out;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		PrintWriter out = response.getWriter();

		try {
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/edms", "root", "");

			String username = request.getParameter("Username");
			String email = request.getParameter("Email");
			String password1 = request.getParameter("password1");
			String password2 = request.getParameter("password2");
			String userType = request.getParameter("UserType");

			String division = request.getParameter("Division");
			String city = request.getParameter("City");
			String township = request.getParameter("Township");
			String contactNo = request.getParameter("ContactNo");

			Part part = request.getPart("Image");
			String description = request.getParameter("Description");

			// Password match validation
			if (!password1.equals(password2)) {
				request.setAttribute("message", "Passwords do not match");
				request.getRequestDispatcher("Registration.jsp").forward(request, response);
				return;
			}

			// Check for duplicate username
			String checkQuery = "SELECT COUNT(*) FROM user WHERE Username = ?";
			try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
				checkStmt.setString(1, username);
				ResultSet rs = checkStmt.executeQuery();
				if (rs.next() && rs.getInt(1) > 0) {
					request.setAttribute("message", "Username already exists");
					request.getRequestDispatcher("Registration.jsp").forward(request, response);
					return;
				}
			}

			// Get Zipcode from the 'myanmar' table
			String zipcode = null;
			String zipcodeQuery = "SELECT Zipcode FROM myanmar WHERE Divisions = ? AND Cities = ? AND Townships = ?";
			try (PreparedStatement zipcodeStmt = con.prepareStatement(zipcodeQuery)) {
				zipcodeStmt.setString(1, division);
				zipcodeStmt.setString(2, city);
				zipcodeStmt.setString(3, township);

				ResultSet rs = zipcodeStmt.executeQuery();
				if (rs.next()) {
					zipcode = rs.getString("Zipcode");
				} else {
					request.setAttribute("message", "Invalid Division, City, or Township. Please check your input.");
					request.getRequestDispatcher("Registration.jsp").forward(request, response);
					return;
				}
			}


			// Insert user into the database
			String insertQuery = "INSERT INTO user (Username, Email, Password, UserType, ContactNo, Zipcode, Image, Description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			try (PreparedStatement ps = con.prepareStatement(insertQuery)) {
				// Prepare password hash
				String hashedPassword = BCrypt.hashpw(password1, BCrypt.gensalt());

				// Handle file upload (image)
				InputStream is = null;
				if (part != null && part.getSize() > 0) {
					is = part.getInputStream();
				}

				// Set parameters
				ps.setString(1, username);
				ps.setString(2, email);
				ps.setString(3, hashedPassword);
				ps.setString(4, userType);
				ps.setString(5, contactNo);
				ps.setString(6, zipcode);
				ps.setBlob(7, is);
				ps.setString(8, description);

				int res = ps.executeUpdate();
				if (res > 0) {
					response.sendRedirect("Login.jsp");
				} else {
					request.setAttribute("message", "Registration failed. Try again.");
					request.getRequestDispatcher("Registration.jsp").forward(request, response);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "An error occurred. Try again.");
			request.getRequestDispatcher("Registration.jsp").forward(request, response);
		} finally {
			try {
				if (con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}