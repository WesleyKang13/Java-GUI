<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
<%@page import="entity.User"%>
<%@page import="entity.Customer"%>


<link rel="stylesheet" href="../css/UserLogin.css">
  <link href=<%= ROOT_PATH + "css/headerFooter.css"%> rel="stylesheet" type="text/css">
  <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
  <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
  <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">


<%
    if(request.getSession().getAttribute("userPermission") != null){
        String message = "You are logged in.";
        request.setAttribute("message", message);
        String redirectUrl = "../index.jsp";
        String alertScript = "<script>alert('" + message + "');</script>";
        response.getWriter().write(alertScript);
        response.setHeader("Refresh", "0; URL=" + redirectUrl);
    }

%>
<%
    boolean loginFail = request.getParameter("loginFail") != null ? true : false;
    if(loginFail){ 
%>
    <script>
        window.onload = function() {
            alert("User Not Found or Invalid Password");
        };
    </script>
<% } %>
<%
    String registerSuccessful = request.getParameter("registerSuccessful") != null ? (String) request.getParameter("registerSuccessful") : null;
    if(registerSuccessful!=null){ 
%>
    <script>
        window.onload = function() {
            alert("<%=registerSuccessful%>");
        };
    </script>
<% } %>

    <form action="ValidateLogin" method="post">
        
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
                    <label for="email" >Account:</label>
                        <div class="input-group form-icon form-icon-email">
                            <i class="fa-solid fa-user"></i>
                            <input type="text" name="account" placeholder="Email / User Name" required="">
                                
                        </div>
                    <label for="pwrd" >Password:</label>
                        <div class="input-group form-icon form-icon-email">
                            <i class="fa-solid fa-key" id="key"></i>
                            <input type="password" name="password" id="password" placeholder="*******" required>
                            <i class="bi bi-eye-slash" id="togglePassword"></i>     
                        </div>
                       
                        <input type="submit" class="user_loginbutton" value="Login"  name="login"> 
                              
                        
                   
                        
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
                    <a class="user_registerbutton" href="./customer/CustomerRegister.jsp" role="button">
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