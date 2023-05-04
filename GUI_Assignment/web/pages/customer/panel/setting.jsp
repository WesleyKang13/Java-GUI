<%@page import="entity.Customer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<% 
    //Get notification from controllers
    String successMsg = request.getParameter("successMsg") != null ? (String) request.getParameter("successMsg") : null;
    String errorMsg = request.getParameter("errorMsg") != null ? (String)request.getParameter("errorMsg") : null;
    request.removeAttribute("searchValue");
    
    //Get root path (from controller)
    String ROOT_PATH = (String) request.getAttribute("ROOT_PATH");
    
    //Redirect to home page if it's not customer
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 2){
        response.sendRedirect(ROOT_PATH+"index.jsp");
    }
    
    //Get inventorys information from controller (LoadSetting.jsp)
    //Declare variable
    Customer customer = (Customer) request.getAttribute("customerInfo") != null ? (Customer) request.getAttribute("customerInfo") : null;
    
    //Get variable from Query String
    
    
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".userSetting").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/customer/panel/setting.css"%>">

<main>
    <div class="container setting tab">
        <form action="<%=ROOT_PATH+"pages/customer/panel/UpdateUserInfo" %>" method="POST" onsubmit="return confirm('Are you sure you want to update this information?')">
            <div class="text">
                <h1>User Setting</h1>
                <p><strong><%="User ID "+customer.getUserId().getUserId()+" - "+customer.getUserId().getUserName()%></strong></p>
            </div>
            
            <!--Display Notification Area-->
            <%if(successMsg!=null){%>
                <div class="notificationBox success">
                    <span class="message"><%=successMsg%></span>
                    <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
                </div>
            <%} if(errorMsg!=null){%>
                <div class="notificationBox error">
                    <span class="message"><%=errorMsg%></span>
                    <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
                </div>
            <% } %>
            
            <table class="table vertical-table">
                <tr>
                    <td><strong>Full Name</strong></td>
                    <td><input type="text" name="fullName" id="fullName" value="<%=customer.getCustFullName()%>"></td>
                </tr>
                <tr>
                    <td><strong>User Name</strong></td>
                    <td><input type="text" name="userName" id="userName" value="<%=customer.getUserId().getUserName()%>"></td>
                </tr>
                <tr>
                    <td><strong>New Password</strong></td>
                    <td><input type="password" name="password" id="password"></td>
                </tr>
                <tr>
                    <td><strong>Confirm New Password</strong></td>
                    <td><input type="password" name="confirmPassword" id="confirmPassword"></td>
                </tr>
                <tr>
                    <td><strong>Phone Number</strong></td>
                    <td><input type="text" name="phoneNum" id="phoneNum" value="<%=customer.getCustPhoneNum()%>"></td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><input type="email" name="email" id="email" value="<%=customer.getUserId().getUserEmail()%>"></td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><input type="text" name="shippingAddress" id="shippingAddress" value="<%=customer.getCustShippingAddress()%>"></td>
                </tr>
            </table>

            <div class="edit-action">
                <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }"  style="float: left;">Reset</button>
                <button type="submit" class="submitBtn btn success" onclick="return validateSetting()">Save</button>
            </div>
        </form>
                
        <script>
            function validateSetting() {
                var fullName = document.getElementById("fullName").value.trim();
                var userName = document.getElementById("userName").value.trim();
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var phoneNum = document.getElementById("phoneNum").value.trim();
                var email = document.getElementById("email").value.trim();
                var shippingAddress = document.getElementById("shippingAddress").value.trim();

                var errorMsg = "";
                var validate = true;

                // Check if full name is at least 5 characters
                if (fullName.length < 5) {
                  errorMsg += "Full Name must be at least 5 characters.\n";
                  validate = false;
                }

                // Check if username is at least 5 characters
                if (userName.length < 5) {
                  errorMsg += "Username must be at least 5 characters.\n";
                  validate = false;
                }

                // Check if confirm password matches password
                if (password !== confirmPassword) {
                  errorMsg += "Passwords do not match.\n";
                  validate = false;
                }

                // Check if phone number is a 10 digit number
                var phoneNumRegex = /\d$/;
                if (!phoneNumRegex.test(phoneNum)) {
                  errorMsg += "Phone number must be a 10 digit number.\n";
                  validate = false;
                }

                // Check if email is in valid format
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                  errorMsg += "Email address is invalid.\n";
                  validate = false;
                }
                
                // Check if shippingAddress is at least 5 characters
                if (shippingAddress.length < 5) {
                  errorMsg += "Shipping Address must be at least 5 characters.\n";
                  validate = false;
                }

                // If validation failed, display error message and return false
                if (!validate) {
                  alert(errorMsg);
                  return false;
                }

                // Validation succeeded
                return true;
            }
        </script>
    </div>
</main>
</body>
</html>