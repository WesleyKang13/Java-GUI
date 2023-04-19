<% String ROOT_PATH = request.getParameter("ROOT_PATH"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<body>
    <nav class="sidebar">
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

            <i class="fa-solid fa-chevron-right toggle"></i>
        </header>

        <div class="menu-bar">
            <div class="menu">
                <ul class="menu-links">
                    <li class="nav-link dashboard">
                        <a href="dashboard.jsp">
                            <i class="fa-solid fa-chart-line icon"></i>
                            <span class="text nav-text">Dashboard</span>
                        </a>
                    </li>
                    
                    <li class="nav-link customer">
                        <a href="LoadCustomer">
                            <i class="fa-solid fa-address-book icon"></i>
                            <span class="text nav-text">Customer</span>
                        </a>
                    </li>

                    <li class="nav-link product">
                        <a href="product.jsp">
                            <i class="fa-solid fa-boxes-stacked icon"></i>
                            <span class="text nav-text">Product</span>
                        </a>
                    </li>

                    <li class="nav-link order">
                        <a href="order.jsp">
                            <i class="fa-solid fa-cart-flatbed icon"></i>
                            <span class="text nav-text">Order</span>
                        </a>
                    </li>

                    <li class="nav-link staff">
                        <a href="staff.jsp">
                            <i class="fa-solid fa-id-card-clip icon"></i>
                            <span class="text nav-text">Staff *</span>
                        </a>
                    </li>

                    <li class="nav-link report">
                        <a href="report.jsp">
                            <i class="fa-solid fa-chart-pie icon"></i>
                            <span class="text nav-text">Report *</span>
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
                <li>
                    <a href="#">
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

                <li class="mode">
                    <div class="sun-moon">
                        <i class='fa-solid fa-moon icon moon'></i>
                        <i class='fa-solid fa-sun icon sun'></i>
                    </div>
                    <span class="mode-text text">Light mode</span>

                    <div class="toggle-switch">
                        <span class="switch"></span>
                    </div>
                </li>
            </div>
        </div>
    </nav>

    <script src=<%=ROOT_PATH + "js/admin/sidebar.js"%>></script>
