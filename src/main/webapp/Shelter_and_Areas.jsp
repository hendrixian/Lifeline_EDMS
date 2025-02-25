<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <!--
    <title>Emergency Disaster Management System-Shelter & Areas</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />

     -->

    <title>Emergency Disaster Management System</title>
    <link rel="shortcut icon" href="IMAGES/icons8-tsunami-64.png" type="image/x-icon">
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
    <link rel="stylesheet" href = "CSS/Shelter_and_areas.css">
    <script src="https://kit.fontawesome.com/f13afb77f1.js" crossorigin="anonymous"></script>
    <script src="LocationData.js" defer></script>
</head>
<body>


<script>

    //       print data
    fetch('http://localhost:8080/EDMS_war_exploded/DataServlet')
        .then(res => res.json())
        .then(data => {
            const table = document.getElementById('data_table');

            const activeBadge = `<div class="badge badge-accent whitespace-nowrap">Active</div>`
            const inactiveBadge = `<div class="badge badge-warning whitespace-nowrap">Inactive</div>`
            const criticalBadge = `<div class="badge badge-error whitespace-nowrap">Critical Help Needed</div>`



            let table_html = ''

            table_html += `
			<tr class="dat_tab">
		        <th class="dat2">Name</th>
		        <th class="dat3">Type</th>
		        <th class="dat4">Activity</th>
		    </tr>
		`;

            const nameList = data[1]
            const typeList = data[2]
            const activityList = data[3]
            const divList = data[4]
            const ctList = data[5]
            const unionList = data[6]
            const userList = data[7]
// 		console.log(verifiedList)

            for(let i=0; i<nameList.length; i++){
                table_html += '<tr  class="dat_tab hover:bg-slate-200" >';




                table_html = table_html + '<td class="dat2"><a href="Location_Profile.jsp?LocationUsernameFromShelterPage='+userList[i]+ '"class="hover:text-red-500">' + nameList[i] + '</a></td>';


                table_html += '<td class="dat3">' + typeList[i] + '</td>';

                if(activityList[i] === 'Active'){
                    table_html += '<td class="dat4">' + activeBadge +'</td>';
                }
                else if(activityList[i] === 'Inactive'){
                    table_html += '<td class="dat4">' + inactiveBadge +'</td>';
                }
                else {
                    table_html += '<td class="dat4">' + criticalBadge +'</td>';
                }


                table_html += '</tr>'
            }

            table.innerHTML = table_html;

            console.log(data)
        })
    //



    window.onload = function()
    {
        const DivisionSelect = document.getElementById("DivisionSelect");
        const CitySelect = document.getElementById("CitySelect");
        const TownshipSelect = document.getElementById("TownshipSelect");
        for(var x in subjectObject )
        {
            DivisionSelect.options[DivisionSelect.options.length] = new Option(x,x);
        }

        DivisionSelect.onchange = function()
        {
            CitySelect.length = 1;
            TownshipSelect.length = 1;

            for(var y in subjectObject[this.value])
            {
                CitySelect.options[CitySelect.options.length] = new Option(y,y);
            }
        }

        CitySelect.onchange = function()
        {
            TownshipSelect.length = 1;

            var z = subjectObject[DivisionSelect.value][this.value];
            for(var i =0;i<z.length;i++)
            {
                TownshipSelect.options[TownshipSelect.options.length] = new Option(z[i],z[i]);
            }

        }

    }



</script>


<!-- Start of Navbar -->
<div class="border-b-[1px] bg-amber-500">
    <div class="my-container">
        <!-- For Large Device -->
        <div class="hidden lg:flex items-center justify-between">
            <!-- Logo -->
            <a href='Home.jsp'>
                <h1 class="font-extrabold text-5xl text-white">edms<span class="text-red-500">.</span></h1>
            </a>

            <!-- Nav links for medium and large devices -->
            <div class="flex flex-row items-center justify-between gap-3 md:gap-0">
                <a href="Home.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">Home</a>
                <a href="Shelter_and_Areas.jsp" class="text-white h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">Shelters & Areas</a>
                <a href="Social.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">Social</a>
                <a href="Faq.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">FAQ</a>
            </div>

            <!-- user icon  -->
            <div class="flex justify-center items-center text-[18px]">
                <div class="tooltip tooltip-left" data-tip="Profile">
                    <a href="Profile_user.jsp" class="hover:text-white transition duration-300">
                        <i class="fa-regular fa-circle-user"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- For Medium and small devices -->
        <div class="navbar bg-base-100 lg:hidden bg-amber-500 min-h-[100px]">
            <div class="navbar-start">
                <div class="dropdown">
                    <label tabindex="0" class="btn btn-ghost btn-circle">
                        <i class="fa-solid fa-bars text-[40px]"></i>
                    </label>

                    <ul tabindex="0"
                        class="menu menu-sm dropdown-content mt-3 z-[1] p-2 shadow bg-base-100 rounded-box w-[400px] flex flex-col gap-5 p-5">
                        <li><a href="Home.jsp"
                               class="text-[40px] text-[#F17829] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Homepage</a>
                        </li>
                        <li><a href="Shelter_and_Areas.jsp"
                               class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Shelters
                            & Areas</a></li>
                        <li><a href="Social.jsp"
                               class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Social</a>
                        </li>
                        <li><a href="Faq.jsp"
                               class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">FAQ</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="navbar-center">

                <a href='Home.jsp'>
                    <h1 class="font-extrabold text-[50px] text-white">edms<span class="text-red-500">.</span>
                    </h1>
                </a>

            </div>
            <div class="navbar-end">
                <a href="Profile_user.jsp" class="hover:text-[#F17829] transition duration-300">
                    <i class="fa-regular fa-circle-user text-[40px]"></i>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- End of Navbar -->

<div class="my-container">
    <!-- Search Bar -->
    <div class="my-6 p-3 grid grid-cols-1 md:grid-cols-3 justify-center items-center gap-3">
        <div class="flex flex-col lg:flex-row justify-center items-center gap-2">
            <label class="Label" for="itemSelect"><span class="label-text font-bold text-orange-500">Division: </span></label>
            <select class="w-full lg:w-auto lg:grow select select-bordered" id="DivisionSelect" name="Districtitem">
                <option value="null">None</option>
            </select>
        </div>

        <div class="flex flex-col lg:flex-row justify-center items-center gap-2">
            <label class="Label" for="itemSelect"><span class="label-text font-bold text-orange-500">City :</span></label>
            <select class="w-full lg:w-auto lg:grow select select-bordered" class ="dropbox" id="CitySelect" name="Upazilaitem">
                <option value="null">None</option>
            </select>
        </div>
        <div class="flex flex-col lg:flex-row justify-center items-center gap-2">
            <label class="Label" for="itemSelect"><span class="label-text font-bold text-orange-500">Township :</span></label>
            <select class="w-full lg:w-auto lg:grow select select-bordered" id="TownshipSelect" name="Unionitem">
                <option value="null">None </option>
            </select>
        </div>
    </div>
    <!-- Table -->
    <div class="table-container">
        <table class="table text-center min-w-full" id="data_table">
            <!-- Dynamic table content will be inserted here -->
        </table>
    </div>
</div>



<script>
    const divComponent = document.getElementById("DivisionSelect");
    const cityComponent = document.getElementById("CitySelect");
    let townshipComponent = document.getElementById("TownshipSelect");


    function updateTable () {
        const division = divComponent.options[divComponent.selectedIndex].text;
        const city = cityComponent.options[cityComponent.selectedIndex].text;
        const township = townshipComponent.options[townshipComponent.selectedIndex].text;


        const activeBadge = `<div class="badge badge-accent">Active</div>`
        const inactiveBadge = `<div class="badge badge-warning">Inactive</div>`
        const criticalBadge = `<div class="badge badge-error">Critical Help Needed</div>`


        let new_table_data = `<tr class="dat_tab">
    		        <th class="dat2"><a href="../Home/Home.html">Name</a></th>
    		        <th class="dat3">Type</th>
    		        <th class="dat4">Activity</th>
    		    </tr>`;

        fetch('http://localhost:8080/EDMS_war_exploded/DataServlet')
            .then(res => res.json())
            .then(data => {
                console.log(data)
                const nameList = data[1]
                const typeList = data[2]
                const activityList = data[3]
                const divList = data[4]
                const ctList = data[5]
                const townshipList = data[6]
                const userList = data[7]
                //console.log(verifiedList)

                if(township !== 'None'){
                    for(let i=0; i<nameList.length; i++){
                        if(townshipList[i] === township){
                            new_table_data = new_table_data + '<tr  class="dat_tab hover:bg-slate-200" >';



                            new_table_data = new_table_data + '<td class="dat2"><a href="Location_Profile.jsp?LocationUsernameFromShelterPage='+userList[i]+ '"class="hover:text-red-500">' + nameList[i] + '</a></th>';

                            new_table_data = new_table_data + '<td class="dat3">' + typeList[i] + '</th>';

                            if(activityList[i] === 'Active'){
                                new_table_data += '<td class="dat4">' + activeBadge +'</td>';
                            }
                            else if(activityList[i] === 'Inactive'){
                                new_table_data += '<td class="dat4">' + inactiveBadge +'</td>';
                            }
                            else {
                                new_table_data += '<td class="dat4">' + criticalBadge +'</td>';
                            }

                            new_table_data += '</tr>'
                        }
                    }
                }
                else if(city !== 'None'){
                    for(let i=0; i<nameList.length; i++){
                        if(ctList[i] === city){
                            new_table_data = new_table_data + '<tr  class="dat_tab hover:bg-slate-200 ">';



                            new_table_data = new_table_data + '<td class="dat2"><a href="Location_Profile.jsp?LocationUsernameFromShelterPage='+userList[i]+ '"class="hover:text-red-500">' + nameList[i] + '</a></th>';


                            new_table_data = new_table_data + '<td class="dat3">' + typeList[i] + '</th>';

                            if(activityList[i] === 'Active'){
                                new_table_data += '<td class="dat4">' + activeBadge +'</td>';
                            }
                            else if(activityList[i] === 'Inactive'){
                                new_table_data += '<td class="dat4">' + inactiveBadge +'</td>';
                            }
                            else {
                                new_table_data += '<td class="dat4">' + criticalBadge +'</td>';
                            }

                            new_table_data += '</tr>'
                        }
                    }
                }
                else if(division !== 'None'){
                    for(let i=0; i<nameList.length; i++){
                        if(divList[i] === division){
                            new_table_data = new_table_data + '<tr  class="dat_tab hover:bg-slate-200" >';



                            new_table_data = new_table_data + '<td class="dat2"><a href="Location_Profile.jsp?LocationUsernameFromShelterPage='+userList[i]+ '"class="hover:text-red-500">' + nameList[i] + '</a></th>';


                            new_table_data = new_table_data + '<td class="dat3">' + typeList[i] + '</th>';

                            if(activityList[i] === 'Active'){
                                new_table_data += '<td class="dat4">' + activeBadge +'</td>';
                            }
                            else if(activityList[i] === 'Inactive'){
                                new_table_data += '<td class="dat4">' + inactiveBadge +'</td>';
                            }
                            else {
                                new_table_data += '<td class="dat4">' + criticalBadge +'</td>';
                            }

                            new_table_data += '</tr>'
                        }
                    }
                }
                else {
                    for(let i=0; i<nameList.length; i++){
                        //console.log("wow");
                        new_table_data = new_table_data + '<tr  class="dat_tab hover:bg-slate-200" >';
//      						new_table_data = new_table_data + '<td class="dat1">' + verifiedList[i] + '</th>';



                        new_table_data = new_table_data + '<td class="dat2"><a href="Location_Profile.jsp?LocationUsernameFromShelterPage='+userList[i]+ '"class="hover:text-red-500">' + nameList[i] + '</a></th>';


                        new_table_data = new_table_data + '<td class="dat3">' + typeList[i] + '</th>';

                        if(activityList[i] === 'Active'){
                            new_table_data += '<td class="dat4">' + activeBadge +'</td>';
                        }
                        else if(activityList[i] === 'Inactive'){
                            new_table_data += '<td class="dat4">' + inactiveBadge +'</td>';
                        }
                        else {
                            new_table_data += '<td class="dat4">' + criticalBadge +'</td>';
                        }

                        new_table_data += '</tr>'
                    }
                }


                document.getElementById('data_table').innerHTML = new_table_data
            })

    }

    divComponent.addEventListener('change', updateTable);
    cityComponent.addEventListener('change', updateTable);
    townshipComponent.addEventListener('change', updateTable);
</script>
<!-- Start of reference -->
<div class="p-6 m-6 flex flex-col justify-center items-center">
    <h5 class="text-center text-slate-400 font-semibold italic">In our ML regression analysis, we gratefully acknowledge the utilization of data from <a class="text-center text-slate-400 italic underline hover:text-black" href="http://www.ffwc.gov.bd/" target="_blank">Flood Forcasting & Warning Center</a> to enhance our model's accuracy and effectiveness.</h5>
    ``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
</div>
<!-- End of reference -->
<!-- Start of Footer -->
<div class='flex justify-between gap-0 mt-6'>
    <div class='hidden md:flex flex-col items-center justify-center gap-3 border-[1px] p-8 min-w-[250px]'>
        <h3 class='text-[18px] text-center font-semibold uppercase'>Links</h3>
        <a href='Home.jsp' class='text-[16px] text-[#868686] hover:text-black transition duration-500'>Home</a>
        <a href='Shelter_and_Areas.jsp'
           class='text-[16px] text-[#868686] hover:text-black transition duration-500'>Shelters</a>
        <a href='Social.jsp' class='text-[16px] text-[#868686] hover:text-black transition duration-500'>Social</a>
        <a href='Faq.jsp' class='text-[16px] text-[#868686] hover:text-black transition duration-500'>FAQ</a>
    </div>

    <div class='flex flex-col items-center justify-center gap-3 border-[1px] p-8 w-full'>
        <a href='Home.jsp'>
            <h1 class="font-extrabold text-5xl text-amber-600">edms<span class="text-red-500">.</span></h1>
        </a>
        <h3 class='text-[16px] text-[#7B7B7B] text-center'>EDMS - Your comprehensive resource for shelter,
            assistance, and information during times of crisis</h3>
        <h3 class='text-[16px] text-[#868686] text-center'>&copy; 2023 EDMS. All rights reserved.</h3>
    </div>

    <div class='hidden md:flex flex-col items-center justify-center gap-3 border-[1px] p-8 min-w-[250px]'>
        <h3 class='text-[18px] text-center font-semibold uppercase'>Help</h3>
        <a href='/' class='text-[16px] text-[#868686] hover:text-black transition duration-500'>Terms</a>
        <a href='/' class='text-[16px] text-[#868686] hover:text-black transition duration-500'>Privacy</a>
    </div>
</div>
<!-- End of Footer -->

<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
    AOS.init();
</script>
</body>
</html>
