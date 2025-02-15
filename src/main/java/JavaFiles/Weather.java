package JavaFiles;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/WeatherServlet")
public class Weather extends HttpServlet {
    private static final String API_KEY = "be5abba3f222fdb00c12567a19cb6c49";
    private static final String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

    private static final String[] CITIES = {"Yangon", "Mandalay", "Sagaing", "Pago", "Naypyidaw"};

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, JsonObject> weatherDataMap = new HashMap<>();

        for (String city : CITIES) {
            JsonObject weatherData = fetchWeather(city);
            if (weatherData != null) {
                weatherDataMap.put(city, weatherData);
            }
        }

        request.setAttribute("weatherDataMap", weatherDataMap);
        request.getRequestDispatcher("Weather.jsp").forward(request, response);
    }

    public JsonObject fetchWeather(String city) {
        try {
            String urlString = BASE_URL + "?q=" + city + "&appid=" + API_KEY + "&units=metric";
            URL url = new URL(urlString);

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            int responseCode = connection.getResponseCode();
            if (responseCode == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder responseString = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    responseString.append(line);
                }
                reader.close();

                return JsonParser.parseString(responseString.toString()).getAsJsonObject();
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
