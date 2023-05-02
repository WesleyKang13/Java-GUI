<% String ROOT_PATH = ""; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

 <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href=<%= ROOT_PATH + "css/home.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">
        
 </head>
 
 
<%
    boolean successLogin = request.getParameter("successLogin") != null ? true : false;
    if(successLogin){ 
%>
    <script>
        window.onload = function() {
            alert("Login Successful! Welcome, <%=session.getAttribute("userName")%>!");
        };
    </script>
<% } %>
 
<!--Main Page -->
<body>
  <h1 style="margin-left: 2em;">Featured</h1>
     <div class="image-container">
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/running-01.jpg" style="width: 1170px; height:700px;">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct"%> class="button-link"><button style="border-radius: 50px;">Shop</button></a>
        </div>
        </div>
    </div>
    <!-- Promotion -->
    <h1 style="margin-left: 1.85em;">Promotion!</h1>
    <div style="margin-right: 0.5em;"class="slideshow-container">
      <div class="mySlides fade">
        <div class="numbertext">1 / 5</div>
        <img src="./assets/homepage/5d2df70f21a86126ee75f087.webp" style="width:1170px; height: 510px;">
<!--        <a href="#" class="button-link2"><button class="button-promotion" style="border-radius: 50px; size: 1000px; "><strong>BUY NOW</strong></button></a>-->
      </div>
      <div class="mySlides fade">
        <div class="numbertext">2 / 5</div>
        <img src="./assets/homepage/landscape-1490382030-nike-2by1.jpg" style="width:1170px; height: 510px;">
<!--        <a href="#" class="button-link2"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>-->
      </div> 
      <div class="mySlides fade">
        <div class="numbertext">3 / 5</div>
        <img src="./assets/homepage/landscape-1504099087-lead-ajxxxii-rossa-scissors-tw-original.jpg" style="width:1170px; height: 510px;">
<!--        <a href="#" class="button-link2"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>-->
      </div>
      <div class="mySlides fade">
        <div class="numbertext">4 / 5</div>
        <img src="./assets/homepage/E-4aSHXVcBEnsWN.jpg" style="width:1170px; height: 510px;">
<!--        <a href="#" class="button-link2"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>-->
      </div>
      <div class="mySlides fade">
        <div class="numbertext">5 / 5</div>
        <img src="./assets/homepage/5b71921c959f341c008b4efe.webp" style="width:1170px; height: 510px;">
<!--        <a href="#" class="button-link2"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>-->
      </div>
      <a class="prev" onclick="plusSlides(-1)"><i class="fa-solid fa-chevron-left"></i></a>
      <a class="next" onclick="plusSlides(1)"><i class="fa-solid fa-chevron-right"></i></a>
      </div>
      <br>
      <div style="text-align:center">
        <span class="dot" onclick="currentSlide(1)"></span> 
        <span class="dot" onclick="currentSlide(2)"></span> 
        <span class="dot" onclick="currentSlide(3)"></span> 
        <span class="dot" onclick="currentSlide(4)"></span> 
        <span class="dot" onclick="currentSlide(5)"></span> 
      </div>
    <!--End Promotion-->
    <!--New Arrivals-->
    <h1 style="margin-left: 1.85em;">New Arrivals</h1>
    <div class="image-container">
        <div class="body-container">
        <img src="./assets/homepage/79b50ced-3832-4aa4-bc3a-a963c5950e1b.webp" style="width: 380px; height:450px;">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=MEN"%> class="button-link3"><button class="arrival-button" style="border-radius: 50px;" class="arrial-button">Men's</button></a>
        </div>
        <div class="body-container">
        <img src="./assets/homepage/69bb9b94-5771-4b28-b436-4053764876c6.webp"  style="width: 380px; height:450px;" alt="image2">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=WOMEN"%> class="button-link4"><button class="arrival-button" style="border-radius: 50px; padding-right:80px;">Women's</button></a>
        </div>
        <div class="body-container">
        <img src="./assets/homepage/cee09af6-6ecc-4eb0-8148-eac6f9153931.webp"  style="width: 380px; height:450px;" alt="image3">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=KIDS"%> class="button-link5"><button class="arrival-button" style="border-radius: 50px;">Kids's</button></a>
        </div>
        </div>
    <!--End New Arrivals-->
    <!--Essentials-->
    <h1 style="margin-left: 1.85em;">The Essentials</h1>
        <div class="image-container">
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/renew-run-4-road-running-shoes-lxfK8c.jfif" style="width: 380px; height:400px;" >
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=MEN"%> class="button-link6"><button class="essential-button" style="border-radius: 50px;">Men's</button></a>
        </div>
        </div>
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/d8e2dff5-ce00-4cda-849b-641e6157ef92.webp"  style="width: 380px; height:400px;" alt="image2">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=WOMEN"%> class="button-link6"><button  class="essential-button"  style="border-radius: 50px; padding-right:80px;">Women's</button></a>
        </div>
        </div>
        <div style="position: relative;">    
        <div class="body-container">
        <img src="./assets/homepage/1990f818-45b2-49a8-92fb-595aa580bf55.webp"  style="width: 380px; height:400px;" alt="image2">
        <a href=<%=ROOT_PATH + "pages/product/FindProduct?productType=KIDS"%> class="button-link6"><button  class="essential-button" style="border-radius: 50px;">Kids's</button></a>
        </div>
        </div>
        </div>
    <!--End Essentials-->
    <!--Slider function-->
        <script>
          let slideIndex = 1;
          showSlides(slideIndex);
          
          function plusSlides(n) {
            showSlides(slideIndex += n);
          }
          
          function currentSlide(n) {
            showSlides(slideIndex = n);
          }
          
          function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let dots = document.getElementsByClassName("dot");
            if (n > slides.length) {slideIndex = 1}    
            if (n < 1) {slideIndex = slides.length}
            for (i = 0; i < slides.length; i++) {
              slides[i].style.display = "none";  
            }
            for (i = 0; i < dots.length; i++) {
              dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex-1].style.display = "block";  
            dots[slideIndex-1].className += " active";
          }
          </script>
    <!--End slider-->
</body>

<!-- Main Page End -->

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

