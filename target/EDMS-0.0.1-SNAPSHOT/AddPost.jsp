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
        con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/edms", "root", "");
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
    <!-- Animate.css CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- AOS CDN -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css"/>
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
            resize:none;
            overflow-y:scroll;
            scrollbar-width:none;
        }
        .input-floral::-webkit-scrollbar {
            display: none; /* For Chrome, Safari, and Edge: hides scrollbar */
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
        /* Flex container for dropdowns */
        .dropdown-container {
            display: flex;
            justify-content: space-between; /* Space between each dropdown */
            gap: 10px; /* Adds spacing between dropdowns */
        }

        /* Ensure each select box takes equal width */
        .dropdown-container select {
            flex: 1;
        }

        /* Optional: Add padding for smaller screens */
        @media (max-width: 768px) {
            .dropdown-container {
                flex-direction: column; /* Stack the dropdowns vertically on smaller screens */
                gap: 15px; /* More spacing for readability */
            }
        }
        /* Add these styles to ensure full width and height */
        .form-wrapper {
            display: flex;
            flex-direction: column;
            height: 100%; /* Ensure it stretches */
        }

        .form-wrapper > * {
            width: 100%; /* Ensure all child elements take full width */
            box-sizing: border-box; /* Include padding in width calculation */
        }

        /* Ensure textarea takes full width */
        .textarea {
            width: 100%;
        }

        /* Styling the container with some padding and layout */
        .switch-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* Aligns the label and toggle to the left */
            margin-bottom: 16px; /* Add spacing around the switch */
        }

        /* Styling the label for the toggle */
        .switch-label {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        /* Styling for the switch wrapper */
        .switch {
            /*display: flex;
            align-items: center;*/
            display: inline-flex;
            align-items: center;
            font-family: Arial, sans-serif;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .switch span {
            font-size: 16px;
            font-weight: 500;
            margin-right: 12px;
        }

        /* Enlarging the slider and improving aesthetics */
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 28px;
            background-color: #ccc;
            border-radius: 28px;
            cursor: pointer;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
            transition: background-color 0.4s;
            text-align: center;
            font-size: 14px;
            line-height: 28px;
            color: white;
        }

        .slider:before {
            content: "No";
            position: absolute;
            height: 24px;
            width: 24px;
            left: 2px;
            bottom: 2px;
            background-color: white;
            border-radius: 50%;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            transition: transform 0.4s;
            display: flex;
            align-items: center;
            justify-content: center;
            color: black;
            font-size: 12px;
        }

        /* Styling when the toggle is active */
        input:checked + .slider {
            /*background-color: #4caf50;*/
            background-color:#FB923C;
        }

        input:checked + .slider:before {
            transform: translateX(32px);
            content: "Yes";
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

        </div>
        <!-- Small Screen Navbar -->
        <div class="navbar bg-amber-500 lg:hidden min-h-[100px]">
            <div class="navbar-start flex items-center">
                <button onclick="window.location.href='Location_Profile.jsp'" class="text-white hover:text-red-500 transition duration-300">
                    <i class="fa-solid fa-arrow-left text-[40px]"></i>
                </button>
            </div>
            <div class="navbar-center flex justify-center">
                <!--a href='Home.jsp'-->
                <h1 class="font-extrabold text-[50px] text-white">edms<span class="text-red-500">.</span></h1>

            </div>

        </div>
    </div>
</div>
<form action="AddPost" method="post" enctype="multipart/form-data">
    <!-- the post content starts here-->
    <div class="flex justify-center items-center min-h-screen rounded-[25px]">
        <div class="bg-white p-6 rounded-lg shadow-lg w-full max-w-3xl mt-5">
            <!--<div class="flex-grow flex items-center justify-center">-->
            <!-- <div class="w-full max-w-[1000px] bg-white p-6 rounded-[25px] shadow-lg flex flex-col items-center justify-center">-->

            <div class="text-center mb-4">
                <h1 class="text-4xl font-bold text-amber-500">EDMS<span class="text-red-500">.</span></h1>
                <p class="text-gray-500">Add Post</p>
            </div>
            <div class="bg-gray-100 p-4 rounded-[25px] shadow-md flex w-[90%] max-w-[900px] mx-auto">
                <!--div class="w-2/3 pr-4 pl-4"-->
                <div class="form-wrapper">
                    <%
                        if (session.getAttribute("loggedInUser") != null) {
                    %>
                    <div class="flex items-center space-x-3 mb-4">
                        <div class="w-12 h-12 bg-amber-500 text-white rounded-full flex justify-center items-center text-lg font-bold">
                            U
                        </div>
                        <span class="ml-3 text-gray-800 font-semibold">
         <%= session.getAttribute("loggedInUser") %>
    </span>
                    </div>

                    <%
                        // If loggedInRepresentative is not null, show the representative structure
                    } else if (session.getAttribute("loggedInRepresentative") != null) {
                    %>

                    <div class="flex items-center space-x-3 mb-4">
                        <div class="w-12 h-12 bg-amber-500 text-white rounded-full flex justify-center items-center text-lg font-bold">R</div>
                        <span class="ml-3 text-gray-800 font-semibold">
                                 <%= session.getAttribute("loggedInRepresentative") %>
            </span>
                    </div>
                    <%
                        }
                    %>



                    <%
                        // If loggedInRepresentative is not null, show the toggle switch
                        if (loggedInRepresentative != null) {
                    %>
                    <div class="switch-container">
                        <!--label class="switch-label" for="toggleAskHelp">Switch Type</label> <!Main label for the entire switch -->
                        <label for="toggleAskHelp" class="switch">
                            <span style="font-weight:bold">Are you asking for help?</span>
                            <input type="checkbox" id="toggleAskHelp">
                            <span class="slider"></span>
                        </label>
                    </div>
                    <%
                        }
                    %>
                    <div class="bg-white p-4 rounded-md shadow mb-4 mt-5">
                        <label class="block text-lg font-medium">What do you wanna post?</label>
                        <textarea name="PostString" required class="textarea textarea-bordered h-24 input-floral w-full" placeholder="Write your thoughts..."></textarea>
                    </div>

                    <label class="block text-lg font-medium">Add 2 photos of your post</label>
                    <div class="flex space-x-2 mb-4 mt-5">

                        <input required type="file" id="myFile" name="ImageName1" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4">

                        <input required type="file" id="myFile" name="ImageName2" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4">
                    </div>


                    <!--div>
                        <label class="block text-lg font-medium">Shelter Name</label>
                        <input type="text" name="ShelterName" required class="w-full border p-2 rounded-lg">
                    <--/div>
                <div class="w-[28%] pl-4 flex flex-col justify-center gap-4"-->
                    <div class="dropdown-container">

                        <!-- select Division -->
                        <label class="block text-gray-700 font-large">
                            <span class="label-text">Add your post related location :</span>
                        </label>

                        <div class="mt-2 ">
                            <select id="DivisionSelect"
                                    class="select select-bordered input-floral w-full mb-2"
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
                                    class="select select-bordered input-floral w-full mb-2"
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
                                    class="select select-bordered input-floral w-full mb-2"
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

                </div>
            </div>

            <button type="submit" class="btn btn-warning w-full mt-5">POST</button>
            <p class="text-red-500 mt-2">${message}</p>
</form>
<script>
    const toggle = document.getElementById('toggleAskHelp');

    // Restore the toggle state from sessionStorage
    document.addEventListener('DOMContentLoaded', function () {
        const savedState = sessionStorage.getItem('toggleAskHelpState');
        toggle.checked = savedState === 'true';

        // Reset toggle state when returning to AddPost.jsp
        if (window.location.href.includes('AddPost.jsp')) {
            sessionStorage.setItem('toggleAskHelpState', 'false');
            toggle.checked = false;
        }
    });

    toggle.addEventListener('change', function () {
        if (this.checked) {
            // Save the toggle state and redirect
            sessionStorage.setItem('toggleAskHelpState', 'true');
            window.location.href = 'AddAskHelp.jsp';
        } else {
            sessionStorage.setItem('toggleAskHelpState', 'false');
        }
    });
</script>

</div>

</div>
</div>
</div>
<!--div class="pt-[30px]"-->
<!-- Your page content here -->
<!--/div-->
<!-- Footer -->
<footer class="bg-white p-6 border-t border-gray-300 text-center mt-5">
    <a href='Home.jsp'>
        <h1 class="font-extrabold text-5xl text-amber-600">edms<span class="text-red-500">.</span></h1>
    </a>
    <h3 class='text-[16px] text-[#7B7B7B] mt-2'>EDMS - Your comprehensive resource for shelter, assistance, and information during times of crisis</h3>
    <h3 class='text-[16px] text-[#868686] mt-2'>&copy; 2025 EDMS. All rights reserved.</h3>
</footer>
</body>
</html>
