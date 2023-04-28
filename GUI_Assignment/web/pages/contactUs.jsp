<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
<head>
   <link href=<%= ROOT_PATH + "css/contactUs.css"%> rel="stylesheet" type="text/css">
</head>
<body>
      </div>
      <div class="containers">
        <div class="image-container">
            <img src="./../assets/homepage/contact-1x-63f497a00aa4a-sej.webp" alt="image1">
            </div>
            <div class="text-container">
              <h1>Have Questions?</h1>
              <h2>Shoot us an email!</h2>
              <p>At Banana Shoe, we offer affordable and stylish footwear that matches your unique style. Our high-quality shoes come with excellent customer service to help you find the perfect pair for any occasion
              <br />
              <br />
              Have a question for us or feedback? Contact us today to learn more about our products and services!</p>
            </div>
      </div>
      <div class="container-location">
        <img src="./../assets/homepage/location-global.svg">
      </div>
      <br/>
      <div class="address">
         <h4>Address:</h4>
         <p><i class="fa-solid fa-location-dot"></i> Banana Town Lot Banana 123 i love timothy</p>
         <br/>
         <h4>Email:</h4>
         <p><i class="fa-solid fa-envelope"></i> TimothyLover@gay.com</p>
         <br/>
         <h4>Call Us:</h4>
         <p><i class="fa-solid fa-phone"></i>  21343121491</p>
      </div>    
      <div class="contact-form">
        <h3>Contact Us</h3>
       <%-- Display the success message if it exists --%>
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="notificationBox success">
                <span class="message"><%= request.getAttribute("successMessage") %></span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>
        <% } %>
        <form action="InquiryCustomer" method="POST">
          <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
          </div>
          <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
          </div>
          <div class="form-group">
            <label for="subject">Subject:</label>
            <input type="text" id="subject" name="subject" required>
          </div>
          <div class="form-group">
            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="5" required></textarea>
          </div>
          <button class="submit-button" type="submit">Send Message</button>
        </form>
      </div>
    </div>
</body>

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
