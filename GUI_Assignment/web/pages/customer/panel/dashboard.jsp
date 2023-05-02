<% String ROOT_PATH = "../../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/customer/panel/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.dashboard").classList.add("active");
</script>


<link rel="stylesheet" href='<%= ROOT_PATH + "css/customer/panel/dashboard.css"%>'>
<%
    //Redirect to home page if it's not customer
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 2){
        response.sendRedirect(ROOT_PATH+"index.jsp");
    }
%>

<main>
    <div class="container">
        <h1 style="padding-bottom: 2rem;">Welcome Back, <%=session.getAttribute("customerFullName")%>!</h1>
        <h2>Please Select Action Below:</h2>
    </div>
    
    <div class="card-container">
        <a href="<%=ROOT_PATH+"index.jsp"%>" class="card">
            <i class="fa-solid fa-house icon"></i>
            <h2 class="text nav-text">Home Page</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadOrder"%>" class="card">
            <i class="fa-solid fa-cart-flatbed icon"></i>
            <h2 class="text nav-text">Order</h2>
        </a>
   
        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadPayment"%>" class="card">
            <i class="fa-solid fa-money-check-dollar"></i>
            <h2 class="text nav-text">Payment</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadReview"%>" class="card">
            <i class="fa-solid fa-comments"></i>
            <h2 class="text nav-text">Review</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/customer/panel/LoadSetting"%>" class="card">
            <i class="fa-solid fa-gears icon"></i>
            <h2 class="text nav-text">Setting</h2>
        </a>
    </div>
</main>
</body>
</html>