<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<link rel="stylesheet" href="../../css/customer/CustomerRegister.css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">

<title>Customer Registration</title>

<body>
    <div class="grid-container">
        <div id="user_register" class="grid-item">
                <h1 style="font-size:3vw; letter-spacing: 4px;" >
                    <span>
                        Register
                    </span>
                    <span>
                        Account
                    </span>
                </h1>
            <p id="registerwel">Welcome to Banana</p>
        <form action="RegisterCustomer" method="post" onsubmit="return confrim('Sure to Register?')">
            <table cellspacing="0" cellpadding="10" style="margin: 0 auto;">
                   
                <tr>
                    <td>
                    <i class="fa-solid fa-user"></i>
                    </td>
                    <td>
                    <input type="text" name="username" id="username" placeholder="User Name" required>
                    
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-regular fa-address-card"></i>
                    </td> 
                    <td>
                        <input type="text"  name="fullname" id="fullname" placeholder="Name" maxlength="30" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="fa-solid fa-envelope"></i>
                    </td> 
                    <td>
                        <input type="email"  name="accEmail" id="accEmail"  maxlength="300" placeholder="username@gmail.com" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="fa-solid fa-phone"></i>
                    </td> 
                    <td>
                    <input type="text"  name="accPhone"  id="accPhone" placeholder="012-1234567"maxlength="300" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-solid fa-lock"></i>
                    </td> 
                    <td>
                    <input type="password"  name="accPass" id="password" placeholder="******" maxlength="300" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-solid fa-user-lock"></i>
                    </td> 
                    <td>
                    <input type="password"  name="confirmPass" id="password2" placeholder=" Comfirm Password:" maxlength="300" required/>
                    
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="fa-solid fa-location-dot"></i>
                    </td> 
                    <td>
                    <input type="text"  name="shippingAddress" id="shippingAddress" placeholder="Shipping Address" maxlength="300" required/>
                    
                    </td>
                </tr>
        
                <tr>

                    <td colspan="2">
                    
                    <div id="agreement">
                        <input  type="checkbox" id="agree" name="agree" required/>
                        <label for="agree">I agree to the PRIVACY POLICY and TERMS & CONDITIONS</label>
                    </div>
                        <input class="registerBtn" style="background-color:white;  font-size:1.5vw;" type="submit" name="submit" value="Register" onclick="return validateForm()"/>
                    </td>
                </tr>

             </table>

        </form>
        </div>
        
        <script>
            function validateForm() {
                var username = document.getElementById("username").value;
                var fullname = document.getElementById("fullname").value;
                var email = document.getElementById("accEmail").value;
                var phone = document.getElementById("accPhone").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("password2").value;
                var address = document.getElementById("shippingAddress").value;
                var agree = document.getElementById("agree").checked;

                var errorMessage = "";

                if (username === "") {
                  errorMessage += "Please enter a username.\n";
                }

                if (fullname === "") {
                  errorMessage += "Please enter your full name.\n";
                }

                if (email === "") {
                  errorMessage += "Please enter your email address.\n";
                }

                if (phone === "") {
                  errorMessage += "Please enter your phone number.\n";
                } else if (phone.length !== 11) {
                  errorMessage += "Please enter a valid phone number.\n";
                }

                if (password === "") {
                  errorMessage += "Please enter a password.\n";
                } else if (password.length < 6) {
                  errorMessage += "Please enter a password with at least 6 characters.\n";
                }

                if (confirmPassword === "") {
                  errorMessage += "Please confirm your password.\n";
                } else if (confirmPassword !== password) {
                  errorMessage += "The two passwords does not match.\n";
                }

                if (address === "") {
                  errorMessage += "Please enter your shipping address.\n";
                }

                if (!agree) {
                  errorMessage += "Please agree to the terms and conditions.\n";
                }

                if (errorMessage !== "") {
                  alert(errorMessage);
                  return false;//prevent form from being submitted if there are errorMessage
                }
            }
        </script>
        
        
        <div id="user_login" class="grid-item">
            <div class="loginMessage">
                <h1>
                    <span>
                        Welcome    
                    </span>
                    <span>
                        Back
                    </span>
                </h1>
                <p id="loginp">Login to your account</p>
            
               <a class="user_loginbutton" href="../UserLogin.jsp" role="button">Login</a>
             </div>
        </div>
    </div>
    
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>