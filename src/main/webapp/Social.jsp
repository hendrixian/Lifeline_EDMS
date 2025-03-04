<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="JavaFiles.Social, JavaFiles.Social.Post, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Social Feed</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .post-container {
            width: 60%;
            margin: 20px auto;
            padding: 15px;
            background: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px #ccc;
        }
        img {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
<h1>Recent Posts</h1>

<%
    List<Social.Post> posts = Social.fetchPosts();
    if (posts == null || posts.isEmpty()) {
%>
<p>No posts available.</p>
<%
} else {
    for (Social.Post post : posts) {
%>
<div class="post-container">
    <h3>Posted by: <%= post.getUsername() %> on <%= post.getDate() %></h3>
    <p><%= post.getDescription() %></p>
    <% if (post.getPhoto1() != null && !post.getPhoto1().isEmpty()) { %>
    <img src="<%= request.getContextPath() + "/" + post.getPhoto1Path() %>" alt="Post Image 1">
    <% } %>
    <% if (post.getPhoto2() != null && !post.getPhoto2().isEmpty()) { %>
    <img src="<%= request.getContextPath() + "/" + post.getPhoto2Path() %>" alt="Post Image 2">
    <% } %>
</div>
<%
        }
    }
%>

</body>
</html>
