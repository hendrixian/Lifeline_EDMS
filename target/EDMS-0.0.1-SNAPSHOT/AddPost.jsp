<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@page import="java.sql.*" %>

<%

    Connection con = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    try {
        con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/disaster1", "root", "");
    } catch (SQLException e) {
        e.printStackTrace();
    }

%>

<%

    String loggedInUser = (String) session.getAttribute("loggedInUser");
    String loggedInRepresentative = (String) session.getAttribute("loggedInRepresentative");

    if (loggedInUser == null && loggedInRepresentative== null)  {
        String currentURL = request.getRequestURI();
        session.setAttribute("redirectURL", currentURL);
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency Disaster Management System</title>
    <link rel="stylesheet" href="CSS/Profile.css"/>
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- DaisyUI CDN -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.7.3/dist/full.css" rel="stylesheet"/>
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>
    <script src="LocationData.js" defer></script>
    <style>
        /* Flower Border Pattern with Custom Color */
        .flower-border {
            position: relative;
            padding: 2rem;
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 4px solid transparent; /* Making space for the border */
            border-image: url('https://www.svgrepo.com/show/281107/flower-pattern-border.svg') 30 stretch; /* Custom flower pattern SVG */
            background-color: #fff; /* Ensures the background is white behind the border */
            border-color: #FB923C; /* Custom border color (can be any color you prefer) */
        }

        /* Fancy border for inputs */
        .input-floral {
            border: 2px solid #fca311;
            border-radius: 8px;
            padding: 10px;
            background-color: #fefae0;
            font-size: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .input-floral:focus {
            outline: none;
            border-color: #e85d04;
            box-shadow: 0 0 10px rgba(255, 165, 0, 0.7);
        }

        /* Custom button styling */
        .btn-floral {
            background-color: #fca311;
            color: white;
            border-radius: 8px;
            padding: 12px;
            font-size: 18px;
            border: none;
            width: 100%;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .btn-floral:hover {
            background-color: #e85d04;
            box-shadow: 0 0 10px rgba(255, 165, 0, 0.7);
        }

        /* Make the form container stretch full width */
        .form-container {
            width: 100%; /* Take up full width of the screen */
            max-width: 100%; /* Disable any maximum width constraint */
            margin: 0 auto;
            padding: 40px;
            background-color: white;
            border-radius: 16px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        /* Additional styling for responsiveness */
        @media (min-width: 768px) {
            .form-container {
                width: 40%; /* Optionally restrict the width on larger screens */
                max-width: 1200px; /* Maximum width on large screens */
            }
        }
    </style>
</head>
<body class="bg-gray-200">
<script>


    window.onload = function () {
        console.log(subjectObject); // Log the object to verify it's loaded
        const DivisionSelect = document.getElementById("DivisionSelect");
        const CitySelect = document.getElementById("CitySelect");
        const TownshipSelect = document.getElementById("TownshipSelect");

        // Populate Division dropdown
        for (const division in subjectObject) {
            DivisionSelect.options[DivisionSelect.options.length] = new Option(division, division);
        }

        DivisionSelect.onchange = function () {
            console.log("Division: " + this.value);
            CitySelect.length = 1; // Reset City dropdown
            TownshipSelect.length = 1; // Reset Township dropdown

            const cities = subjectObject[this.value];
            if (cities) {
                console.log(cities); // Log the cities object to verify it's correct
                for (const city in cities) {
                    CitySelect.options[CitySelect.options.length] = new Option(city, city);
                }
            }
        };

        CitySelect.onchange = function () {
            console.log("City: " + this.value);
            TownshipSelect.length = 1; // Reset Township dropdown

            const townships = subjectObject[DivisionSelect.value]?.[this.value];
            if (townships) {
                console.log(townships); // Log the townships array to verify it's correct
                for (let i = 0; i < townships.length; i++) {
                    TownshipSelect.options[TownshipSelect.options.length] = new Option(townships[i], townships[i]);
                }
            }
        };


    };


</script>
<!-- Navbar -->
<div class="border-b-[1px] bg-amber-500">
    <div class="my-container">
        <!-- Large Screen Navbar -->
        <div class="hidden lg:flex items-center justify-between">
            <button onclick="window.location.href='Location_Profile.jsp'" class="text-white hover:text-red-500 transition duration-300">
                <i class="fa-solid fa-arrow-left text-3xl"></i>
            </button>
            <div class="flex-grow text-center">
                <h1 class="font-extrabold text-5xl text-white py-4 px-5 border-b-amber-500 hover:border-b-white border-b-[2px]">edms<span class="text-red-500">.</span></h1>
            </div>
            <div class="flex justify-end items-center text-[18px]">
                <a href="Profile.jsp" class="hover:text-white transition duration-300">
                    <i class="fa-regular fa-circle-user"></i>
                </a>
            </div>
        </div>
        <!-- Small Screen Navbar -->
        <div class="navbar bg-amber-500 lg:hidden min-h-[100px]">
            <div class="navbar-start flex items-center">
                <button onclick="window.location.href='Location_Profile.jsp'" class="text-white hover:text-red-500 transition duration-300">
                    <i class="fa-solid fa-arrow-left text-[40px]"></i>
                </button>
            </div>
            <div class="navbar-center flex justify-center">
                <a href='Home.jsp'>
                    <h1 class="font-extrabold text-[50px] text-white">edms<span class="text-red-500">.</span></h1>
                </a>
            </div>
            <div class="navbar-end">
                <a href="Profile.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- the post content starts here-->
<div class="flex justify-center items-center min-h-screen rounded-[25px]">
    <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-3xl">
<!--<div class="flex-grow flex items-center justify-center">-->
  <!-- <div class="w-full max-w-[1000px] bg-white p-6 rounded-[25px] shadow-lg flex flex-col items-center justify-center">-->

    <div class="text-center mb-4">
            <h1 class="text-4xl font-bold text-amber-500">EDMS<span class="text-red-500">.</span></h1>
            <p class="text-gray-500">Add Post</p>
        </div>
        <div class="bg-gray-100 p-4 rounded-[25px] shadow-md flex w-[90%] max-w-[900px] mx-auto">
            <div class="w-2/3 pr-4 pl-4">
        <div class="flex items-center space-x-3 mb-4">
            <div class="w-12 h-12 bg-amber-500 text-white rounded-full flex justify-center items-center text-lg font-bold">R</div>
            <span class="ml-3 text-gray-800 font-semibold">
                                <%= (session.getAttribute("loggedInRepresentative") != null) ? session.getAttribute("loggedInRepresentative") : "No Representative Found" %>
            </span>
        </div>
            </div>
        </div>

        <form action="AddPost" method="post" enctype="multipart/form-data">

            <div class="bg-white p-4 rounded-md shadow">
                <label class="block text-lg font-medium">What do you wanna post?</label>
                <textarea name="PostString" required class="textarea textarea-bordered h-24 input-floral w-full" placeholder="Write your thoughts..."></textarea>
            </div>

            <label class="block text-lg font-medium">Add 2 photos of your post</label>
            <div class="flex space-x-2 mb-4">
                <input required type="file" name="ImageName1" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4">
                <input required type="file" name="ImageName2" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4">
            </div>


                <div>
                    <label class="block text-lg font-medium">Shelter Name</label>
                    <input type="text" name="ShelterName" required class="w-full border p-2 rounded-lg">
                </div>
            <div class="w-[28%] pl-4 flex flex-col justify-center gap-4">

                    <!-- select Division -->
                    <label class="block text-gray-700 font-medium">
                        <span class="label-text">Add your post related location :</span>
                    </label>

                    <div class="mt-2 ">
                    <select id="DivisionSelect"
                            class="select select-bordered w-full mb-2"
                            name="Divisionitem"
                            required>
                        <option disabled selected>Add Division</option>

                    </select>
                    </div>
                    <!-- select Division js -->
                    <script>
                        document.getElementById("DivisionSelect").addEventListener("change", function () {
                            var selectElement = document.getElementById("DivisionSelect");
                            var selectOption = selectElement.options[selectElement.selectedIndex];

                            var selectedText = selectOption.text;

                            // Use AJAX to send selectedText to server
                            fetch("AddPost.jsp?jsValue=" + encodeURIComponent(selectedText))
                                .then(response => response.text())
                                .then(data => {
                                    console.log(data); // Log the response from the server
                                })
                                .catch(error => {
                                    console.error("Error:", error);
                                });
                        });
                    </script>

                    <%
                        String selectedDivision = request.getParameter("jsValue");%>
                    <input type="hidden" name="selectedDivision" value="<%= selectedDivision %>">

                    <!-- select upazila -->
                    <div class="mt-2 ">
                    <select id="CitySelect"
                            class="select select-bordered w-full mb-2"
                            name="Cityitem"
                            required
                    >
                        <option disabled selected>Add City</option>

                    </select>
                    </div>
                    <!-- select City js -->
                    <script>
                        document.getElementById("CitySelect").addEventListener("change", function () {
                            var selectElement = document.getElementById("CitySelect");
                            var selectOption = selectElement.options[selectElement.selectedIndex];

                            var selectedText = selectOption.text;

                            // Use AJAX to send selectedText to server
                            fetch("AddPost.jsp?UpValue=" + encodeURIComponent(selectedText))
                                .then(response => response.text())
                                .then(data => {

                                    console.log(data); // Log the response from the server
                                })
                                .catch(error => {
                                    console.error("Error:", error);
                                });
                        });
                    </script>

                    <%

                        String selectedCity = request.getParameter("UpValue");%>

                    <!-- select Township -->
                    <div class="mt-2 ">
                    <select id="TownshipSelect"
                            class="select select-bordered w-full mb-2"
                            name="Townshipitem"
                            required
                    >
                        <option disabled selected>Add Township</option>

                    </select>
                    </div>
                    <!-- select Township js -->
                    <script>
                        document.getElementById("TownshipSelect").addEventListener("change", function () {
                            var selectElement = document.getElementById("TownshipSelect");
                            var selectOption = selectElement.options[selectElement.selectedIndex];

                            var selectedText = selectOption.text;

                            // Use AJAX to send selectedText to server
                            fetch("AddPost.jsp?TownshipValue=" + encodeURIComponent(selectedText))
                                .then(response => response.text())
                                .then(data => {


                                    console.log(data); // Log the response from the server
                                })
                                .catch(error => {
                                    console.error("Error:", error);
                                });
                        });

                    </script>

                    <%

                        String selectedTownship = request.getParameter("TownshipValue");%>

                    <input type="hidden" id="selectedTownshipHiddenBox" name="selectedTownship"
                           value=<%=selectedTownship %>/>

                    <script>
                        const TownshipSelectDropDown = document.getElementById('TownshipSelect')
                        TownshipSelectDropDown.addEventListener('change', function () {
                            document.getElementById('selectedTownshipHiddenBox').value = TownshipSelectDropDown.options[TownshipSelectDropDown.selectedIndex].text
                        })
                    </script>


                 </div>
    

            <button type="submit" class="btn btn-warning w-full">POST</button>
            <p class="text-red-500 mt-2">${message}</p>
        </form>
    </div>

</div>
<div class="pt-[30px]">
    <!-- Your page content here -->
</div>
<!-- Footer -->
<footer class="bg-white p-6 border-t border-gray-300 text-center">
    <a href='Home.jsp'>
        <h1 class="font-extrabold text-5xl text-amber-600">edms<span class="text-red-500">.</span></h1>
    </a>
    <h3 class='text-[16px] text-[#7B7B7B] mt-2'>EDMS - Your comprehensive resource for shelter, assistance, and information during times of crisis</h3>
    <h3 class='text-[16px] text-[#868686] mt-2'>&copy; 2025 EDMS. All rights reserved.</h3>
</footer>
</body>
</html>
