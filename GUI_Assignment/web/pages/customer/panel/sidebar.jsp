<%@page import="java.util.ArrayList"%>
<% String ROOT_PATH = request.getParameter("ROOT_PATH"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Theme (Dark or Light Mode)
    String theme="";
    // Check if the user behavior data already exists in the session
    if(request.getParameter("changeTheme")!=null){
        if (session.getAttribute("theme") != null) {
            theme = (String) session.getAttribute("theme");
        } else {
            theme = "light";
        }
        
        if(theme.equals("light")){
            theme = "dark";
        } else {
            theme = "light";
        }

        // Store the updated theme in the session
        session.setAttribute("theme", theme);
    } else {
        // If there is no changeTheme parameter, get the current theme from the session
        if (session.getAttribute("theme") != null) {
            theme = (String) session.getAttribute("theme");
        } else {
            theme = "light";
        }
    }
    
    //Theme (Dark or Light Mode)
    String sideBarStatus="";
    // Check if the user behavior data already exists in the session
    if(request.getParameter("toggleSideBar")!=null){
        if (session.getAttribute("sideBarStatus") != null) {
            sideBarStatus = (String) session.getAttribute("sideBarStatus");
        } else {
            sideBarStatus = "open";
        }
        
        if(sideBarStatus.equals("open")){
            sideBarStatus = "close";
        } else {
            sideBarStatus = "open";
        }

        // Store the updated sideBarStatus in the session
        session.setAttribute("sideBarStatus", sideBarStatus);
    } else {
        // If there is no changeTheme parameter, get the current sideBarStatus from the session
        if (session.getAttribute("sideBarStatus") != null) {
            sideBarStatus = (String) session.getAttribute("sideBarStatus");
        } else {
            sideBarStatus = "open";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <link href=<%=ROOT_PATH + "css/reset.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "css/customer/panel/customerPanel_general.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "css/customer/panel/sidebar.css"%> rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet">
    
    <link rel="icon" type="image/x-icon" href="<%=ROOT_PATH + "banana.png"%>">
    
    <title>Customer Panel | Banana's Shoe Store</title> 
</head>
<body class="<%=theme%>">
    <nav class="sidebar <%=sideBarStatus%>">
        <header>
            <div class="profile">
                <span class="picture">
                    <img src="<%=ROOT_PATH + "assets/user.png"%>" alt="Profile Picture">
                </span>

                <div class="text profile-text">
                    <h3 class="username text"><%=session.getAttribute("customerFullName")%></h3>
                    <p class="position text">Customer</p>
                </div>
            </div>

            <a href="?toggleSideBar=true"><i class="fa-solid fa-chevron-right toggle"></i></a>
        </header>

        <div class="menu-bar">
            <div class="menu">
                <ul class="menu-links">
                    <li class="nav-link dashboard">
                        <a href="<%=ROOT_PATH + "pages/customer/panel/dashboard.jsp"%>">
                            <i class="fa-solid fa-chart-line icon"></i>
                            <span class="text nav-text">Dashboard</span>
                        </a>
                    </li>

                    <li class="nav-link order">
                        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadOrder"%>">
                            <i class="fa-solid fa-cart-flatbed icon"></i>
                            <span class="text nav-text">Order</span>
                        </a>
                    </li>

                    <li class="nav-link payment">
                        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadPayment"%>">
                            <i class="fa-solid fa-money-check-dollar icon"></i>
                            <span class="text nav-text">Payment</span>
                        </a>
                    </li>

                    <li class="nav-link review">
                        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadReview"%>">
                            <i class="fa-solid fa-comments icon"></i>
                            <span class="text nav-text">Review</span>
                        </a>
                    </li>

                    <li class="nav-link home">
                        <a href="<%=ROOT_PATH+"index.jsp"%>">
                            <i class="fa-solid fa-house icon"></i>
                            <span class="text nav-text">Home Page</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="bottom-content">
                <li class="userSetting">
                    <a href="<%=ROOT_PATH+"pages/customer/panel/LoadSetting"%>">
                        <i class="fa-solid fa-gears icon"></i>
                        <span class="text nav-text">Setting</span>
                    </a>
                </li>

                <li>
                    <a href="#" onclick="logout();">
                        <i class="fa-solid fa-arrow-right-from-bracket icon"></i>
                        <span class="text nav-text">Logout</span>
                    </a>
                </li>

                <script>
                    function logout() {
                        var response = confirm("Are you sure you want to logout?");
                        if (response == true) {
                            window.location.href = '<%=ROOT_PATH+"pages/LogoutAccount?ROOT_PATH="+ROOT_PATH%>';
                        }
                    }
                </script>

                <a href="?changeTheme=true">
                    <li class="mode">
                        <div class="sun-moon">
                            <i class='fa-solid fa-moon icon moon'></i>
                            <i class='fa-solid fa-sun icon sun'></i>
                        </div>
                        <% if(theme.equals("light")){%>
                            <span class="mode-text text">Light mode</span>
                        <% }else if(theme.equals("dark")){%>
                            <span class="mode-text text">Dark mode</span>
                        <% }%>
                        <div class="toggle-switch">
                            <span class="switch"></span>
                        </div>
                    </li>
                </a>
            </div>
        </div>
    </nav>
