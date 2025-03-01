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
    <!-- Animate.css CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
    <!-- AOS CDN -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>
</head>
<body>
<%
    // Ensure session is enabled and check for logged-in user or representative
    Object loggedInUser = session.getAttribute("loggedInUser");
    Object loggedInRepresentative = session.getAttribute("loggedInRepresentative");
%>

<!-- Navbar -->
<div class="fixed top-0 left-0 right-0 z-50 border-b-[1px] bg-amber-500">
    <div class="my-container">
        <!-- For Large Device -->
        <div class="hidden lg:flex items-center justify-between">
            <!-- Logo -->
            <a href='Home.jsp'>
                <h1 class="font-extrabold text-5xl text-white">edms<span class="text-red-500">.</span></h1>
            </a>

            <!-- Nav links for medium and large devices -->
            <div class="flex flex-row items-center justify-between gap-3 md:gap-0">
                <a href="Home.jsp" class="text-white h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px] hover:text-white transition duration-500">Home</a>
                <a href="Shelter_and_Areas.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px] hover:text-white transition duration-500">Shelters & Areas</a>
                <a href="Social.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px] hover:text-white transition duration-500">Social</a>
                <a href="Faq.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px] hover:text-white transition duration-500">FAQ</a>
            </div>

            <!-- User icon -->
            <div class="flex justify-center items-center text-[18px]">
                <%-- Show profile button for User --%>
                <% if (loggedInUser != null) { %>
                <div class="tooltip tooltip-left" data-tip="Profile">
                    <a href="Profile_user.jsp" class="hover:text-white transition duration-300">
                        <i class="fa-regular fa-circle-user text-[40px]"></i>
                    </a>
                </div>
                <% } %>

                <%-- Show profile button for Representative --%>
                <% if (loggedInRepresentative != null) { %>
                <a href="Location_Profile.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>

                <%-- Show Login button if no one is logged in --%>
                <% if (loggedInUser == null && loggedInRepresentative == null) { %>
                <a href="Login.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
            </div>
        </div>

        <!-- For Medium and small devices -->
        <div class="navbar bg-base-100 lg:hidden bg-amber-500 min-h-[100px]">
            <div class="navbar-start">
                <div class="dropdown">
                    <label tabindex="0" class="btn btn-ghost btn-circle">
                        <i class="fa-solid fa-bars text-[40px]"></i>
                    </label>
                    <ul tabindex="0" class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-[400px] flex flex-col gap-5 p-5">
                        <li><a href="Home.jsp" class="text-[40px] text-[#F17829] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Homepage</a></li>
                        <li><a href="Shelter_and_Areas.jsp" class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Shelters & Areas</a></li>
                        <li><a href="Social.jsp" class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Social</a></li>
                        <li><a href="Faq.jsp" class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">FAQ</a></li>
                    </ul>
                </div>
            </div>
            <div class="navbar-center">
                <a href='Home.jsp'>
                    <h1 class="font-extrabold text-[50px] text-white">edms<span class="text-red-500">.</span></h1>
                </a>
            </div>
            <div class="navbar-end">
                <%-- Show profile button for User --%>
                <% if (loggedInUser != null) { %>
                <a href="Profile_user.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>

                <%-- Show profile button for Representative --%>
                <% if (loggedInRepresentative != null) { %>
                <a href="Location_Profile.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>

                <%-- Show Login button if no one is logged in --%>
                <% if (loggedInUser == null && loggedInRepresentative == null) { %>
                <a href="Login.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- End of Navbar -->

<!-- Main Content -->
<%
    List<Post> posts = JavaFiles.Social.fetchPosts();
    if (posts != null && !posts.isEmpty()) {
        for (Post post : posts) {
%>
<div class="post-container border p-4 my-4 rounded-lg bg-white shadow-lg">
    <div class="flex items-center mb-2">
        <div class="profile-pic w-10 h-10 rounded-full bg-gray-300"></div>
        <span class="username font-bold ml-2"><%= post.getUsername() %></span>
        <span class="post-info text-sm text-gray-500 ml-2"><%= post.getDate() %></span>
    </div>
    <div class="content text-gray-700">
        <%= post.getDescription() %>
    </div>
    <% if (post.getPhoto1() != null && !post.getPhoto1().isEmpty()) { %>
    <img src="<%= post.getPhoto1Path() %>" class="image-placeholder w-full my-2 rounded-lg" alt="Post Image 1" />
    <% } %>
    <% if (post.getPhoto2() != null && !post.getPhoto2().isEmpty()) { %>
    <img src="<%= post.getPhoto2Path() %>" class="image-placeholder w-full my-2 rounded-lg" alt="Post Image 2" />
    <% } %>
</div>
<%
    }
} else {
%>
<p class="text-center text-gray-500">No posts available.</p>
<%
    }
%>

</body>
</html>
