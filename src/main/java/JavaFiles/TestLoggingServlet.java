import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.*;

@WebServlet("/TestLoggingServlet")
public class TestLoggingServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(TestLoggingServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Get existing session, but do NOT create a new one
        HttpSession session = request.getSession(false);

        if (session == null) {
            LOGGER.warning("⚠️ No session found!");
            out.println("<h1>No session found</h1>");
        } else {
            LOGGER.info("✅ Session exists: " + session.getId());
            out.println("<h1>Session Found: " + session.getId() + "</h1>");
        }

        out.println("<p>Check the server logs.</p>");
    }
}
