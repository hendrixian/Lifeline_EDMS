<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="JavaFiles.Social.Post" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Social Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #d3e7f1;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #f4b400;
            height: 50px;
            margin-bottom: 20px;
        }
        .post-container {
            background-color: white;
            border-radius: 12px;
            padding: 15px;
            margin: 20px auto;
            width: 80%;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .profile-pic {
            width: 40px;
            height: 40px;
            background-color: #f4b400;
            border-radius: 50%;
            display: inline-block;
            vertical-align: middle;
        }
        .username {
            display: inline-block;
            margin-left: 10px;
            font-weight: bold;
        }
        .blue-mark {
            color: blue;
        }
        .post-info {
            color: gray;
            font-size: 12px;
        }
        .content {
            margin: 10px 0;
        }
        .image-placeholder {
            background-color: #f4b400;
            height: 100px;
            width: 45%;
            display: inline-block;
            margin-right: 5%;
        }
        .filter-button {
            float: right;
            background-color: #f4b400;
            padding: 5px 10px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="header"></div>

<button class="filter-button">Filter ▼</button>

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
