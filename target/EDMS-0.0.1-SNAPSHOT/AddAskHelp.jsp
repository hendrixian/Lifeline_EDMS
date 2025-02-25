<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
    String loggedInUser = (String) session.getAttribute("loggedInRepresentative");
    if (loggedInUser == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<%--
    if (session.getAttribute("shelterName") == null) {
        response.sendRedirect("AddAskHelp");
    }
%>--%>
<%
    if (session.getAttribute("shelterName") == null && session.getAttribute("redirected") == null) {
        session.setAttribute("redirected", "true");
        response.sendRedirect("AddAskHelp");
        return; // Exit to avoid executing further code
    } else if (session.getAttribute("redirected") != null) {
        // Optional: Reset the flag after the redirect has happened
        session.removeAttribute("redirected");
    }
%>



<!DOCTYPE html>

<head>
    <title>Emergency Disaster Management System</title>
    <link rel="stylesheet" href="CSS/Profile.css" />
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- DaisyUI CDN -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.7.3/dist/full.css" rel="stylesheet" type="text/css" />
    <!-- Animate.css CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- AOS CDN -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>
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
    </style>
</head>

<body class="bg-gray-200 flex flex-col min-h-screen">
<!-- Navbar -->
<div class="border-b-[1px] bg-amber-500">
    <div class="my-container">
        <!-- Large Screen Navbar -->
        <div class="hidden lg:flex items-center justify-between">
            <button onclick="window.location.href='AddPost.jsp'" class="text-white hover:text-red-500 transition duration-300">
                <i class="fa-solid fa-arrow-left text-3xl"></i>
            </button>
            <div class="flex-grow text-center">
                <h1 class="font-extrabold text-5xl text-white py-4 px-5 border-b-amber-500 hover:border-b-white border-b-[2px]">edms<span class="text-red-500">.</span></h1>
            </div>
            <!--  <div class="flex justify-end items-center text-[18px]">
                  <a href="Location_Profile.jsp" class="hover:text-white transition duration-300">
                      <i class="fa-regular fa-circle-user"></i>
                  </a>
              </div>-->
        </div>
        <!-- Small Screen Navbar -->
        <div class="navbar bg-amber-500 lg:hidden min-h-[100px]">
            <div class="navbar-start flex items-center">
                <button onclick="window.location.href='AddPost.jsp'" class="text-white hover:text-red-500 transition duration-300">
                    <i class="fa-solid fa-arrow-left text-[40px]"></i>
                </button>
            </div>
            <!-- <div class="navbar-center flex justify-center">
                 <a href='Home.jsp'>
                     <h1 class="font-extrabold text-[50px] text-white">edms<span class="text-red-500">.</span></h1>
                 </a>
             </div>-->
            <!-- <div class="navbar-end">
                 <a href="Profile.jsp" class="hover:text-[#F17829] transition duration-300">
                     <i class="fa-regular fa-circle-user text-[40px]"></i>
                 </a>
             </div>-->
        </div>
    </div>
</div>
<div class="pt-[30px]">
    <!-- Your page content here -->
</div>
<!-- Main Content Wrapper -->
<div class="flex-grow flex items-center justify-center">
    <div class="w-full max-w-[1000px] bg-white p-6 rounded-[25px] shadow-lg flex flex-col items-center justify-center">

        <h1 class="text-center text-4xl font-extrabold text-amber-500">EDMS<span class="text-red-500">.</span></h1>
        <h2 class="text-center text-lg text-gray-700 mb-4">Don't Hesitate to Ask for Help</h2>
        <form class="space-y-4" action="AddAskHelp" method="post" enctype="multipart/form-data">

            <div class="bg-gray-100 p-4 rounded-[25px] shadow-md flex w-[90%] max-w-[900px] mx-auto">
                <div class="w-2/3 pr-4 pl-4">
                    <div class="flex items-center mb-4">
                        <div class="w-12 h-12 bg-amber-500 rounded-full flex items-center justify-center text-white font-bold text-xl">R</div>
                        <span class="ml-3 text-gray-800 font-semibold">
                                <%= (session.getAttribute("loggedInRepresentative") != null) ? session.getAttribute("loggedInRepresentative") : "No Representative Found" %>
                            </span>
                    </div>
                    <div class="bg-white p-4 rounded-md shadow">
                        <label class="block text-gray-700 mb-2 font-medium">What do you need help with?</label>
                        <textarea class="textarea textarea-bordered h-24 input-floral w-full" placeholder="Write your request..." required name="Description"></textarea>
                        <div class="flex space-x-2 mt-3">

                            <input type="file" id="ImageName1" name="ImageName1" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4" required>

                            <input type="file" id="ImageName2" name="ImageName2" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-gradient-to-r file:from-yellow-300 file:to-white hover:file:bg-gradient-to-r hover:file:from-yellow-200 hover:file:to-white mb-4" required>

                        </div>
                    </div>
                    <div class="pt-[20px]">
                        <!-- Your page content here -->
                    </div>
                    <label for="sheltername" >Shelter Name:</label>
                    <input type="text" id="sheltername" name="sheltername" value="<%= (session.getAttribute("shelterName") != null) ? session.getAttribute("shelterName") : "No Shelter Found" %>" readonly class="input-floral  w-[200px]">
                </div>

                <div class="w-[28%] pl-4 flex flex-col justify-center gap-4"> <!-- Added gap -->
                    <label class="block text-gray-700 font-medium">Affected People Count </label>
                    <div class="mt-2 "> <!-- Added ml-6 to move right -->
                        <label class="block text-gray-700 font-medium">Number of Male</label>
                        <input type="number" class="input-floral w-full" name="help-am" id="help-am" min="0" required>
                    </div>
                    <div class="mt-2 "> <!-- Added ml-6 to move right -->
                        <label class="block text-gray-700 font-medium">Number of Female</label>
                        <input type="number" class="input-floral w-full" name="help-af" id="help-af" min="0" required>
                    </div>
                    <div class="mt-2 "> <!-- Added ml-6 to move right -->
                        <label class="block text-gray-700 font-medium">Number of Children</label>
                        <input type="number" class="input-floral w-full" name="help-ac" id="help-ac" min="0" required>

                    </div>
                </div>

            </div>
            <div class="flex justify-center">
                <input class="btn btn-warning  my-5 w-[300px]" type="submit" value="Post">
            </div>
            <p style="color:red;">${message}</p>
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
