<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<link rel="stylesheet" href="../css/UserLogin.css">
<link rel="stylesheet" type="text/css" href="/jwcodeme/style/main-style.css?v=1" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    

    <form method="post">
        
        <div class="grid-container">
                <div id="user_login" class="grid-item">
                        <h1>
                            <span id="welcome">
                                Welcome
                            </span>
                            <span id="back">
                                Back
                            </span>    
                        </h1>
                    <p>Login to your account</p>
                    <label for="email" >Email:</label>
                        <div class="input-group form-icon form-icon-email">
                            <i class="fa fa-envelope icon"></i>
                            <input type="email" name="emailLogin" placeholder="" required="">
                                
                        </div>
                    <label for="pwrd" >Password:</label>
                        <div class="input-group form-icon form-icon-email">
                            <i class="fa fa-key icon" id="key"></i>
                            <input type="password" name="password" id="password" placeholder="*******" required>
                            <i class="bi bi-eye-slash" id="togglePassword"></i>     
                        </div>
                       
                        <a type="submit" class="user_loginbutton" href="userlogin.php" name="login"> <span></span>
                            <span></span>
                            <span></span>
                            <span></span>Login</a> 
                        
                   
                        <div class="facebook">
                            <div>
                                     <a  class="socialmedia" id="facebook" href="https://www.facebook.com/">
                                        <i class="fa fa-facebook">
                                        </i>
                                        Facebook
                                     </a>
                            </div>
                        </div>
                        <div class="google">         
                              <div>
                                <a  class="socialmedia"  id="google" href="https://accounts.google.com/">
                                   <i class="fa fa-google">
                                   </i>
                                   Google
                                </a>
                             </div>
                        </div>
                </div>
                
            <div id="user_register" class="grid-item">
                <div class="registerMessage">
                    <h1 style="font-size:3vw;" >
                        <span id="register">
                            Register
                        </span>
                   </h1>
                    <p id="registerwel">Welcome to Banana</p>
                 </div>
                <a class="user_registerbutton" href="./customer/CustomerRegister.html" role="button">
                    <span></span>
                            <span></span>
                            <span></span>
                            <span></span>REGISTER</a>                
            </div>

        </div>
</form>

<script>
    const togglePassword = document.querySelector("#togglePassword");
    const password = document.querySelector("#password");

    togglePassword.addEventListener("click", function () {
        // toggle the type attribute
        const type = password.getAttribute("type") === "password" ? "text" : "password";
        password.setAttribute("type", type);
        
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