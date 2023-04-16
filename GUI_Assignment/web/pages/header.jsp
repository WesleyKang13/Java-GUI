<% String ROOT_PATH = request.getParameter("ROOT_PATH"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href=<%= ROOT_PATH + "css/headerFooter.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">
        <title>Banana's Shoe Store</title>
    </head>
    
    <header>
        <!-- Header 2 -->
        <div style="background-color:#BEBEBE; padding-top: 15px;">
          <div class="container">
            <ul class="ul">
              <li class="logo"><a href="<%=ROOT_PATH + "index.html"%>"><img src=<%=ROOT_PATH + "banana.png"%> class="icon"></a></li>
              <li class="li-1"><a href=<%=ROOT_PATH + "home.jsp"%>>Home</a></li>
              <li class="li-2"><a href="#">New &amp; Featured</a></li>
              <li class="li-3"><a href="#">Brand</a></li>
              <li class="li-3"><a href="#">About Us</a></li>
              <li class="li-3"><a href="#">Men</a></li>
              <li class="li-3"><a href="#">Women</a></li>
              <li class="li-3"><a href="#">Kids</a></li>
              <li class="li-3"><a href=<%=ROOT_PATH + "pages/contactUs.jsp"%>>Help</a></li>
            </ul>
            <div class="container-2">
              <form action="#" method="get" style="letter-spacing: 0.2em;">
                <div class="search-container">
                  <input class="search" type="text" placeholder="Search">
                  <button type="submit" class="search-button">
                  <i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
              </form>
              <form action="#" method="get" >
              <button type="submit" class="favourite-button">
              <i class="fa-solid fa-heart"></i></button>
              </form>
              <form action="#" method="get">
              <button type="submit" class="cart-button">
              <i class="fa-solid fa-cart-shopping"></i></button>
            </form>
            <form action="#" method="get">
              <button type="submit" class="user-registration">
              <i class="fa-solid fa-user"></i></button>
            </form>
            </div>
          </div>
        </div>
      </header>
