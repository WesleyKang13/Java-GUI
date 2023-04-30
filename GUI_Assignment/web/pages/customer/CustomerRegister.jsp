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
        <form action="RegisterCustomer" method="post">
            <table cellspacing="0" cellpadding="10" style="margin: 0 auto;">
                
                <tr>
                    <td>
                    <i class="fa-solid fa-user"></i>
                    </td>
                    <td>
                    <input type="text" name="username" placeholder="User Name" required>
                    
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-regular fa-address-card"></i>
                    </td> 
                    <td>
                        <input type="text"  name="fullname" placeholder="Name" maxlength="30" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="fa-solid fa-envelope"></i>
                    </td> 
                    <td>
                        <input type="email"  name="accEmail" maxlength="300" placeholder="username@gmail.com" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <i class="fa-solid fa-phone"></i>
                    </td> 
                    <td>
                    <input type="text"  name="accPhone" placeholder="012-1234567"maxlength="300" required/>
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-solid fa-lock"></i>
                    </td> 
                    <td>
                    <input type="password"  name="accPass" id="password" placeholder="******" maxlength="300" required/>
                    <i class="bi bi-eye-slash" id="togglePassword"></i>   
                    </td>
                </tr>
                <tr>
                    <td>
                    <i class="fa-solid fa-user-lock"></i>
                    </td> 
                    <td>
                    <input type="password"  name="comfirmPass" id="password2" placeholder=" Comfirm Password:" maxlength="300" required/>
                    
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
                    <input class="registerBtn" style="background-color:white;  font-size:1.5vw;" type="submit" name="submit" value="Register" />
                    </td>
                </tr>

             </table>

        </form>
        </div>
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

    <script>
        const togglePassword = document.querySelector("#togglePassword");
        const password = document.querySelector("#password");
        const password2 = document.querySelector("#password2");

        togglePassword.addEventListener("click", function () {
            // toggle the type attribute
            const type = password.getAttribute("type") === "password" ? "text" : "password";
            password.setAttribute("type", type);
            password2.setAttribute("type", type);

            // toggle the icon
            this.classList.toggle("bi-eye");
        });
    
        // prevent form submit
        const form = document.querySelector("form");
        form.addEventListener('submit', function (e) {
            e.preventDefault();
        });
        
        
        
    </script>
    
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>