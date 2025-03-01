<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="JavaFiles.Social.Post" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
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
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    String loggedInRepresentative = (String) session.getAttribute("loggedInRepresentative");
    String currentPage = "Social";
%>
<!-- Start of Navbar -->
<div class="fixed top-0 left-0 right-0 z-50 border-b-[1px] bg-amber-500">
    <div class="my-container">
        <div class="hidden lg:flex items-center justify-between">
            <a href='Home.jsp'>
                <h1 class="font-extrabold text-5xl text-white">edms<span class="text-red-500">.</span></h1>
            </a>
            <div class="flex flex-row items-center justify-between gap-3 md:gap-0">
                <a href="Home.jsp" class="<%= currentPage.equals("Home") ? "text-white py-5 px-6 border-b-white border-b-[3px]" : "text-black py-5 px-6 hover:text-white" %>">Home</a>
                <a href="Shelter_and_Areas.jsp" class="<%= currentPage.equals("Shelters") ? "text-white py-5 px-6 border-b-white border-b-[3px]" : "text-black py-5 px-6 hover:text-white" %>">Shelters & Areas</a>
                <a href="Social.jsp" class="<%= currentPage.equals("Social") ? "text-white py-5 px-6 border-b-white border-b-[3px]" : "text-black py-5 px-6 hover:text-white" %>">Social</a>
                <a href="Faq.jsp" class="<%= currentPage.equals("FAQ") ? "text-white py-5 px-6 border-b-white border-b-[3px]" : "text-black py-5 px-6 hover:text-white" %>">FAQ</a>
            </div>
            <div class="flex justify-center items-center text-[18px]">
                <% if (loggedInUser != null) { %>
                <a href="Profile_user.jsp" class="hover:text-white">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
                <% if (loggedInRepresentative != null) { %>
                <a href="Location_Profile.jsp" class="hover:text-[#F17829]">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
                <% if (loggedInUser == null && loggedInRepresentative == null) { %>
                <a href="Login.jsp" class="hover:text-[#F17829]">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- End of Navbar -->
<div class="header"></div>
<!-- Filter Dropdown -->
<div class="relative w-48 mx-auto my-4">
    <select class="select select-bordered w-full" onchange="filterPosts(this.value)">
        <option value="all">All Posts</option>
        <option value="requests">Requests for Help</option>
        <option value="offers">Offers to Help</option>
    </select>
</div>
<script>
    function filterPosts(filter) {
        window.location.href = 'Social.jsp?filter=' + filter;
    }
</script>
<%
    List<Post> posts = (List<Post>) request.getAttribute("posts");
    if (posts != null) {
        for (Post post : posts) {
%>
<div class="post-container">
    <div class="profile-pic"></div>
    <span class="username blue-mark"><%= post.getUsername() %></span>
    <span class="post-info"><%= post.getDate() %></span>
    <div class="content">
        <%= post.getDescription() %>
    </div>
    <% if (post.getPhoto1() != null) { %>
    <img src="<%= post.getPhoto1Path() %>" class="image-placeholder" alt="Post Image 1" />
    <% } %>
    <% if (post.getPhoto2() != null) { %>
    <img src="<%= post.getPhoto2Path() %>" class="image-placeholder" alt="Post Image 2" />
    <% } %>
</div>
<%
        }
    }
%>
</body>
</html>
