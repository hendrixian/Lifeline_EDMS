<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weather Updates</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 20px;
        }
        .city-container {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
    </style>
    <script>
        // Auto-refresh the page every 30 minutes
        setTimeout(function() {
            location.reload();
        }, 1800000);  // 1800000 ms = 30 minutes
    </script>
</head>
<body>
<h1>Weather Updates</h1>

<%
    Map<String, JsonObject> weatherDataMap = (Map<String, JsonObject>) request.getAttribute("weatherDataMap");

    if (weatherDataMap != null) {
        for (Map.Entry<String, JsonObject> entry : weatherDataMap.entrySet()) {
            String city = entry.getKey();
            JsonObject weatherData = entry.getValue();
            double temperature = weatherData.getAsJsonObject("main").get("temp").getAsDouble();
            String description = weatherData.getAsJsonArray("weather")
                    .get(0).getAsJsonObject()
                    .get("description").getAsString();
%>
<div class="city-container">
    <h2><%= city %></h2>
    <p><strong>Temperature:</strong> <%= temperature %> °C</p>
    <p><strong>Description:</strong> <%= description %></p>
</div>
<%
    }
} else {
%>
<p>No weather data available. Please try again later.</p>
<%
    }
%>
</body>
</html>
