<%@ page session="true" %> <!-- Ensure session is enabled -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="JavaFiles.Social.Post" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Social Page</title>
    <link rel="stylesheet" href="CSS/Home.css">
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- DaisyUI CDN -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.7.3/dist/full.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>
</head>
<body class="bg-gray-100">

<!-- Navbar -->
<div class="fixed top-0 left-0 right-0 z-50 border-b-[1px] bg-amber-500">
    <div class="my-container">
        <div class="hidden lg:flex items-center justify-between">
            <a href='Home.jsp'>
                <h1 class="font-extrabold text-5xl text-white">edms<span class="text-red-500">.</span></h1>
            </a>
            <div class="flex flex-row items-center gap-3">
                <a href="Home.jsp" class="text-white py-5 px-6 hover:border-b-white border-b-[3px] transition duration-500">Home</a>
                <a href="Shelter_and_Areas.jsp" class="text-black py-5 px-6 hover:border-b-white border-b-[3px] transition duration-500">Shelters & Areas</a>
                <a href="Social.jsp" class="text-black py-5 px-6 hover:border-b-white border-b-[3px] transition duration-500">Social</a>
                <a href="Faq.jsp" class="text-black py-5 px-6 hover:border-b-white border-b-[3px] transition duration-500">FAQ</a>
            </div>
            <div class="flex justify-center items-center text-[18px]">
                <% if (session.getAttribute("loggedInUser") != null) { %>
                <a href="Profile_user.jsp" class="hover:text-white transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } else if (session.getAttribute("loggedInRepresentative") != null) { %>
                <a href="Location_Profile.jsp" class="hover:text-white transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } else { %>
                <a href="Login.jsp" class="hover:text-white transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- End of Navbar -->

<!-- Main Content -->
<div class="max-w-3xl mx-auto mt-24 p-4">
    <div class="flex justify-end">
        <button class="bg-gray-200 text-gray-600 px-4 py-2 rounded-lg">Filter ▾</button>
    </div>
    <%
        List<Post> posts = JavaFiles.Social.fetchPosts();
        if (posts != null && !posts.isEmpty()) {
            for (Post post : posts) {
    %>
    <div class="bg-white shadow-lg rounded-lg p-5 my-4 border border-gray-300">
        <div class="flex items-center mb-3">
            <div class="w-12 h-12 rounded-full bg-gray-300 flex items-center justify-center">
                <i class="fa-solid fa-user text-white text-xl"></i>
            </div>
            <div class="ml-3">
                <p class="font-bold text-gray-800 text-lg"><%= post.getUsername() %></p>
                <p class="text-gray-500 text-sm"><%= post.getDate() %></p>
            </div>
        </div>
        <p class="text-gray-700 text-base mb-3"><%= post.getDescription() %></p>
        <div class="grid grid-cols-2 gap-2">
            <% if (post.getPhoto1() != null && !post.getPhoto1().isEmpty()) { %>
            <img src="<%= post.getPhoto1() %>" alt="Post Image" class="rounded-lg w-full h-40 object-cover">
            <% } %>
            <% if (post.getPhoto2() != null && !post.getPhoto2().isEmpty()) { %>
            <img src="<%= post.getPhoto2() %>" alt="Post Image" class="rounded-lg w-full h-40 object-cover">
            <% } %>
        </div>
    </div>
    <%
        }
    } else {
    %>
    <p class="text-center text-gray-500">No posts available.</p>
    <%
        }
    %>
</div>

</body>
</html>
