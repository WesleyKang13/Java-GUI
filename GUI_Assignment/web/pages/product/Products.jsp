<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<link href="../../css/product/Products.css" rel="stylesheet" />
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
<link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">

    <body>
        <main>
            <header>
                <div class="header-li">
                    <div class="filter-btn">
                        <button type="button" id="toggleBtn" class="filterBtn">Show Filters<i class="fa fa-filter"></i></button>
                    </div>
    
                    <ul class="categories-filtering" style="display: none;"><!--Filter using java-->
                        <li data-filter="">Men</li>
                        <li data-filter="">Women</li>
                        <li data-filter="">Kids</li>
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
                            <input type="text" name="search-filter" placeholder="e.g Niko, Adados"/>
                            <button type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </form>
                </td>
                <td class="third-col">
                    <div class="filter-condition">
                        <span>View as a</span>
                        <select name="filtering" id="filtering">
                            <option value="Default">Default</option>
                            <option value="LowToHigh">Low to high</option>
                            <option value="HighToLow">High to low</option>
                        </select>
                    </div>  
                </td>
            </tr>
        </table>

        <div class="product-field">
            <ul class="shoes">
                <li shoe-category="">
                    <picture>
                        <img src="../../assets/product/dummy1.jpg" alt="">
                    </picture>
                    <div class="details">
                        <p class="icon">
                            <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                            <span><i class="fa fa-share" aria-hidden="true"></i></span>
                        </p>
                        <strong>Nike run 2017</strong>
                        <small>Lorem ipsum dolor sit amet consectetur</small>
                    </div>
                    <h4>Rm<br> 599.99</h4>
                </li>

                <li shoe-category="">
                    <picture>
                        <img src="../../assets/product/dummy1.jpg" alt="">
                    </picture>
                    <div class="details">
                        <p class="icon">
                            <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                            <span><i class="fa fa-share" aria-hidden="true"></i></span>
                        </p>
                        <strong>Nike run 2017</strong>
                        <small>Lorem ipsum dolor sit amet consectetur</small>
                    </div>
                    <h4>Rm<br> 599.99</h4>
                </li>

                <li shoe-category="">
                    <picture>
                        <img src="../../assets/product/dummy2.png" alt="">
                    </picture>
                    <div class="details">
                        <p class="icon">
                            <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                            <span><i class="fa fa-share" aria-hidden="true"></i></span>
                        </p>
                        <strong>Nike hype</strong>
                        <small>Lorem ipsum dolor sit amet consectetur</small>
                    </div>
                    <h4>Rm<br> 650.99</h4>
                </li>

                <li shoe-category="">
                    <picture>
                        <img src="../../assets/product/dummy1.jpg" alt="">
                    </picture>
                    <div class="details">
                        <p class="icon">
                            <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                            <span><i class="fa fa-share" aria-hidden="true"></i></span>
                        </p>
                        <strong>Nike run 2017</strong>
                        <small>Lorem ipsum dolor sit amet consectetur</small>
                    </div>
                    <h4>Rm<br> 599.99</h4>
                </li>

                <li shoe-category="">
                    <picture>
                        <img src="../../assets/product/dummy2.png" alt="">
                    </picture>
                    <div class="details">
                        <p class="icon">
                            <span><i class="fa fa-cart-arrow-down" aria-hidden="true"></i></span>
                            <span><i class="fa fa-share" aria-hidden="true"></i></span>
                        </p>
                        <strong>Nike hype</strong>
                        <small>Lorem ipsum dolor sit amet consectetur</small>
                    </div>
                    <h4>Rm<br> 599.99</h4>
                </li>
            </ul>
        </div>
         
    </body>
    <script src="../../js/product/products.js"></script>
    
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
