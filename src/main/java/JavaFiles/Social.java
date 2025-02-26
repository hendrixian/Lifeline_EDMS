package JavaFiles;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "Social", urlPatterns = {"/Social"})
public class Social extends HttpServlet {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/edms";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static final String IMAGE_PATH = "post_images/"; // Relative path for images

    public static class Post {
        private int id;
        private String username;
        private String description;
        private String photo1;
        private String photo2;
        private String date;

        public Post(int id, String username, String description, String photo1, String photo2, String date) {
            this.id = id;
            this.username = username;
            this.description = description;
            this.photo1 = photo1;
            this.photo2 = photo2;
            this.date = date;
        }

        public int getId() { return id; }
        public String getUsername() { return username; }
        public String getDescription() { return description; }
        public String getPhoto1() { return photo1; }
        public String getPhoto2() { return photo2; }
        public String getDate() { return date; }

        public String getPhoto1Path() { return IMAGE_PATH + photo1; }
        public String getPhoto2Path() { return IMAGE_PATH + photo2; }
    }

    public static List<Post> fetchPosts() {
        List<Post> posts = new ArrayList<>();
        try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = con.prepareStatement("SELECT id, username, description, photo1, photo2, date FROM user_post ORDER BY date DESC");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                posts.add(new Post(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("description"),
                        rs.getString("photo1"),
                        rs.getString("photo2"),
                        rs.getString("date")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        List<Post> posts = fetchPosts();

        out.println("<html><head><title>Social Feed</title></head><body>");
        out.println("<h1>Recent Posts</h1>");

        for (Post post : posts) {
            out.println("<div style='border:1px solid #ddd; padding:10px; margin:10px;'>");
            out.println("<h3>Posted by: " + post.getUsername() + " on " + post.getDate() + "</h3>");
            out.println("<p>" + post.getDescription() + "</p>");
            if (post.getPhoto1() != null) {
                out.println("<img src='" + post.getPhoto1Path() + "' width='200' alt='Post Image 1' /><br>");
            }
            if (post.getPhoto2() != null) {
                out.println("<img src='" + post.getPhoto2Path() + "' width='200' alt='Post Image 2' /><br>");
            }
            out.println("</div>");
        }

        out.println("</body></html>");
    }
}
