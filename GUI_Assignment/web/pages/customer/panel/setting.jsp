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
        response.sendRedirect(ROOT_PATH+"index.html");
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
        <form action="<%=ROOT_PATH+"pages/customer/panel/UpdateUserInfo" %>" method="POST">
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
                    <td><input type="text" name="fullName" value="<%=customer.getCustFullName()%>"></td>
                </tr>
                <tr>
                    <td><strong>User Name</strong></td>
                    <td><input type="text" name="userName" value="<%=customer.getUserId().getUserName()%>"></td>
                </tr>
                <tr>
                    <td><strong>New Password</strong></td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td><strong>Confirm New Password</strong></td>
                    <td><input type="password" name="confirmPassword"></td>
                </tr>
                <tr>
                    <td><strong>Phone Number</strong></td>
                    <td><input type="text" name="phoneNum" value="<%=customer.getCustPhoneNum()%>"></td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><input type="email" name="email" value="<%=customer.getUserId().getUserEmail()%>"></td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><input type="text" name="shippingAddress" value="<%=customer.getCustShippingAddress()%>"></td>
                </tr>
            </table>

            <div class="edit-action">
                <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }"  style="float: left;">Reset</button>
                <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to update this information?')) { return true; } else { return false; }">Save</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>