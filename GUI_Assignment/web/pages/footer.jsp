<% String ROOT_PATH = request.getParameter("ROOT_PATH"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
     <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
     <link href=<%= ROOT_PATH + "css/headerFooter.css"%> rel="stylesheet" type="text/css">
     <title>Banana's Shoe Store</title>
</head>  
<body>
<footer>
    <div class="footer-container">
      <div class="footer-links">
        <h5>LINKS</h5>
        <ul>
          <li><a href="#">Become A Member</a></li>
          <br>
          <li><a href="#">Sign Up</a></li>
          <br>
          <li><a href="#">Send Us A Feedback</a></li>
        </ul>
      </div>
      <div class="footer-find-us">
        <h5>FIND US</h5>
        <ul>
          <li>123 Banana Town</li>
          <br>
          <li>Phone: 555-123-4567</li>
          <br>
          <li>Email: info@BananaShoe.com</li>
        </ul>
      </div>
      <div class="footer-social">
        <h5 style="margin-right: 0.9em;">SOCIALS</h5>
        <ul style="display:flex; justify-content:space-between; align-items:center; ">
          <li style="margin-right: 1em;"><a href="#"><i class="fa-brands fa-facebook"></a></i></li>
          <li style="margin-right: 1em;"><a href="#"><i class="fa-brands fa-instagram"></a></i></li>
          <li style="padding-right: 100px;"><a href="#"><i class="fa-brands fa-twitter"></a></i></li>
        </ul>
        </br>
        <p>© 2023 Banana Shoe - All Rights Reserved</p>
      </div>
    </div>
</footer>
</body>
</html>
