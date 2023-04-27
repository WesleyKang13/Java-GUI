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
                            Inventory detail = details.get(0);%>
                                <h1><%= detail.getProdId().getProdName() %></h1>
                                <h4>Size in UK only</h4>
                                <h5>Rm<strong><%= detail.getProdId().getProdPrice() %></strong></h5>
                                 
                                <h2>Colors available:</h2> 
                                <% for (Inventory inventory : details) { %>
                               
                                <div class="color-quantity-container" id="color-quantity-container">
                                   <label for="color-select">Select a color:</label>
                                    <select id="color-select" class="color-select">
                                        <option value="">All colors</option>
                                        <% for (Inventory inv : inventory.getProdId().getInventoryList()) { %>
                                            <% if (!inv.getInvColor().isEmpty()) { %>
                                                <option value="<%= inv.getInvColor() %>"><%= inv.getInvColor() %> - <%= inv.getInvQuantity() %></option>
                                            <% } %>
                                        <% } %>
                                    </select>
                                    <br><br>
                                    <label for="size-select">Select a size:</label>
                                    <select id="size-select" class="size-select">
                                        <option value="">All sizes</option>
                                        <% for (Inventory inv : inventory.getProdId().getInventoryList()) { %>
                                            <% if (!inv.getInvColor().isEmpty()) { %>
                                                <option value="<%= inv.getInvColor() + '-' + inv.getInvShoeSize() %>"><%= inv.getInvShoeSize() %></option>
                                            <% } %>
                                        <% } %>
                                    </select>
                                </div>
                                
                                <script>
                                    // Get all color-quantity-container elements
                                    const containers = document.querySelectorAll('.color-quantity-container');

                                    containers.forEach(function(container) {
                                        // Get the color-select and size-select elements for this container
                                        const colorSelect = container.querySelector('.color-select');
                                        const sizeSelect = container.querySelector('.size-select');
                                        let selectedColor;

                                        // Event listener for the color-select dropdown
                                        colorSelect.addEventListener('change', function() {
                                            selectedColor = colorSelect.value;

                                            // Clear the size-select dropdown and add "All sizes" option
                                            sizeSelect.innerHTML = '<option value="">All sizes</option>';

                                            // Add options for sizes matching the selected color
                                            <% for (Inventory inv : inventory.getProdId().getInventoryList()) { %>
                                                <% if (inv.getInvColor().equals("")) continue; %>
                                                <% if (inv.getInvColor().equals(selectedColor)) { %>
                                                    sizeSelect.innerHTML += '<option value="<%= inv.getInvColor() + "-" + inv.getInvShoeSize() %>"><%= inv.getInvShoeSize() %> - <%= inv.getInvQuantity() %></option>';
                                                <% } %>
                                            <% } %>
                                        });
                                    });
                                </script>
                                <% } %>
                        
                        <p><%= detail.getProdId().getProdDescription() %> </p>
                        <% } %>
                        <br>
                        
                        
                        <button type="submit" 
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

function buttonClicked(button) {
  // Remove active class from all buttons
  const buttons = document.querySelectorAll('.color-quantity-container button');
  console.log(buttons);
  buttons.forEach((btn) => {
    btn.classList.remove('active');
  });
  
  // Add active class to clicked button
  button.classList.add('active');
}
</script>

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>