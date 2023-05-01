<%@page import="entity.Review"%>
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
    <link href=<%= ROOT_PATH+"vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
    <link href=<%= ROOT_PATH+"vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
    <link href=<%= ROOT_PATH+"vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">
    <title>Products</title>
</head>
<body>
    
    
    <script>
                window.onload = function() {
            const inventory = [
              <% List<Inventory> inventoryList = (List<Inventory>) request.getAttribute("inventoryList");       
                 for(Inventory i:inventoryList){
                     out.println("{color: '"+i.getInvColor()+"', size: '"+i.getInvShoeSize()+"', quantity: "+i.getInvQuantity()+"},");
                 } 
              %>
            ];

            // create an array of unique colors
            const uniqueColors = inventory.filter((item, index, self) => self.findIndex(t => t.color === item.color) === index);

            var colorSel = document.getElementById("color");
            var sizeSel = document.getElementById("size");
            var quantityDiv = document.getElementById("quantity");

            // set default value for color dropdown
            colorSel.value = "";
            colorSel.options[colorSel.options.length] = new Option("Select color", "");

            // set default value for size dropdown
            sizeSel.value = "";
            sizeSel.options[sizeSel.options.length] = new Option("Select size", "");

            for (var i = 0; i < uniqueColors.length; i++) {
              colorSel.options[colorSel.options.length] = new Option(uniqueColors[i].color, uniqueColors[i].color);
            }
            colorSel.onchange = function() {
              //empty size and quantity displays
              sizeSel.length = 1;
              quantityDiv.textContent = "";
              //display correct sizes
              for (var j = 0; j < inventory.length; j++) {
                if (inventory[j].color === this.value) {
                  sizeSel.options[sizeSel.options.length] = new Option(inventory[j].size, inventory[j].size);
                }
              }
              // set default value for size dropdown when color changes
              sizeSel.value = "";
            };
            sizeSel.onchange = function() {
              //display remaining quantity for selected color and size
              for (var k = 0; k < inventory.length; k++) {
                if (inventory[k].color === colorSel.value && inventory[k].size === this.value) {
                  quantityDiv.textContent = "Remaining stock: " + inventory[k].quantity;
                  break;
                }
              }
            };
          };
    </script>
    
    
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

                <form action="UpdateCart" method="post">
                <td class="secCol">
                    <div class="full-details">
                        <% 
                            List<Inventory> details = (List<Inventory>) request.getAttribute("inventoryList");
                            if(details.isEmpty()){
                                out.println("No inventory data found");
                            }else{ 
                            Inventory detail = details.get(0);%>
                                <h1><%= detail.getProdId().getProdName() %></h1>
                                <h4>Size in UK only</h4>
                                <h5>Rm<strong><%= detail.getProdId().getProdPrice() %></strong></h5>
                                <input type="hidden" name="productId" value="<%=detail.getProdId().getProdId()%>" />
                                <h2>Select color and size:</h2> 
                               
                                <div class="color-quantity-container" id="color-quantity-container">
                                    <!--Start the color and size selection-->
                                    <label for="color">Color:</label>
                                    <select name="color" id="color"></select>
                                    <br><br>

                                    <label for="size">Size:</label>
                                    <select name="size" id="size"></select>
                                    <br><br>

                                    <div id="quantity"></div>
                                    <!--End the color and size selection--> 
                                </div>
                        
                        <p><%= detail.getProdId().getProdDescription() %> </p>
                        
                        <br>
                        
                        
                            <button type="submit" 
                            style="position:absolute; 
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
                        </form>
                       <% } %>
                    </div>

                    <div class="shipping-details">
                        <h3>Free delivery and returns <i class="fa fa-tags" onclick="deliveryDetails()"></i></h3>

                        <div class="modal" id="myModal">
                            <div class="modal-content">
                                <span class="close">&times;</span>
                                <p class="details">
                                    Your order of RM 200 or more gets free standard delivery.
                                    Otherwise, there will be Rm 25 of charges.<br>
                                    Standard delivered 2-6 Business Days<br>
                                    Express delivered 2-4 Business Days<br>
                                    
                                    Orders are processed and delivered Monday-Friday (excluding public holidays)
                                </p>
                            </div>
                        </div>

                    </div>
                    <% Double reviewScore = (Double) request.getAttribute("reviewScore");
                        if(reviewScore != null){
                        int fullStars = (int) Math.floor(reviewScore);
                        int emptyStars = 5 - fullStars;
                    %>    
                    <div class="reviews"> 
                         <h3>Reviews (<%= reviewScore %>) 
                             <% for (int i = 0; i < fullStars; i++) { %>
                                 <i class="fa fa-star" style="color: yellow;"></i>
                             <% } %>
                             <% for (int i = 0; i < emptyStars; i++) { %>
                                 <i class="fa fa-star"></i>
                             <% } %>
                         </h3>
                         <h3>Comments:</h3>
                         <% List<Review> reviewData = (List<Review>) request.getAttribute("reviewList");
                            
                        if(reviewData != null){
                            int count = 1;
                             
                            for(Review reviewDesc : reviewData){ %>
                            
                            <div class="comments">
                                <small><%=count++ %>. <%=reviewDesc.getReviewDescription() %></small>
                            </div>
                            
                        <% } %>
                        <% }%>
                     </div>  
                 <% } else { %>
                     <h3>No review available</h3>
                 <% } %>
                    
                        
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