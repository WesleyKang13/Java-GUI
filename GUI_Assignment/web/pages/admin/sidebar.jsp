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
    <link href=<%=ROOT_PATH + "css/admin/admin_general.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "css/admin/sidebar.css"%> rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet">
    <link href=<%=ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet">
    
    <title>Admin Panel | Banana's Shoe Store</title> 
</head>
<body class="<%=theme%>">
    <nav class="sidebar <%=sideBarStatus%>">
        <header>
            <div class="profile">
                <span class="picture">
                    <img src="https://dummyimage.com/300" alt="Profile Picture">
                </span>

                <div class="text profile-text">
                    <h3 class="username text">Tiger Home</h3>
                    <p class="position text">Administrator</p>
                </div>
            </div>

            <a href="?toggleSideBar=true"><i class="fa-solid fa-chevron-right toggle"></i></a>
        </header>

        <div class="menu-bar">
            <div class="menu">
                <ul class="menu-links">
                    <li class="nav-link dashboard">
                        <a href="<%=ROOT_PATH + "pages/admin/dashboard.jsp"%>">
                            <i class="fa-solid fa-chart-line icon"></i>
                            <span class="text nav-text">Dashboard</span>
                        </a>
                    </li>
                    
                    <li class="nav-link customer">
                        <a href="<%=ROOT_PATH + "pages/admin/LoadCustomer"%>">
                            <i class="fa-solid fa-address-book icon"></i>
                            <span class="text nav-text">Customer</span>
                        </a>
                    </li>

                    <li class="nav-link product">
                        <a href="<%=ROOT_PATH + "pages/admin/LoadProduct"%>">
                            <i class="fa-solid fa-boxes-stacked icon"></i>
                            <span class="text nav-text">Product</span>
                        </a>
                    </li>

                    <li class="nav-link order">
                        <a href="<%=ROOT_PATH + "pages/admin/LoadOrder"%>">
                            <i class="fa-solid fa-cart-flatbed icon"></i>
                            <span class="text nav-text">Order</span>
                        </a>
                    </li>

                    <li class="nav-link staff">
                        <a href="<%=ROOT_PATH + "pages/admin/LoadStaff"%>">
                            <i class="fa-solid fa-id-card-clip icon"></i>
                            <span class="text nav-text">Staff *</span>
                        </a>
                    </li>

                    <li class="nav-link report">
                        <a href="<%=ROOT_PATH + "pages/admin/report.jsp"%>">
                            <i class="fa-solid fa-chart-pie icon"></i>
                            <span class="text nav-text">Report *</span>
                        </a>
                    </li>

                    <li class="nav-link inquiry">
                        <a href="<%=ROOT_PATH + "pages/admin/inquiry.jsp"%>">
                            <i class="fa-solid fa-clipboard-question icon"></i>
                            <span class="text nav-text">Inquiry</span>
                        </a>
                    </li>
                    <li class="nav-link home">
                        <a href="<%=ROOT_PATH+"index.html"%>">
                            <i class="fa-solid fa-house icon"></i>
                            <span class="text nav-text">Home Page</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="bottom-content">
                <li class="userSetting">
                    <a href="<%=ROOT_PATH+"pages/admin/LoadSetting"%>">
                        <i class="fa-solid fa-gears icon"></i>
                        <span class="text nav-text">Setting</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <i class="fa-solid fa-arrow-right-from-bracket icon"></i>
                        <span class="text nav-text">Logout</span>
                    </a>
                </li>

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
