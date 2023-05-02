<% String ROOT_PATH = "../../"; %>
<%@page import="entity.Product"%>
<%@page import="java.util.List"%>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<link href="../../css/product/Products.css" rel="stylesheet" />
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">

    <body>
        
        <% if(request.getAttribute("NoCheckout")!=null){ %>
            <script>alert('No items in cart.');</script>
        <% } %>
        <main>
            <header>
                <div class="header-li">
                    <div class="filter-btn">
                        <button type="button" id="toggleBtn" class="filterBtn">Show Filters<i class="fa fa-filter"></i></button>
                    </div>
    
                    <ul class="categories-filtering" style="display: none;"><!--Filter using java-->
                        <% 
                            List<Product> productListType = (List<Product>) request.getAttribute("productList");
                            String currentFilter = request.getParameter("productType");
                        %>
                        <ul>
                            <li><a href="<%= ROOT_PATH + "pages/product/FindProduct?productType=MEN"%>" <%=(currentFilter!=null && currentFilter.equals("Men")) ? "class=\"active\"" : ""%>>Men</a></li>
                            <li><a href="<%= ROOT_PATH + "pages/product/FindProduct?productType=WOMEN"%>" <%=(currentFilter!=null && currentFilter.equals("Women")) ? "class=\"active\"" : ""%>>Women</a></li>
                            <li><a href="<%= ROOT_PATH + "pages/product/FindProduct?productType=KIDS"%>" <%=(currentFilter!=null && currentFilter.equals("Kids")) ? "class=\"active\"" : ""%>>Kids</a></li>
                            <% if (currentFilter != null) { %>
                                <li><a href="<%= ROOT_PATH + "pages/product/FindProduct"%>">Cancel</a></li>
                            <% } %>
                        </ul>
                    </ul>
                </div>
            </header>
        </main>

        <table class="searching-container">
            <tr>
                <td><h1 class="product-title">Get your kicks!</h1></td>
                <td>
                    <form action="FindProduct" method="post">
                        <div class="search">
                            <input type="text" name="prodName" placeholder="e.g Niko, Adados"/>
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                </td>
            </tr>
        </table>
        
        <div class="product-field">
            <ul class="shoes">
             <% 
                List<Product> products = (List<Product>) request.getAttribute("productList");

                for(Product product : products){
            %>
                <li shoe-category="">
                    <a href="<%= ROOT_PATH + "pages/product/FindDetails?productId="+product.getProdId()%>">
                        <picture>
                            <img src="../../assets/product/dummy1.jpg" alt="">
                        </picture>
                        <div class="details">
                            <p class="icon">
                                <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                                <span><i class="fa fa-share" aria-hidden="true"></i></span>
                            </p>

                            <strong><%= product.getProdName() %></strong>
                            <small><%= product.getProdDescription() %></small>
                        </div>
                        <h4>Rm<br> <%= product.getProdPrice() %></h4>
                    </a>
                </li>
            <% } %>
            </ul>
        </div> 
        
    </body>
    <script src="../../js/product/products.js"></script>
    
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
