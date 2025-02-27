<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shelter Registration and Policy Guidelines</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fc;
        }
        .header {
            text-align: center;
            padding: 40px;
            background-color:orange;
            color: white;
            border-bottom: 3px solid #cc6600;
        }
        .header h1 {
            font-size: 2.5em;
            margin: 0;
        }
        .header p {
            font-size: 1.2em;
        }
        .section {
            background-color: white;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            max-width: 1000px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .section h2 {
            color: orange;
            font-size: 1.8em;
            margin-bottom: 10px;
        }
        .section ul {
            list-style-type: none;
            padding: 0;
        }
        .section li {
            margin: 12px 0;
            font-size: 1.1em;
            line-height: 1.6;
        }
        .form-section {
            background-color: #fafafa;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 30px;
            margin-top: 30px;
        }
        .form-section input, .form-section select, .form-section textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 6px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }
        .form-section label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        .form-section button {
            background-color: orange;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1em;
            margin-top: 20px;
            transition: background-color 0.3s;
        }
        .form-section button:hover {
            background-color: #cc6600;
        }
        .error {
            color: red;
            font-size: 1em;
            margin-top: 10px;
        }
        /* Hover effects for section items */
        .section li:hover {
            background-color: #fff5e6;
            padding-left: 15px;
            transition: all 0.3s ease;
        }
        /* Register button container */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container button {
            background-color: #FFC107; /* Yellow color */
            border: none;
            color: black;
            font-weight: bold;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 25px; /* Rounded corners */
            cursor: pointer;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            transition: background-color 0.3s ease;
        }

        .button-container button:hover {
            background-color: #FFA000; /* Slightly darker yellow on hover */
        }

        /* Checkbox */
        .terms-container {
            text-align: center;
            margin-top: 20px;
            font-size: 1em;
            margin-bottom: 10px; /* Reduce the space between the checkbox and the button */
        }

        .terms-container input[type="checkbox"] {
            display: none; /* Hide default checkbox */
        }

        .terms-container label {
            position: relative;
            padding-left: 30px;
            cursor: pointer;
            font-size: 1em;
            color: #333;
            display: inline-block;
        }

        .terms-container label:before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 20px;
            height: 20px;
            border: 2px solid #FFC107; /* Yellow border */
            border-radius: 3px; /* Slightly rounded corners */
            background-color: #fff;
            transition: background-color 0.3s ease;
        }

        .terms-container input[type="checkbox"]:checked + label:before {
            background-color: #FFC107; /* Yellow background when checked */
            border-color: #FFA000; /* Slightly darker yellow */
        }

        .terms-container label:after {
            content: "✓";
            position: absolute;
            left: 5px;
            top: -2px;
            font-size: 18px;
            color: white;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .terms-container input[type="checkbox"]:checked + label:after {
            opacity: 1;
        }
        /* Custom alert styles */
        .custom-alert {
            display: none; /* Initially hidden */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 300px;
            padding: 20px;
            background-color: white;
            color: black;
            border: 3px solid #FFC107;
            border-radius: 8px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            z-index: 1000;
            font-family: Arial, sans-serif;
        }

        .custom-alert button {
            background-color: #e5e7eb;
            color: black;
            border: 1px solid #FFC107;
            padding: 10px 20px;
            margin-top: 15px;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .custom-alert button:hover {
            background-color: #FFC107;
        }


    </style>
</head>
<body>

<div class="header">
    <h1>Shelter Registration and Policy Guidelines</h1>
    <p>Please review the policies below and provide the necessary information to register your shelter.</p>
</div>

<!-- Licensing and Registration Requirements Section -->
<div class="section">
    <h2>1. Licensing and Registration Requirements</h2>
    <ul>
        <li><strong>Approval Process:</strong> Ensure that shelter organizers must obtain approval or licenses from local authorities like emergency management agencies or municipal governments.</li>
        <li><strong>Regulations Compliance:</strong> Adhere to local, state, or national disaster relief regulations, including zoning laws and safety codes.</li>
        <li><strong>Registration of Shelter:</strong> Formal registration process to track new shelters, ensuring accessibility by emergency services.</li>
    </ul>
</div>

<!-- Health and Safety Standards Section -->
<div class="section">
    <h2>2. Health and Safety Standards</h2>
    <ul>
        <li><strong>Sanitation and Hygiene:</strong> Mandate clean water, sanitation facilities, waste disposal systems, and pest control.</li>
        <li><strong>Food and Water Safety:</strong> Ensure safe and nutritious food and water are provided to residents, with policies on food preparation and distribution.</li>
        <li><strong>Fire Safety:</strong> Comply with fire safety regulations, including fire extinguishers and exit routes.</li>
        <li><strong>Emergency Medical Care:</strong> Provide basic medical care and supplies, along with health professionals.</li>
    </ul>
</div>

<!-- Security and Protection Section -->
<div class="section">
    <h2>3. Security and Protection</h2>
    <ul>
        <li><strong>Safety of Residents:</strong> Ensure the safety of residents with guidelines for preventing violence and theft.</li>
        <li><strong>Security Personnel:</strong> If needed, hire qualified security personnel to maintain safety.</li>
        <li><strong>Child Protection:</strong> Implement child protection policies, ensuring care and psychological support.</li>
        <li><strong>Gender and Minority Protection:</strong> Protect vulnerable populations, including separate facilities and measures to prevent exploitation.</li>
    </ul>
</div>

<!-- Capacity and Resource Management Section -->
<div class="section">
    <h2>4. Capacity and Resource Management</h2>
    <ul>
        <li><strong>Maximum Capacity Limits:</strong> Set capacity limits based on space, resources, and facilities available.</li>
        <li><strong>Resource Allocation:</strong> Equitably distribute resources like bedding, food, and medical supplies.</li>
    </ul>
</div>

<!-- Coordination and Communication Section -->
<div class="section">
    <h2>5. Coordination and Communication</h2>
    <ul>
        <li><strong>Collaboration with Relief Agencies:</strong> Collaborate with disaster relief agencies like the Red Cross, NGOs, and government bodies.</li>
        <li><strong>Information Sharing:</strong> Ensure effective communication and information sharing regarding available resources.</li>
    </ul>
</div>

<!-- Staffing and Training Section -->
<div class="section">
    <h2>6. Staffing and Training</h2>
    <ul>
        <li><strong>Qualified Personnel:</strong> Require staff trained in disaster response, first aid, and mental health support.</li>
        <li><strong>Ongoing Training:</strong> Ensure staff receive regular training in emergency procedures and handling vulnerable populations.</li>
    </ul>
</div>

<!-- Accessibility and Inclusivity Section -->
<div class="section">
    <h2>7. Accessibility and Inclusivity</h2>
    <ul>
        <li><strong>Physical Accessibility:</strong> Ensure the shelter is accessible to people with disabilities, with ramps and appropriate support.</li>
        <li><strong>Language Access:</strong> Provide interpreters or materials in multiple languages for non-native speakers.</li>
    </ul>
</div>

<!-- Shelter Management and Oversight Section -->
<div class="section">
    <h2>8. Shelter Management and Oversight</h2>
    <ul>
        <li><strong>Regular Inspections:</strong> Enforce safety and hygiene inspections to ensure compliance with regulations.</li>
        <li><strong>Complaint and Feedback Mechanism:</strong> Implement a system for residents to report issues regarding shelter conditions.</li>
    </ul>
</div>

<!-- Duration and Exit Strategy Section -->
<div class="section">
    <h2>9. Duration and Exit Strategy</h2>
    <ul>
        <li><strong>Temporary Shelter:</strong> Define the shelter duration and policies for transitioning to permanent housing.</li>
        <li><strong>Long-Term Support:</strong> Provide guidance on long-term support services after the emergency period ends.</li>
    </ul>
</div>

<!-- Legal Protections for Shelter Organizers Section -->
<div class="section">
    <h2>10. Legal Protections for Shelter Organizers</h2>
    <ul>
        <li><strong>Liability and Insurance:</strong> Ensure that shelter organizers have liability insurance to protect workers and residents.</li>
        <li><strong>Property Protection:</strong> Shelter organizers should not be liable for loss or damage to personal property, but must take precautions to protect belongings.</li>
    </ul>
</div>
<!-- Accept Terms and Register Button Section -->
<div class="terms-container">

    <input type="checkbox" id="acceptTerms">
    <label for="acceptTerms">I accept the terms and conditions</label>
</div>
<div id="customAlert" class="custom-alert">
    <p>You must accept the terms and conditions before proceeding.</p>
    <button onclick="closeAlert()">OK</button>
</div>


<div class="button-container">
    <form action="representative.jsp" onsubmit="return checkTerms()">
        <button type="submit">Proceed to Registration</button>
    </form>
</div>
<script>
    function checkTerms() {
        var termsCheckbox = document.getElementById("acceptTerms");
        if (!termsCheckbox.checked) {
            showCustomAlert();
            return false;
        }
        return true;
    }

    function showCustomAlert() {
        var alertBox = document.getElementById("customAlert");
        alertBox.style.display = "block";
    }

    function closeAlert() {
        var alertBox = document.getElementById("customAlert");
        alertBox.style.display = "none";
    }
</script>
</body>
</html>
