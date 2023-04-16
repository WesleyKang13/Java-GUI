<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<style>
a {
  text-decoration: none;
}

.help {
  font-family: Arial, sans-serif;
  margin-left: 0px;
  margin-bottom: 260px;
  max-height: 600px;
  margin-top: 50px;
}

.help h4 {
  font-size: 24px;
  margin-bottom: 16px;
}

.help ul {
  list-style: none;
  padding: 0;
  margin: 0;
  counter-reset: my-counter;
}

.help li {
  margin-bottom: 8px;
  counter-increment: my-counter;
}

.help li::before {
  content: counter(my-counter) ". ";
  font-weight: bold;
  margin-right: 8px;
}

.help li a {
  display: inline-block;
  padding: 8px 16px;
  color: #333;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.help li a:hover {
  background-color: #333;
  color: #f1f1f1;
}

.contact-form {
  background-color: #f5f5f5;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  padding: 20px;
  margin: 0 auto;
  max-width: 450px;
  max-height: 600px;
  margin-bottom: 40px;
  margin-right: 13em;
  margin-top: 20px;
}

.contact-form h3 {
  text-align: center;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}

.form-group textarea {
  resize: vertical;
}

.submit-button[type="submit"] {
  width: 410px;
  background-color: black;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.submit-button[type="submit"]:hover {
  background-color: #2e302e;
}

.containers {
  display: flex;
  align-items: center;
  margin-left: 50px;
}

.container-help {
  display: flex;
  align-items: center;
  margin-left: 150px;
}

.image-container {
  flex: 0 0 40%;
  margin-left: 100px;
}

.image-container img {
  max-width: 100%;
  height: auto;
}

.text-container {
  flex: 1;
}

h1 {
  margin-top: 1px;
  margin-bottom: 10px;
}

h2{
  margin-top: 10px;
}

h1 , h2{
  width: 300px;
  font-size: 24px;
  font-weight: bold;
  font-family: 'Roboto Bold', sans-serif;
	text-transform: uppercase;
	letter-spacing: 2px;
}

p{
  font-size: 18px;
  font-family:sans-serif;
  width: 300px;
}
.icon{
  transform: translateY(-7px);
}


footer {
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: #333333;
  font-size: 11px;
}

.footer-container {
  display: grid;
  grid-template-columns: 250px 300px 200px;
  padding: 0px 0px 50px 5px;
  margin-left: 3em;
  color: #fff;
}

.footer-links ul,
.footer-find-us ul,
.footer-social ul {
  margin: 0;
  padding: 0;
  list-style: none;
}

.footer-links h5,
.footer-find-us h5,
.footer-social h5 {
  margin-bottom: 10px;
  font-size: 13px;
}

.footer-links a,
.footer-social a {
  color: #fff;
  text-decoration: none;
}

.footer-social p {
  font-size: 10px;
  padding-right: 5em;
}

.search-button{
  height: 30px; 
  width: 30px;
  background-color: white;
}

.search-button:hover{
  background-color: white;
}

.favourite-button{
  height: 30px; 
  width: 30px;
  background-color: white;
}

.cart-button{
  height: 30px; 
  width: 30px;
  background-color: white;
}

.user-registration{
  height: 30px; 
  width: 30px;
  background-color: white;
}

button {
  width: 80px;
  margin-top: 20px;
  padding: 12px 10px;
  cursor: pointer;
  text-align: center; 
  font-size: 15px;
  border-style: none;
  font-family: Verdana, sans-serif;
}

button:hover{
    background-color: #B8B8B8;
}

.fa {
  padding: 5px 20px 20px 10px;
  margin: 0px 0px 0px 0px;
  font-size: 15px;
  width: 15px;
  height: 10px;
  text-align: center;
  text-decoration: none;
  border-radius: 50px;
}

.fa:hover {
    opacity: 0.7;
}

.fa-facebook {
  background: #3B5998;
  color: white;
}

.fa-twitter {
  background: #55ACEE;
  color: white;
}

.fa-instagram {
  background: #125688;
  color: white;
}

* {box-sizing: border-box}

body {
  margin: 0;
  font-family: 'Poppins', sans-serif;
}

</style>

<body>
      </div>
      <div class="containers" style="padding-top: 50px; padding-bottom:0px;">
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
      <div class="container-help" style="padding-top: 1px; padding-bottom:10px;">
      <div class="help">
        <h4>How can we help</h4>
        <ul>
          <li><a href="contact_us.html">Where is my refund</a></li>
          <li><a href="contact_us.html">How do I return my order</a></li>
          <li><a href="contact_us.html">Can't see my order</a></li>
          <li><a href="contact_us.html">Does Banana Shoe have warranty</a></li>
          <li><a href="contact_us.html">How do I become a member of Banana Shoe</a></li>
          <li><a href="contact_us.html">What payment options can I use on Banana Shoe</a></li>
          <li><a href="contact_us.html">What is Banana Shoe membership?</a></li>
          <li><a href="contact_us.html">What is Banana Shoe return policy?</a></li>
          <li><a href="contact_us.html">Banana shoe newest releases</a></li>
        </ul>
      </div>
      <div class="contact-form">
        <h3>Contact Us</h3>
        <form action="#" method="POST">
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