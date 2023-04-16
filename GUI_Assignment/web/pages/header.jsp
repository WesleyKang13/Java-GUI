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
          <div class="container" style="display:flex; justify-content:space-between; align-items:center; font-size: 15px;">
            <ul style="display:flex; list-style:none; letter-spacing: 0.1em;">
              <li style="margin-left: 0em; margin-right: 1.5em;"><a href="<%=ROOT_PATH + "index.html"%>" style="text-decoration:none; color:#333;"><img src=<%=ROOT_PATH + "banana.png"%>  class="icon" style="width: 40px; top:35px;" alt="image1"></a></li>
              <li style="margin-left: 11em; margin-right: 0.5em;"><a href=<%=ROOT_PATH + "home.jsp"%> style="text-decoration:none; color:#333;">Home</a></li>
              <li style="margin-left: 1em; margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">New &amp; Featured</a></li>
              <li style="margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">Brand</a></li>
              <li style="margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">About Us</a></li>
              <li style="margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">Men</a></li>
              <li style="margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">Women</a></li>
              <li style="margin-right: 1em;"><a href="#" style="text-decoration:none; color:#333;">Kids</a></li>
              <li style="margin-right: 1em;"><a href=<%=ROOT_PATH + "pages/contactUs.jsp"%> style="text-decoration:none; color:#333;">Help</a></li>
            </ul>
            <div style="display:flex; align-items:center; margin-right: 2.3em; padding-bottom: 10px;">
              <form action="#" method="get" style="letter-spacing: 0.2em;">
                <div style="position:relative;">
                  <input type="text" placeholder="Search" style="padding:8px 8px 8px 10px; border-radius:50px; border-style: ridge; margin-right:15px; width: 180px;">
                  <button type="submit" class="search-button" style="padding: 0px 0px; margin: 2px 30px 0px 10px; border:none; border-radius:50px; position:absolute; top:0; right:0;"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
              </form>
              <form action="#" method="get" >
              <button type="submit" class="favourite-button"  style="padding: 0px 0px; margin: 0px 0px 0px 0px; border:none; border-radius:50px;"><i class="fa-solid fa-heart"></i></button>
              </form>
              <form action="#" method="get">
              <button type="submit" class="cart-button"  style="padding: 0px 0px; margin: 0px 0px 0px 0px; border:none; border-radius:50px; margin-left: 1em;"><i class="fa-solid fa-cart-shopping"></i></button>
            </form>
            <form action="#" method="get">
              <button type="submit" class="user-registration"  style="padding: 0px 0px; margin: 0px 0px 0px 0px; border:none; border-radius:50px; margin-left: 1em;"><i class="fa-solid fa-user"></i></button>
            </form>
            </div>
          </div>
        </div>
      </header>
