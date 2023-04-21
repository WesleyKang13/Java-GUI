<%@page import="entity.Product"%>
<%@page import="entity.Inventory"%>
<%@page import="java.util.List"%>
<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../../css/product/ProductDetails.css" rel="stylesheet" />
    <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
    <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
    <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">
    <title>Products</title>
</head>
<body>
    <div class="product-container">
        <table class="product-details">
            <tr>
                <td class="firstCol">
                    <div class="image">
                        <picture>
                            <img src="../../assets/product/dummy1.jpg" alt=""/>
                            <img src="../../assets/product/dummy1.jpg" alt=""/>
                            <img src="../../assets/product/dummy1.jpg" alt=""/>
                            <img src="../../assets/product/dummy1.jpg" alt=""/>
                            <img src="../../assets/product/dummy1.jpg" alt=""/>
                        </picture>
                    </div>
                </td>

                
                <td class="secCol">
                    <div class="full-details">
                        <% 
                            List<Inventory> details = (List<Inventory>) request.getAttribute("inventoryList");
                            if(details.isEmpty()){
                                out.println("No inventory data found");
                            }else{ 
                            //Codes are change from here
                             Inventory detail = details.get(0);%>
                                 <h1><%= detail.getProdId().getProdBrand() %></h1>
                                 <h4>Size in UK only</h4>
                                 <h5>Rm<strong><%= detail.getProdId().getProdPrice() %></strong></h5>
                                 
                                <% for (Inventory inventory : details) { %>
                                <% for (Inventory inv : inventory.getProdId().getInventoryList()) { %>
                                        <% if (inv.getInvShoeSize().equals(inventory.getInvShoeSize())) { %>
                                        <div class="size-color-container">
                                            <button><%= inv.getInvColor() %></button>
                                            -
                                            <li><%= inv.getInvQuantity() %> available</li>
                                        </div>
                                        <% } %>
                                    <% } %>
                                <div class="size-container">
                                    <button><%= detail.getInvShoeSize() %></button>
                                </div>
                              
                                <% } %>
                        <% } %>
                        
                         
                        <p>
                            Lorem ipsum dolor sit, amet consectetur adipisicing elit. 
                            Voluptate esse inventore nesciunt officiis nobis, non fugiat 
                            labore quam reiciendis vel asperiores deleniti accusantium, 
                            veniam dolor delectus commodi odit omnis? Exercitationem.
                        </p>
                        <br>
                        <h3>Stock status: In-stock<i class="fa fa-check" style="font-size:20px; color:green;"></i></h3>
                        <button type="button" 
                        style="
                        position:absolute; 
                        top:93%;
                        width:32%;
                        padding:10px;
                        border-radius:20px;
                        background-color: black;
                        border-color: none;
                        color:white;
                        cursor: pointer;
                        font-size:20px;"
                        >Add to cart</button>
                    </div>

                    <div class="shipping-details">
                        <h3>Free delivery and returns <i class="fa fa-tags" onclick="deliveryDetails()"></i></h3>

                        <div class="modal" id="myModal">
                            <div class="modal-content">
                                <span class="close">&times;</span>
                                <p class="details">
                                    Your order of RM 200 or more gets free standard delivery.<br>
                                    Standard delivered 2-6 Business Days<br>
                                    Express delivered 2-4 Business Days<br>
                                    
                                    Orders are processed and delivered Monday-Friday (excluding public holidays)
                                </p>
                            </div>
                        </div>

                    </div>

                   <div class="reviews">
                        <h3>Reviews (0) 
                            <i class="fa fa-star" style="margin-left:100px;"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                        </h3>
                    </div>
                </td>
            </tr>
        </table>
    </div>
                            
</body>
<script>
var modal = document.getElementById("myModal");
var toggleIcon = document.getElementsByClassName("shipping-details fa");
var span = document.getElementsByClassName("close")[0];

function deliveryDetails(){
    document.getElementById("myModal").style.display = "block";
}

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
}
</script>

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>