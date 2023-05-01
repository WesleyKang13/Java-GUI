<% String ROOT_PATH = "../../"; %>
<%@page import="entity.Product"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.List"%>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../../css/customer/cart.css" rel="stylesheet" />
        <title>Cart Page | BananaShoeStore</title>
    </head>
    <body>
        <h1 style="margin-left:20px;">Shopping cart</h1>
        
        <table class="cart-table">
            <tr class="table-headers">
              <th>No</th>
              <th>Product Name</th>
              <th>Quantity</th>
              <th>Price</th>
              <th>Total</th>
              <th>Color</th>
              <th>Size</th>
            </tr>

            <%
            List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
            if(cartItems != null){
              int count =1;
              int invId = -1; // initialize invId
              for (Cart cartItem : cartItems) {
                invId = cartItem.getInvProdId().getInvId(); // set invId
            %>
                <tr>
                  <td><%= count++%></td>
                  <th><%= cartItem.getInvProdId().getProdId().getProdName() %></th>
                  <td>
                    <div class="quantity-container">
                      <input type="number" value="<%= cartItem.getCartQuantity() %>" min="1" max="100" step="1" name="quantity" class="quantity-input">
                      
                    </div>
                  </td>
                  <td><%= cartItem.getInvProdId().getProdId().getProdPrice() %></td>
                  <td><%= cartItem.getTotalAmount() %></td>
                  <td><%= cartItem.getInvProdId().getInvColor() %></td>
                  <td><%= cartItem.getInvProdId().getInvShoeSize() %></td>
                </tr>
            <% } %>
                <div class="confirm-container">
                    <button id="confirm-button" class="confirm-button" style="display: none;">Confirm change</button>
                </div>
                <a href="<%= ROOT_PATH + "/pages/customer/FindCheckout?custId=" + cartItems.get(0).getCustId().getCustId() + "&invId=" + invId %>" 
                style="
                    color:white;
                    background-color:black;
                    border-radius:20px;
                    padding:10px;
                    margin-left:85%;
                    position: absolute;
                    top:200px;
                "
                class="checkout-button"
                >Checkout</a>
            <% } else { %>
              <tr>
                <td>No data found!</td>
              </tr>
            <% } %>
        </table>
        
        <script>
            // get all quantity input elements
            const quantityInputs = document.querySelectorAll(".quantity-input");

            // add event listeners to each quantity input
            quantityInputs.forEach(input => {
                // set initial value to compare against
                let initialValue = input.value;

                input.addEventListener("change", () => {
                // check if the value has changed
                if (input.value !== initialValue) {
                    // show the confirm button
                    const confirmButton = document.querySelector("#confirm-button");
                    confirmButton.style.display = "block";
                } else {
                    // hide the confirm button
                    const confirmButton = document.querySelector("#confirm-button");
                    confirmButton.style.display = "none";
                }
              });
            });

            // add click event listener to the confirm button
            const confirmButton = document.querySelector("#confirm-button");
            confirmButton.addEventListener("click", () => {
                confirmButton.style.display = "none";
            });

            // add click event listener to the checkout button
            const checkoutButton = document.querySelector(".checkout-button");
            checkoutButton.addEventListener("click", (event) => {
              // check if confirm button was clicked
              if (confirmButton.style.display === "block") {
                // prevent form submission
                event.preventDefault();
                // show alert box
                alert("Please confirm any changes to your cart before proceeding to checkout.");
              }
            });

        </script>

        
    </body>
</html>
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
