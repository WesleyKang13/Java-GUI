<% String ROOT_PATH = ""; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<style>

  body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
  }
  
  .icon{
    transform: translateY(-7px);
  }
  
  .image-container {
    display: flex;
    justify-content: space-between;
  }
  
  .body-container {
    display: grid;
    grid-template-columns: 70px 70px 70px;
    padding: 0px 0px 0px 5px;
    margin-left: -9em;
    color: #fff;
  }
  
  
  .button-promotion{
    background-color: transparent;
    font-weight: bold;
    color: red;
    width: 120px;
  }
  
  .arrival-button{
    background-color:black;
    color:white;
  }
  
  .arrival-button:hover{
    background-color:#606060;
  }
  
  .essential-button{
    background-color:black;
    color:white;
  }
  
  .essential-button:hover{
    background-color:#606060;
  }
  
  
  * {box-sizing: border-box}
  body {font-family: Verdana, sans-serif; margin:0}
  .mySlides {display: none}
  img {vertical-align: middle;}
  
  /* Slideshow container */
  .slideshow-container {
    max-width: 1200px;
    position: relative;
    margin: auto;
  }
  
  /* Next & previous buttons */
  .prev, .next {
    cursor: pointer;
    position: absolute;
    top: 50%;
    width: auto;
    padding: 16px;
    margin-top: -22px;
    color: white;
    font-weight: bold;
    font-size: 18px;
    transition: 0.6s ease;
    border-radius: 0 3px 3px 0;
    user-select: none;
  }
  
  /* Position the "next button" to the right */
  .next {
    margin-left: 62.7em;
    border-radius: 3px 0 0 3px;
  }
  
  /* On hover, add a black background color with a little bit see-through */
  .prev:hover, .next:hover {
    background-color: rgba(0,0,0,0.8);
  }
  
  /* Caption text */
  .text-promo {
    color: red;
    font-size: 30px;
    padding: 8px 12px;
    position: absolute;
    bottom: 8px;
    width: 100%;
    text-align: center;
  }
  
  /* Number text (1/3 etc) */
  .numbertext {
    color: #f2f2f2;
    font-size: 12px;
    padding: 8px 12px;
    position: absolute;
    top: 0;
  }
  
  /* The dots/bullets/indicators */
  .dot {
    cursor: pointer;
    height: 15px;
    width: 15px;
    margin: 0 2px;
    background-color: #bbb;
    border-radius: 50%;
    display: inline-block;
    transition: background-color 0.6s ease;
  }
  
  .active, .dot:hover {
    background-color: #717171;
  }
  
  /* Fading animation */
  .fade {
    animation-name: fade;
    animation-duration: 1.5s;
  }
  
  @keyframes fade {
    from {opacity: .4} 
    to {opacity: 1}
  }
  
  /* On smaller screens, decrease text size */
  @media only screen and (max-width: 300px) {
    .prev, .next,.text {font-size: 11px}
  }
  </style>

    

<!--Main Page -->
<body>
  <h1 style="margin-left: 2em;">Featured</h1>
     <div class="image-container" style="background-color:white; padding: 10px 200px 50px 200px;">
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/istockphoto-1324624694-170667a.jpg" style="width: 1170px; height:700px;" alt="image1">
        <a href="#" class="button-link" style="position: absolute; top: 85%; left: -80px;"><button style="border-radius: 50px;">Shop</button></a>
        </div>
        </div>
    </div>
    <!-- Promotion -->
    <h1 style="margin-left: 1.85em;">Promotion</h1>
    <div style="margin-right: 0.5em;"class="slideshow-container">
      <div class="mySlides fade">
        <div class="numbertext">1 / 5</div>
        <img src="./assets/homepage/5d2df70f21a86126ee75f087.webp" style="width:1170px; height: 510px;">
        <a href="#" class="button-link" style="position: absolute; top: 87%; left: 520px; "><button class="button-promotion" style="border-radius: 50px; size: 1000px; "><strong>BUY NOW</strong></button></a>
      </div>
      <div class="mySlides fade">
        <div class="numbertext">2 / 5</div>
        <img src="./assets/homepage/landscape-1490382030-nike-2by1.jpg" style="width:1170px; height: 510px;">
        <a href="#" class="button-link" style="position: absolute; top: 87%; left: 520px;"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>
      </div> 
      <div class="mySlides fade">
        <div class="numbertext">3 / 5</div>
        <img src="./assets/homepage/landscape-1504099087-lead-ajxxxii-rossa-scissors-tw-original.jpg" style="width:1170px; height: 510px;">
        <a href="#" class="button-link" style="position: absolute; top: 87%; left: 520px;"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>
      </div>
      <div class="mySlides fade">
        <div class="numbertext">4 / 5</div>
        <img src="./assets/homepage/E-4aSHXVcBEnsWN.jpg" style="width:1170px; height: 510px;">
        <a href="#" class="button-link" style="position: absolute; top: 87%; left: 520px;"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>
      </div>
      <div class="mySlides fade">
        <div class="numbertext">5 / 5</div>
        <img src="./assets/homepage/5b71921c959f341c008b4efe.webp" style="width:1170px; height: 510px;">
        <a href="#" class="button-link" style="position: absolute; top: 87%; left: 520px;"><button class="button-promotion" style="border-radius: 50px;"><strong>BUY NOW</strong></button></a>
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
    <div class="image-container" style="background-color:white; padding: 10px 200px 50px 200px;">
        <div class="body-container">
        <img src="./assets/homepage/79b50ced-3832-4aa4-bc3a-a963c5950e1b.webp" style="width: 380px; height:450px;" alt="image1">
        <a href="#" class="button-link" style="position: absolute; margin-left: 50px; margin-top: 350px;"><button class="arrival-button" style="border-radius: 50px;" class="arrial-button">Men's</button></a>
        </div>
        <div class="body-container">
        <img src="./assets/homepage/69bb9b94-5771-4b28-b436-4053764876c6.webp"  style="width: 380px; height:450px;" alt="image2">
        <a href="#" class="button-link" style="position: absolute; margin-left: 35px; margin-top: 350px;"><button class="arrival-button" style="border-radius: 50px; padding-right:80px;">Women's</button></a>
        </div>
        <div class="body-container">
        <img src="./assets/homepage/cee09af6-6ecc-4eb0-8148-eac6f9153931.webp"  style="width: 380px; height:450px;" alt="image3">
        <a href="#" class="button-link"style="position: absolute; margin-left: 30px; margin-top: 350px;"><button class="arrival-button" style="border-radius: 50px;">Kids's</button></a>
        </div>
        </div>
    <!--End New Arrivals-->
    <!--Essentials-->
    <h1 style="margin-left: 1.85em;">The Essentials</h1>
        <div class="image-container" style="background-color:white; padding: 10px 200px 50px 200px;">
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/renew-run-4-road-running-shoes-lxfK8c.jfif" style="width: 380px; height:400px;" alt="image1">
        <a href="#" class="button-link" style="position: absolute; top: 80%; left: -80px;"><button class="essential-button" style="border-radius: 50px;">Men's</button></a>
        </div>
        </div>
        <div style="position: relative;">
        <div class="body-container">
        <img src="./assets/homepage/d8e2dff5-ce00-4cda-849b-641e6157ef92.webp"  style="width: 380px; height:400px;" alt="image2">
        <a href="#" class="button-link" style="position: absolute; top: 80%; left: -80px;"><button  class="essential-button"  style="border-radius: 50px; padding-right:80px;">Women's</button></a>
        </div>
        </div>
        <div style="position: relative;">    
        <div class="body-container">
        <img src="./assets/homepage/1990f818-45b2-49a8-92fb-595aa580bf55.webp"  style="width: 380px; height:400px;" alt="image2">
        <a href="#" class="button-link" style="position: absolute; top: 80%; left: -80px;"><button  class="essential-button" style="border-radius: 50px;">Kids's</button></a>
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

