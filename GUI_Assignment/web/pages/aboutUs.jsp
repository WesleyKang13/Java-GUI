<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href=<%= ROOT_PATH + "css/aboutUs.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css"> 
    </head>
    <body>
        <div class="container-about">
             <img class="about_US" src="./../assets/homepage/1913108.jpg">
             <h1 class="heading1">About Us</h1>
             <p class="about_us">At Banana Shoe, 
             we believe that every step you take should be a confident and stylish one. 
             That's why we offer a wide selection of shoes for all occasions, 
             from casual to dressy, all at affordable prices.</p>
        </div>
        <div class="container-about2">
            <div class="grid-item">
                <img class="svg-image1" src="./../assets/homepage/sneaker.svg">
                <h2>Verified Stock</h2>
                <p class="about_us1">Every item sold goes through our proprietary multi-step 
                 verification process with our team of expert authenticators.</p>
            </div>
            <div class="grid-item">
                <img class="svg-image2" src="./../assets/homepage/icons8-price-tag-64.png">
                <h2>Affordable Price</h2>
                <p class="about_us1">Banana Shoe provides our customers with 
                    high-quality shoes at affordable prices.</p>
            </div>
            <div class="grid-item">
                <img class="svg-image3" src="./../assets/homepage/globe.svg">
                <h2>Global Access</h2>
                <p class="about_us1">Whether it?s pre-release, regionally limited, or ?sold out? 
                 ? our millions of customers from over 200 countries allow you to 
                 easily secure those hard-to-find, coveted items.</p>
            </div>
            <div class="grid-item">
                <img class="svg-image4" src="./../assets/homepage/no-bs.svg">
                <h2>100% Original</h2>
                <p class="about_us1">We take pride in offering our customers only 100% authentic 
                    and original shoes, ensuring that you receive the highest quality products every time you 
                    shop with us.</p>
            </div>
            <div class="grid-item">
                <img class="svg-image5" src="./../assets/homepage/lock.svg">
                <h2>Trusted</h2>
                <p class="about_us1">We have built a reputation as a trusted online shoe retailer 
                    through our commitment to customer satisfaction, quality products, and reliable
                    service. You can shop with confidence knowing that your satisfaction is our top
                    priority.</p>
            </div>
            <div class="grid-item">
                <img class="svg-image6" src="./../assets/homepage/customer-service.svg">
                <h2>Here For You</h2>
                <p class="about_us1">We are committed to providing our customers with exceptional
                    service and support. Whether you have questions about our products, shipping, 
                    or returns, our friendly and knowledgeable team is always here to assist you 
                    every step of the way.</p>
            </div>
        </div>
        <h2 style="margin-left: 80px;">Meet our amazing team! We're thrilled to have you here
        <i class="fa-solid fa-hand-point-down fa-flip-horizontal" 
        style=" transform: translateY(5px);"></i></h2>
         <div class="circle-container">
            <div class="grid-profile1">
                <img class="svg-image6" src="./../assets/homepage/fetchimage.webp">
                <h2>Wesley Kang</h2>
                <p class="about_us1">Founder Of Banana Shoe</p>
                <p class="about_us1">Age: 2</p>
                <p class="about_us1">Height: 30cm</p>
                <p class="about_us1">Status: Unknown</p> 
                </br>
            </div> 
            <div class="grid-profile2">
                <img class="svg-image6" src="./../assets/homepage/MV5BNjhlYTE2YjUtYzgxMS00OWY1LTk3YzItY2RjMmQ2MjM0MjMzXkEyXkFqcGdeQXVyMzkyOTg1MzE@._V1_QL75_UY281_CR94,0,190,281_.jpg"">
                <h2>Timothy Wong</h2>
                <p class="about_us1">COO Of Banana Shoe</p>
                <p class="about_us1">Age: 89</p>
                <p class="about_us1">Height: 50cm</p>
                <p class="about_us1">Status: Married</p> 
                </br>
            </div>   
            <div class="grid-profile3">
                 <img class="svg-image6" src="./../assets/homepage/images.jfif">
                 <h2>Yap Wai Meng</h2>
                 <p class="about_us1">CAO Of Banana Shoe</p>
                 <p class="about_us1">Age: 55</p>
                 <p class="about_us1">Height: 90cm</p>
                 <p class="about_us1">Status: Married</p> 
                 </br>
            </div>
             <div class="grid-profile3">
                 <img class="svg-image6" src="./../assets/homepage/download.jfif">
                 <h2>Cliffton Chin</h2>
                 <p class="about_us1">CAO Of Banana Shoe</p>
                 <p class="about_us1">Age: 55</p>
                 <p class="about_us1">Height: 90cm</p>
                 <p class="about_us1">Status: Married</p> 
                 </br>
            </div>
             <div class="grid-profile3">
                 <img class="svg-image6" src="./../assets/homepage/andrew.jfif">
                 <h2>Adriel The Mermaid</h2>
                 <p class="about_us1">CAO Of Banana Shoe</p>
                 <p class="about_us1">Age: 55</p>
                 <p class="about_us1">Height: 90cm</p>
                 <p class="about_us1">Status: Married</p> 
                 </br>
            </div>
              <div class="grid-profile3">
                 <img class="svg-image6" src="./../assets/homepage/FpmuUeOakAI9zZW.jfif">
                 <h2>Iven keng</h2>
                 <p class="about_us1">CAO Of Banana Shoe</p>
                 <p class="about_us1">Age: 55</p>
                 <p class="about_us1">Height: 90cm</p>
                 <p class="about_us1">Status: Married</p> 
                 </br>
            </div>
        </div>
    </body>
</html>
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>