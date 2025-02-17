<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Emergency Disaster Management System</title>
    <link rel="stylesheet" href="CSS/Profile.css"/>
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- DaisyUI CDN -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.7.3/dist/full.css" rel="stylesheet" type="text/css"/>
    <!-- Animate.css CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- AOS CDN -->
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css"/>
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>

    <!-- Custom JavaScript -->
    <script>
        function showRegistrationOptions(event) {
            event.preventDefault(); // Prevent default link behavior
            const modal = document.getElementById("registrationModal");
            modal.classList.remove("hidden"); // Show the modal

            // Handle Representative registration
            document.getElementById("representativeBtn").addEventListener("click", function() {
                window.location.href = "representative.jsp";
            });

            // Handle User registration
            document.getElementById("userBtn").addEventListener("click", function() {
                window.location.href = "Registration.jsp";
            });
        }
    </script>

    <style>
        /* Ensure the icon is vertically centered and doesn't overlap with the input */
        #togglePassword {
            top: 50%;
            transform: translateY(-50%);
            right: 10px;
            cursor: pointer;
        }

        /* Add padding to the right of the input to prevent text overlap */
        .pr-10 {
            padding-right: 2.5rem; /* Adjust as needed */
        }
    </style>
</head>

<body>
<div class="bg-white">
    <div class="lg:min-h-screen">
        <div class="flex items-center justify-center px-5 py-5">
            <div class="w-full mx-auto">
                <div class="relative mt-1 block text-center">
                    <a href="Login.jsp">
                        <h1 class="font-extrabold text-5xl text-amber-500">
                            edms<span class="text-red-500">.</span>
                        </h1>
                    </a>
                </div>

                <!-- Form -->
                <form class="my-5 max-w-[400px] mx-auto" action="Login" method="post"
                      enctype="multipart/form-data">

                    <!-- Email -->
                    <label class="label">
                        <span class="label-text">Enter your username</span>
                    </label>
                    <input id="log_username" name="log_username" type="text" class="input input-bordered w-full"
                           required/>
                    <!-- Password -->
                    <label class="label">
                        <span class="label-text">Enter your password</span>
                    </label>
                    <div class="relative"> <!-- Wrapper for input and icon -->
                        <input id="log_password" name="log_password" type="password" class="input input-bordered w-full pr-10" required/>
                        <span id="togglePassword" class="absolute inset-y-0 right-0 flex items-center pr-3 cursor-pointer">
                            <i class="fas fa-eye"></i> <!-- Eye icon -->
                        </span>
                    </div>
                    <!-- submit button -->
                    <input class="btn btn-warning my-5 w-full" type="submit" value="Submit">
                    <p>${message}</p>
                    <h3 class=" max-w-[400px] mx-auto text-center">
                        Don't have an account?
                        <a class="text-amber-500 hover:underline" href="#" onclick="showRegistrationOptions(event)">Register
                            Now.</a>
                    </h3>
                    <div class="max-w-[400px] mx-auto text-center">
                        <label class="inline-flex items-center">
                            <input type="checkbox" name="remember_me" value="on"
                                   class="form-checkbox h-4 w-4 text-amber-500">
                            <span class="ml-2 text-gray-700">Remember Me</span>
                        </label>
                    </div>
                </form>
                <div id="registrationModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                    <div class="bg-white p-8 rounded-lg shadow-lg max-w-md w-full animate__animated animate__fadeIn relative">
                        <!-- Close Button -->
                        <button id="closeModal" class="absolute top-3 right-3 bg-transparent text-gray-500 hover:text-gray-700">
                            <i class="fas fa-times"></i>
                        </button>

                        <!-- Modal Title -->
                        <h2 class="text-2xl font-bold mb-4 text-center text-amber-500">Choose Registration Type</h2>

                        <!-- Role Descriptions -->
                        <div class="mb-6">
                            <h2 class="text-xl font-semibold text-center">Role Descriptions</h2>
                            <ul class="list-disc list-inside text-gray-800 mt-4">
                                <li class="mb-2">
                                    <strong>Representative:</strong> Responsible for overseeing and managing disaster response efforts,
                                    providing support to affected areas, and ensuring that resources are effectively allocated.
                                    They can ask for help and make a post about their shelters.
                                </li>
                                <li>
                                    <strong>User:</strong> An individual who can report disasters, seek help, and monitor updates regarding
                                    emergency situations. They can submit posts related to emergencies, and contribute to where it is needed,
                                    but their access is limited to personal interactions and information.
                                </li>
                            </ul>
                        </div>

                        <!-- Buttons -->
                        <div class="flex justify-between space-x-4">
                            <!-- Representative Button -->
                            <button id="representativeBtn"
                                    class="btn border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-md transition-colors duration-300 flex items-center justify-center flex-1">
                                <i class="fas fa-user-tie mr-2"></i>
                                <span>Representative</span>
                            </button>

                            <!-- User Button -->
                            <button id="userBtn"
                                    class="btn border-2 border-amber-500 text-amber-500 hover:bg-amber-500 hover:text-white px-4 py-2 rounded-md transition-colors duration-300 flex items-center justify-center flex-1">
                                <i class="fas fa-user mr-2"></i>
                                <span>User</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    window.addEventListener('DOMContentLoaded', function () {
        let cookies = document.cookie.split('; ');
        for (let i = 0; i < cookies.length; i++) {
            let parts = cookies[i].split('=');
            if (parts[0] === "username") {
                let usernameField = document.getElementById("log_username");
                console.log(usernameField)
                if (usernameField) {
                    usernameField.value = decodeURIComponent(parts[1]);
                }
            }
        }
    });

    document.getElementById("togglePassword").addEventListener("click", function() {
        var passwordField = document.getElementById("log_password");
        var icon = document.getElementById("togglePassword").querySelector("i");

        // Toggle the password field's type between 'password' and 'text'
        if (passwordField.type === "password") {
            passwordField.type = "text";  // Show the password
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");  // Change to eye-slash (hide password)
        } else {
            passwordField.type = "password";  // Hide the password
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");  // Change to eye (show password)
        }
    });
    // Close Modal
    document.getElementById("closeModal").addEventListener("click", function() {
        document.getElementById("registrationModal").classList.add("hidden");
    });
    // Close Modal When Clicking Outside
    document.getElementById("registrationModal").addEventListener("click", function(event) {
        if (event.target === this) {
            this.classList.add("hidden");
        }
    });
</script>
</body>
</html>