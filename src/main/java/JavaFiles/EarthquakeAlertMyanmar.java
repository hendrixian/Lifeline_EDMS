import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import org.json.JSONArray;
import org.json.JSONObject;

public class EarthquakeAlertMyanmar {

    // USGS Earthquake API for Myanmar
    private static final String API_URL = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&latitude=21.91&longitude=95.95&maxradius=10&limit=5";

    // Gmail credentials
    private static final String USERNAME = "wthuthu47@gmail.com";
    private static final String PASSWORD = "29803952";
    private static final String RECIPIENT = "lyrawin47@gmail.com";

    public static void main(String[] args) {
        try {
            // Step 1: Fetch earthquake data
            String jsonResponse = getEarthquakeData(API_URL);

            // Step 2: Parse JSON response
            JSONObject jsonObject = new JSONObject(jsonResponse);
            JSONArray features = jsonObject.getJSONArray("features");

            if (features.length() > 0) {
                JSONObject latestEarthquake = features.getJSONObject(0);
                JSONObject properties = latestEarthquake.getJSONObject("properties");

                double magnitude = properties.getDouble("mag");
                String place = properties.getString("place");

                // Step 3: Prepare and send email alert
                String subject = "Earthquake Alert - Myanmar";
                String message = "Earthquake Alert!\nMagnitude: " + magnitude + "\nLocation: " + place;

                sendEmail(subject, message);
                System.out.println("Earthquake alert sent successfully.");
            } else {
                System.out.println("No recent earthquakes detected in Myanmar.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Function to fetch earthquake data from the API
    private static String getEarthquakeData(String apiUrl) throws Exception {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        return response.toString();
    }

    // Function to send an email using JavaMail API
    private static void sendEmail(String subject, String messageBody) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(USERNAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(RECIPIENT));
            message.setSubject(subject);
            message.setText(messageBody);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
