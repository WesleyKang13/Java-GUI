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
        
        <link rel="icon" type="image/x-icon" href="<%=ROOT_PATH + "banana.png"%>">
        <title><%=getServletContext().getInitParameter("companyName")%></title>
    </head>
    
    <header>
        <!-- Header 2 -->
        <div style="background-color: #B8B8B8; padding-top: 15px;">
          <div class="container">
            <ul class="main-ul">
              <li class="logo" style="margin-right: 70px; top: 50%;  left: 50%; transform: translate(-50%, -20%);">
              <a href="<%=ROOT_PATH + "index.jsp"%>"><img src=<%=ROOT_PATH + "banana.png"%> class="icons"></a></li>
              <li class="li-1"><a href=<%=ROOT_PATH + "index.jsp"%>>Home</a></li>
              <li class="li-2"><a href=<%=ROOT_PATH + "pages/product/FindProduct"%>>Product</a></li>
              <li class="li-3"><a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=MEN"%>>Men</a></li>
              <li class="li-3"><a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=WOMEN"%>>Women</a></li>
              <li class="li-3"><a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=KIDS"%>>Kids</a></li>
              <li class="li-3"><a href=<%=ROOT_PATH + "pages/contactUs.jsp"%>>Help</a></li>
              <li class="li-3"><a href="<%=ROOT_PATH + "pages/aboutUs.jsp"%>">About Us</a></li>
            </ul>
            <div class="container-2">
              <form action="#" method="get" style="letter-spacing: 0.2em;">
                <div class="search-container">
                  <input class="search" type="text" placeholder="Search">
                  <button type="submit" class="search-button">
                  <i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
              </form>
              <form action="<%=ROOT_PATH + "pages/customer/FindCheckout"%>" method="get" >
              <button type="submit" class="favourite-button">
              <i class="fa-solid fa-cash-register"></i></button>
              </form>
              <form action="<%=ROOT_PATH + "pages/customer/FindCart"%>" method="get">
              <button type="submit" class="cart-button">
              <i class="fa-solid fa-cart-shopping"></i></button>
            </form>
            <%
                String userRedirect=ROOT_PATH + "pages/UserLogin.jsp";
                if(session.getAttribute("userPermission")!=null){
                    int userPermission = (Integer)session.getAttribute("userPermission");
                    if(userPermission==0 || userPermission==1){
                        userRedirect=ROOT_PATH + "pages/admin/dashboard.jsp";
                    }else if(userPermission==2){
                        userRedirect=ROOT_PATH + "pages/customer/panel/dashboard.jsp";
                    }
                }
            %>
            <form action="<%=userRedirect%>" method="get">
              <button type="submit" class="user-registration">
                  <i class="fa-solid fa-user"></i></button>
            </form>
            </div>
          </div>
        </div>
      </header>
