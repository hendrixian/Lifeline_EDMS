<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@page import="java.sql.*" %>
  <%@page import="java.util.*" %>
	<%@page import="java.lang.Math" %>
    <%@page import="java.util.Date" %>
    <%@page import="java.util.Locale" %>
    <%@page import="java.text.SimpleDateFormat" %>
    <%@page import="JavaFiles.*"%>
    <%@page import="JavaFiles.Pair"%>
    <%@page import="JavaFiles.divisions"%>
    <%@page import="JavaFiles.PrintCharacter"%>
<%@page import="java.lang.System"%>
<!DOCTYPE html>
<html>

<head>
    <title>Emergency Disaster Management System</title>
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
        String loggedInRepresentative = (String) session.getAttribute("loggedInRepresentative");
String loggedInUser = (String) session.getAttribute("loggedInUser");
 if (loggedInRepresentative == null && loggedInUser==null)
 {
	 String scheme = request.getScheme(); // http or https
	 String serverName = request.getServerName(); // localhost
	 int serverPort = request.getServerPort(); // 8080
	 String contextPath = request.getContextPath(); // /edms_demo
	 String servletPath = request.getServletPath(); // /Location_Profile.jsp
	 String queryString = request.getQueryString(); // LocationUsernameFromShelterPage=SystemTest1_loc_2

	 String currentURL = scheme + "://" + serverName + ":" + serverPort + contextPath + servletPath+"?"+queryString;
     //System.out.println(currentURL);

     session.setAttribute("redirectURL", currentURL);
     response.sendRedirect("Login.jsp");
     return;
 }
String LocationUsername =  request.getParameter("LocationUsernameFromShelterPage");

System.out.println(LocationUsername);

Connection con = null;
try 
{
	Class.forName("org.mariadb.jdbc.Driver");
}
catch(ClassNotFoundException e)
{
	e.printStackTrace();
}
try
{
	con=DriverManager.getConnection("jdbc:mariadb://localhost:3306/disaster1" , "root","");
}
catch(SQLException e)
{
	e.printStackTrace();
}

ArrayList<String>Date = new ArrayList();
ArrayList<String>Username = new ArrayList();
ArrayList<String>Affected= new ArrayList();
ArrayList<String>PostPhoto1 = new ArrayList();
ArrayList<String>PostPhoto2 = new ArrayList();
ArrayList<String>Description = new ArrayList();
ArrayList<String>Name = new ArrayList();
String Link=null;
String queryU="select * from location_added where LocationUsername='"+LocationUsername+"'";
Statement stmt0;
try{
	
	stmt0 = con.createStatement();
    ResultSet rs0 = stmt0.executeQuery(queryU);
	while(rs0.next()){
		Link=rs0.getString("Link");
	}
}catch(Exception e){
	
}

String query="select * from "+LocationUsername+"_askhelp order by Second desc";
Statement stmt;

try 
{
    stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(query);
    while(rs.next())
    {
         String Date1 = rs.getString("Date");
         Date.add(Date1);
         String Username1 = rs.getString("Username");
         Username.add(Username1);
         
         String query2="select * from registrationinfo where Username='"+Username1+"'";
         Statement stmt2;
         String name1=null;
         try{
        	 stmt2 = con.createStatement();
        	 ResultSet rs2=stmt2.executeQuery(query2);
             
             while(rs2.next()){
            	 name1=rs2.getString("Name");
             }
         }catch(Exception e){
        	 
         }
         Name.add(name1);

         int Affected1 = rs.getInt("Total");
         Affected.add("Affected People : "+Affected1);

         String PostPhoto11="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo1"));
         System.out.println("1st "+PostPhoto11);
         String PostPhoto21="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo2"));
         PostPhoto1.add(PostPhoto11);
         PostPhoto2.add(PostPhoto21);

         String Description1 = rs.getString("Description");
         Description.add(Description1);

        
    }

}
catch(Exception e)
{
   e.printStackTrace();
}

String query2="select * from "+LocationUsername+"_contribution order by Second desc";
Statement stmt2;

try 
{
    stmt2 = con.createStatement();
    ResultSet rs = stmt2.executeQuery(query2);
    while(rs.next())
    {
         String Date1 = rs.getString("Date");
         Date.add(Date1);
         String Username1 = rs.getString("Username");
         Username.add(Username1);
	 String query3="select * from registrationinfo where Username='"+Username1+"'";
         Statement stmt3;
         String name1=null;
         try{
        	 stmt3 = con.createStatement();
        	 ResultSet rs2=stmt3.executeQuery(query3);
             
             while(rs2.next()){
            	 name1=rs2.getString("Name");
             }
         }catch(Exception e){
        	 
         }
         Name.add(name1);
         int Affected1 = rs.getInt("Total");
         Affected.add("Help given to "+Affected1+" people");

         String PostPhoto11="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo1"));
         System.out.println("1st "+PostPhoto11);
         String PostPhoto21="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo2"));
         PostPhoto1.add(PostPhoto11);
         PostPhoto2.add(PostPhoto21);

         String Description1 = rs.getString("Description");
         Description.add(Description1);

        
    }

}
catch(Exception e)
{
   e.printStackTrace();
}

%>

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
                    <a href="Shelter_and_Areas.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">Shelters & Areas</a>
                    <a href="Social.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                    hover:text-white transition duration-500">Social</a>
                    <!-- active link style -->
                    <a href="Faq.jsp" class="text-black h-full py-5 px-6 border-b-amber-500 hover:border-b-white border-b-[3px]
                hover:text-white transition duration-500">FAQ</a>
                </div>
              <%  if (loggedInRepresentative != null) { // Show only if representative is logged in
                %>
                <!-- user icon  -->
                <div class="flex justify-center items-center text-[18px]">
                    <div class="tooltip tooltip-left" data-tip="Log Out">
                        <a href="logout.jsp" class="hover:text-white transition duration-300">
                            <i class="fa-solid fa-right-from-bracket"></i>
                        </a>
                    </div>
                </div>
                <%}%>
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
                                    class="text-[40px] text-[#293341] block border-b-[1px] p-3 hover:text-[#F17829] transition duration-500">Homepage</a>
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
                <%  if (loggedInRepresentative != null) { // Show only if representative is logged in
                %>
                <div class="navbar-end">
                    <a href="logout.jsp" class="hover:text-[#F17829] transition duration-300">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </a>
                </div>
                <%}%>
            </div>

        </div>
    </div>
    <!-- End of Navbar -->

	<%

String Verified1 = null;
String query1 = "SELECT * FROM location_verified WHERE Username = '"+Username+"'";
Statement stmt1;
try 
{
    stmt1 = con.createStatement();
    ResultSet rs1 = stmt1.executeQuery(query1);
    while(rs1.next())
    {
        Verified1 = rs1.getString("Username");
    }

}
catch(Exception e)
{

}

/*String query10="select * from location_added where LocationUsername='"+LocationUsername+"'";
Statement stmt10;
String uname=null;
String utype=null;
String cont=null;
String udescription=null;
String Image1=null;
String Image2=null;
String activity=null;
String udistrict=null;
String uupazilla=null;
String uunion=null;
String male=null;String female=null;String child=null;String total=null;

try 
{
    stmt10 = con.createStatement();
    ResultSet rs = stmt10.executeQuery(query10);
    while(rs.next())
    {
         
		uname=rs.getString("Name");
		utype=rs.getString("Type");
		cont=rs.getString("ContactNo");
		activity=rs.getString("Activity");
		udescription=rs.getString("Description");
		Image1="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo1"));
		//System.out.println(Image1);
		Image2="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("Photo2"));
		udistrict=rs.getString("District");
		uupazilla=rs.getString("Upazilla");
		uunion=rs.getString("Unionn");
		male=rs.getString("Male");
		female=rs.getString("Female");
		child=rs.getString("Children");
		total=rs.getString("Total");
    }

}
catch(Exception e)
{
   e.printStackTrace();
}
*/
        String query12="select * from representative where Representativename='"+loggedInRepresentative+"'";
        Statement stmt12;
        String uname=null;
        String sheltername=null;
        String utype=null;
        String cont=null;
        String sdescription=null;
        String udescription=null;
        String Image1=null;
        String Image2=null;
        String Image3=null;
        String Image4=null;
        String activity=null;
      //  String udistrict=null;
     //   String uupazilla=null;
//String uunion=null;
        String UserDivisions = null;
        String UserCities = null;
        String UserTownships = null;
        String UserZip = null;
       // String male=null;
      //  String female=null;
       //String child=null;//String total=null;org code
        int male = 0;
        int female = 0;
        int child = 0;
        // Retrieve the affected people values (they may still be passed as Strings)
        //String maleString = request.getParameter("AffectedMale");
        //String femaleString = request.getParameter("AffectedFemale");
       // String childString = request.getParameter("AffectedChildren");

        // Initialize integer variables for display
       // int male = 0;
      //  int female = 0;
       // int child = 0;
        try
        {
            stmt12 = con.createStatement();
            ResultSet rs = stmt12.executeQuery(query12);
            while(rs.next())
            {

                uname=rs.getString("Representativename");
                sheltername=rs.getString("sheltername");
                utype=rs.getString("type");
                cont=rs.getString("contact");
                activity=rs.getString("activity");
                sdescription=rs.getString("sdescription");
                udescription=rs.getString("description");
                Image1="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("photo1"));
                //System.out.println(Image1);
                Image2="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("photo2"));
                Image3="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("photo3"));
                Image4="data:image/gif;base64,"+encodeBlobToBase64(rs.getBlob("photo4"));
                UserZip = rs.getString("Zipcode");
                // udistrict=rs.getString("District");
               // uupazilla=rs.getString("Upazilla");
               // uunion=rs.getString("Unionn");
              //  male = rs.getInt("affectedmale");
              //  female = rs.getInt("affectedfemale");
               // child = rs.getInt("affectedchildren");
                // Parse the string values into integers for display
               // if (maleString != null && !maleString.isEmpty()) {
                   // male = Integer.parseInt(maleString);
               // }
               // if (femaleString != null && !femaleString.isEmpty()) {
                   // female = Integer.parseInt(femaleString);
                //}
               // if (childString != null && !childString.isEmpty()) {
                   // child = Integer.parseInt(childString);
               // }

                //male=rs.getString("affectedmale");
               // female=rs.getString("affectedfemale");
               // child=rs.getString("affectedchildren");
                 male = rs.getInt("affectedmale");
                female = rs.getInt("affectedfemale");
                child = rs.getInt("affectedchildren");

// Convert to String if needed for display
                String maleStr = String.valueOf(male);
                String femaleStr = String.valueOf(female);
                String childStr = String.valueOf(child);

                //total=rs.getString("Total");
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        String query123  = "SELECT * FROM myanmar WHERE Zipcode = '"+UserZip+"'";

        Statement stmt123;

        try
        {
            stmt123 = con.createStatement();
            ResultSet rs = stmt123.executeQuery(query123);
            while(rs.next())
            {
                UserDivisions= rs.getString("Divisions");
                UserCities = rs.getString("Cities");
                UserTownships= rs.getString("Townships");



            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

    %>
     
	

   <!-- <div class="my-container">
        <div class="my-6 grid grid-cols-1 lg:grid-cols-2 gap-3 items-center justify-center">
            <img class="w-full rounded-lg" src="<%--=Image1--%> " alt="profile-picture-1">
            <img class="w-full rounded-lg" src="<%--=Image2--%> " alt="profile-picture-2">
        </div>-->
        <!-- Third image as a circular profile-like image -->
       <!-- <div class="flex justify-left mt-4">
            <img class="w-40 h-40 rounded-full border-4 border-yellow shadow-lg" src="<%--=Image3--%>" alt="profile-picture-3">
        </div>-->
    <div class="my-6 grid grid-cols-1 lg:grid-cols-2 gap-3 items-center justify-center relative">
        <!-- Image 1 (Parent Container) -->
        <div class="relative ">
            <img class="w-full rounded-lg" src="<%=Image3%>" alt="profile-picture-1">



            <!-- Image 3 (Overlapping at Bottom-Left of Image 1) with Green Dot -->
            <div class="absolute left-4 -bottom-10">

                <div class="relative">
            <img onclick="profile_img_modal.showModal()"
                 class=" cursor-pointer rounded-full w-[150px] h-[150px] border-4 border-yellow-500 shadow-lg"
                 src="<%=Image1%>"
                 alt="profile picture">
                <!-- Green Dot for Active Status -->
                <div class="absolute bottom-1 right-5 w-4 h-4 bg-green-500 border-2 border-white rounded-full"></div>
            </div>
            </div>
        </div>
        <!-- Image 2 -->
        <img class="w-full rounded-lg" src="<%=Image4%>" alt="profile-picture-2">
    </div>


    <!-- Modal for Enlarging Image 3 -->
    <dialog id="profile_img_modal" class="modal w-[100vw]">
        <div class="modal-box max-w-[90vw] w-full lg:w-auto">
            <form method="dialog">
                <button class="btn btn-sm btn-circle btn-error text-white absolute right-2 top-2">X</button>
            </form>
            <div class="flex justify-center items-center">
                <img class="rounded-xl" src="<%=Image3%>" alt="">
            </div>
        </div>
    </dialog>


    <!-- Location Details -->
    <div class="my-container flex flex-col lg:flex-row gap-5">
        <div class="min-w-[250px] p-3">
            <h1 class="text-amber-600 font-bold text-[24px]"><%=uname %></h1>
            <h3 class="text-gray-500">Contact No: <%=cont %></h3>
            <div class="my-2 text-[15px] flex gap-1 items-center">
                <i class="fa-solid fa-location-dot"></i>
                <div class="badge badge-ghost"><%=UserTownships %></div>
            </div>
            <div class="my-2 text-[15px] flex gap-1 items-center">
                <i class="fa-solid fa-location-dot"></i>
                <div class="badge badge-ghost"><%=UserCities%></div>
            </div>
            <div class="my-2 text-[15px] flex gap-1 items-center">
                <i class="fa-solid fa-location-dot"></i>
                <div class="badge badge-ghost"><%=UserDivisions%></div>
            </div>
            <!-- Affected people -->
            <div class="my-5">
                <h3 class="center text-red-500 font-semibold">Affected People</h3>
                <div class="flex gap-2 center text-[14px] mt-1">
                    <h4 class="tooltip cursor-pointer" data-tip="Male"><i class="fa-solid fa-person"></i><span
                            class="ml-1 font-semibold"><%=male %></span></h4>
                    <h4 class="tooltip cursor-pointer" data-tip="Female"><i class="fa-solid fa-person-dress"></i><span
                            class="ml-1 font-semibold"><%=female %></span></h4>
                    <h4 class="tooltip cursor-pointer" data-tip="Children"><i
                            class="fa-solid fa-child-reaching"></i><span class="ml-1 font-semibold"><%=child %></span></h4>
                </div>
               <!-- <h3 class="text-gray-500 font-semibold">Total:</h3>-->
                <a class="my-2" href=<%=Link %> target="_blank"><button
                        class="btn btn-xs btn-neutral">Show in Map</button></a>
            </div>
        </div>

        <div class="flex flex-col gap-4 w-full ">  <!-- Forces vertical stacking -->
            <div class="flex items-center space-x-3 my-4">
                <div class="bg-yellow-500 text-white px-4 py-2 rounded-full shadow-md flex items-center w-auto">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-4 0h4"></path>
                    </svg>
                    <span class="font-bold text-lg">Shelter Name:<%=sheltername%></span>
                </div>
            </div>
        <div class="p-3 text-justify bg-gray-100 p-3 lg:p-5 rounded-lg mb-5 border-2 border-yellow-500 glow-red w-full">
            <h3 class="font text-center text-[20px] mb-2">Shelter Description</h3>
            <p class="text-justify"><%=sdescription %>
            </p>
        </div>
        <div class=" p-3 text-justify bg-gray-100 p-3 lg:p-5 rounded-lg mb-5 border-2 border-yellow-500 glow-red w-full">
            <h3 class="font text-center text-[20px] mb-2">Representative Description</h3>
            <p class="text-justify"><%=udescription %>
            </p>


    </div>
            <div class="my-container mb-6 w-full">
                <div class="shadow-lg rounded-lg p-5 grow w-full">
                    <div class="flex flex-wrap gap-5 ">
                        <%

                            // If loggedInUser is not null, show Add Contribution button
                            if (loggedInUser != null) {
                        %>
                        <a href="AddContribution.jsp?LocationUsernameFromLocationProfile=<%=LocationUsername%>" class="flex-1 min-w-[150px]">
                            <button class="btn btn-warning hover:bg-amber-500 w-full text-center">Add Contribution</button>
                        </a>
                        <%
                            }

                            // If loggedInRepresentative is not null, show Add Post button
                            if (loggedInRepresentative != null) {
                        %>
                        <a href="AddPost.jsp?LocationUsernameFromLocationProfile=<%=LocationUsername%>" class="flex-1 min-w-[150px]">
                            <button class="btn btn-warning hover:bg-amber-500 w-full text-center w-auto">Add Post</button>
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>


            <!--top ten contribution list-->
    <div class="bg-gray-100 p-3 lg:p-5 rounded-lg mb-5 border-4 border-yellow-500 w-full">
        <h1 class="text-slate-600 font-bold text-[20px] text-center">Top Ten Contribution List</h1>
        <!-- User contribution history Table -->








        <div class="overflow-x-auto my-3 ">
            <table class="table ">
                <!-- head -->
                <thead>
                <tr>
                    <th>
                        <label>
                        </label>
                    </th>
                    <th>User Name</th>
                    <th>Amount</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <!-- row 1 -->

                <!-- -------- FOR loop one ----->
                    <%--
                contributions = (List<String[]>) request.getAttribute("contributions");
                if (contributions != null && !contributions.isEmpty()) {
                  for (String[] row : contributions) {
              %>
                <tr>
                    <td></td>
                    <td><%= row[0] %></td> <!-- Shelter Name -->
                    <td><%= row[1] %></td> <!-- Amount -->
                    <td><%= row[2] %></td> <!-- Date -->
                </tr>
                    <%
                  }
                } else {
              %>
                <tr><td colspan="3">No contributions found.</td></tr>
                    <%
                }
              --%>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Timeline -->


            <div>
                <h1 class="text-slate-600 font-bold text-[20px] text-center mt-5 mb-3">Timeline</h1>

                <!-- Posts -->

                <div class="flex flex-col gap-5 overflow-hidden my-5 w-full">
                   
<% 
for(int i=0;i<Date.size();i++)
{     
%>
                    <!-- Post1 start -->
                    <div data-aos="fade-right" class="bg-[#d9d9d9] p-3 md:p-5 rounded-xl">
                        <div class="flex flex-col md:flex-row gap-3 justify-between">
                            <div class="flex gap-3">
                                <!-- TODO: if verified then show badge -->
                                
                                <div>
                                    <h1 class="text-[16px] font-bold"><a href="People_Profile.jsp?PeopleUsernameFromSocialPage=<%=Username.get(i)%>"><%=Name.get(i) %></a></h1>
                                    <h3 class="text-[15px]"><%=Date.get(i) %></h3>
                                </div>
                            </div>
                            <!-- TODO: implement conditional rendering -->
                            <div class="badge badge-ghost text-[18px] p-3 border-1 border-black"><%=Affected.get(i) %>
                            </div>

                        </div>
                       
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">
                            <div class="grid grid-cols-2 lg:flex gap-2">
                                <% String take1 = "img_modal_" + i + "_1"; %>
                                <img onclick="document.getElementById('<%= take1 %>').showModal();"
                                     class="center-cropped max-h-[200px] cursor-pointer lg:w-[50%] rounded-xl w-full"
                                     src="<%= PostPhoto1.get(i) %>" alt="">

                                <!-- Image-1 Modal -->
                                <% String take2 = "img_modal_" + i + "_1"; %>
                                <dialog id="<%= take2 %>" class="modal w-[100vw]">
                                    <p>This is a modal!</p>
                                    <button onclick="this.parentElement.close();">Close</button>
                                </dialog>

                                <div class="modal-box max-w-[90vw] w-full lg:w-auto">
                                        <form method="dialog">
                                            <button
                                                class="btn btn-sm btn-circle btn-error text-white absolute right-2 top-2">X</button>
                                        </form>
                                        <div class="flex justify-center items-center">
                                            <img class="rounded-xl" src=<%=PostPhoto1.get(i)%> alt="">
                                        </div>
                                    </div>
                                </dialog>

                                <% String take3 = "img_modal_" + i + "_2"; %>
                                <img onclick="document.getElementById('<%= take3 %>').showModal();"
                                     class="center-cropped max-h-[200px] cursor-pointer lg:w-[50%] rounded-xl w-full"
                                     src="<%= PostPhoto2.get(i) %>" alt="">

                                <!-- Image-2 Modal -->
                                <% String take4 = "img_modal_" + i + "_2"; %>
                                <dialog id="<%= take4 %>" class="modal w-[100vw]">
                                    <p>This is Image-2 Modal</p>
                                    <button onclick="this.parentElement.close();">Close</button>
                                </dialog>

                                <div class="modal-box max-w-[90vw] w-full lg:w-auto">
                                        <form method="dialog">
                                            <button
                                                class="btn btn-sm btn-circle btn-error text-white absolute right-2 top-2">X</button>
                                        </form>
                                        <div class="flex justify-center items-center">
                                            <img class="rounded-xl" src=<%=PostPhoto2.get(i)%> alt="">
                                        </div>
                                    </div>
                                </dialog>
                            </div>

                            <div class="post-description flex flex-col justify-between">

                                <!-- show 30 words -->
								<%  PrintCharacter PCobj = new PrintCharacter(); %>
                                <p>
                                   <%=PCobj.Print_200_Characters(Description.get(i))%>
                                </p>

                                <div class="flex justify-end items-center">
                                    <% String take5 = "show_more_modal_" + i; %>
                                    <span onclick="document.getElementById('<%= take5 %>').showModal();"
                                          class="px-3 py-2 bg-[#F2F2F2] rounded-xl cursor-pointer hover:bg-[#E5E5E5]">
    See more
</span>

                                    <!-- See More Modal -->
                                    <% String take6 = "show_more_modal_" + i; %>
                                    <dialog id="<%= take6 %>" class="modal w-[100vw] h-[100vh]">
                                        <p>This is the 'See More' modal.</p>
                                        <button onclick="this.parentElement.close();">Close</button>
                                    </dialog>

                                    <div class="modal-box max-w-[90vw] max-h-[70vh] w-full h-auto lg:w-auto">
                                            <form method="dialog">
                                                <button
                                                    class="btn btn-sm btn-circle btn-error text-white absolute right-2 top-2">X</button>
                                            </form>
                                            <p class="text-justify mt-4 text-[24px]">
                                                <!-- Full Text -->
                                                <%=Description.get(i)%>
                                            </p>
                                        </div>
                                    </dialog>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Post1 end -->
<%} %>
                 
                </div>
            </div>
        </div>
    </div>


    <!-- Start of Footer -->
    <div class='flex justify-between gap-0'>
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
<%!
    String encodeBlobToBase64(Blob blob) {
        try {
        	
            byte[] byteArray = blob.getBytes(1, (int) blob.length());
            byte[] base64Bytes = java.util.Base64.getEncoder().encode(byteArray);
            
            return new String(base64Bytes);
        } catch (Exception e) {
        	System.out.println("exception");
            e.printStackTrace();
            return "";
        }
    }
    %>

    <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    <script>
        AOS.init();
    </script>
</body>
