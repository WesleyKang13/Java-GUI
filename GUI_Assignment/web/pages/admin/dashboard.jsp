<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/admin/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.dashboard").classList.add("active");
</script>


<link rel="stylesheet" href="../../css/admin/dashboard.css">

<main>
    <div class="container">
        <h3 style="padding-bottom: 2rem;">Your Last Logged in Time: 2022/02/23 08:10</h3>
        <h1 style="padding-bottom: 2rem;">Welcome Back, User!</h1>
        <h1>Please Select Action Below:</h1>
    </div>
    
    <div class="card-container">
        <a href="<%=ROOT_PATH+"index.html"%>" class="card">
            <i class="fa-solid fa-house icon"></i>
            <h2 class="text nav-text">Home Page</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/admin/LoadCustomer"%>" class="card">
            <i class="fa-solid fa-address-book icon"></i>
            <h2 class="text nav-text">Customer</h2>
        </a>
    
        <a href="<%=ROOT_PATH + "pages/admin/LoadProduct"%>" class="card">
            <i class="fa-solid fa-boxes-stacked icon"></i>
            <h2 class="text nav-text">Product</h2>
        </a>
    
        <a href="<%=ROOT_PATH + "pages/admin/LoadInventory"%>" class="card">
            <i class="fa-solid fa-cubes-stacked"></i>
            <h2 class="text nav-text">Inventory</h2>
        </a>
    
        <a href="<%=ROOT_PATH + "pages/admin/LoadOrder"%>" class="card">
            <i class="fa-solid fa-cart-flatbed icon"></i>
            <h2 class="text nav-text">Order</h2>
        </a>
   
        <a href="<%=ROOT_PATH + "pages/admin/LoadPayment"%>" class="card">
            <i class="fa-solid fa-money-check-dollar"></i>
            <h2 class="text nav-text">Payment</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/admin/LoadReview"%>" class="card">
            <i class="fa-solid fa-comments"></i>
            <h2 class="text nav-text">Review</h2>
        </a>
            
        <a href="<%=ROOT_PATH + "pages/admin/LoadStaff"%>" class="card">
            <i class="fa-solid fa-id-card-clip icon"></i>
            <h2 class="text nav-text">Staff *</h2>
        </a>
    
        <a href="<%=ROOT_PATH + "pages/admin/report.jsp"%>" class="card">
            <i class="fa-solid fa-chart-pie icon"></i>
            <h2 class="text nav-text">Report *</h2>
        </a>
    
        <a href="<%=ROOT_PATH + "pages/admin/inquiry.jsp"%>" class="card">
            <i class="fa-solid fa-clipboard-question icon"></i>
            <h2 class="text nav-text">Inquiry</h2>
        </a>
    </div>
</main>
</body>
</html>