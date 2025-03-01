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
