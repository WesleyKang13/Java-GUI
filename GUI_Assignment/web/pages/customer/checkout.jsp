<% String ROOT_PATH = "../../"; %>
<%@page import="entity.Product"%>
<%@page import="entity.Inventory"%>
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
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/fontawesome.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/brands.css"%> rel="stylesheet" type="text/css">
        <link href=<%= ROOT_PATH + "vendor/fontawesome-free-6.3.0-web/css/solid.css"%> rel="stylesheet" type="text/css">
        <link href="../../css/customer/checkout.css" rel="stylesheet">
    </head>
    <body>
        
        <h1>Checkout bag</h1>
        
        <form action="<%= ROOT_PATH + "pages/product/PaidOrder"%>" method="POST" onsubmit="return confirm('Sure to Submit?')">
        <table class="checkout-table">
        <tr>
            <div class="details-container">
            <%
            List<Cart> checkoutItems = (List<Cart>) request.getAttribute("checkoutItems");
            if(checkoutItems != null){
              for (Cart cartItem : checkoutItems) {
              
            %>
            <td class="items">
              <div class="image">
                <picture>
                  <img src="../../assets/product/dummy1.jpg" alt="">
                </picture>
              </div>
                
                <input type="hidden" name="product" value="<%=cartItem.getProdId().getProdId().getProdId()%>"/>
                <input type="hidden" name="productQuantity" value="<%=cartItem.getCartQuantity()%>"/>
                <p class="items-details">
                  Name: <%= cartItem.getProdId().getProdId().getProdName()%><br>
                  Price (RM): <%= String.format("%.2f",cartItem.getTotalAmount())%><br>
                  Quantity: <%= cartItem.getCartQuantity()%><br>
                  Size chosen (UK): <%= cartItem.getProdId().getInvShoeSize() %><br>
                  Color : <%= cartItem.getProdId().getInvColor() %><br>
                </p>
            <% } }%>
              </td>
            <td class="summary">
                <h2>Checkout summary</h2>
                <p class="summary-details">
                    Total item(s): <strong>${totalQuantity}</strong><br>
                    Estimated delivery &amp; handling(Rm): <strong>${deliveryFee}</strong><br>
                    Subtotal (RM): <strong>${String.format("%.2f",subtotalPrice)}</strong><br>
                    <input type="hidden" name="subTotalPrice" value="${subtotalPrice}">
                </p>

                <div class="shipping-details">
                    <h3>Shipping address:</h3>
                    <p>
                        <label for="address1">Delivery address:</label>
                        <br>
                        <input type="text" name="address1" id="address1" value="<%=session.getAttribute("customerAddress")%>">
                        <br>
                    </p>
                </div>

                <div class="paymentMethod">
                    <h3>Payment method</h3>
                    <input type="radio" value="DEBIT" name="paymentMethod" id="visaRadio">
                    <label for="visaRadio"><i class="fa-solid fa-credit-card"></i> Debit Card</label>
                    <br>
                    <input type="radio" value="CREDIT" name="paymentMethod" id="creditCardRadio">
                    <label for="creditCardRadio"><i class="fa-regular fa-credit-card"></i> Credit Card</label>
                    <br>
                    <input type="radio" value="CASH" name="paymentMethod" id="cashRadio">
                    <label for="cashRadio"><i class="fa-solid fa-sack-dollar"></i> Cash</label>
                    <br>
                </div>

                <div id="cardDetails" style="display:none;">
                    <h3>Card details</h3>
                    <label for="cardType">Card type:</label>
                    <select name="cardType" id="cardType">
                        <option value="">Please select</option>
                        <option value="VISA">VISA</option>
                        <option value="MasterCard">MasterCard</option>
                    </select>
                    <br>
                    <label for="cardName">Name on card:</label>
                    <input type="text" name="cardName" id="cardName">
                    <br>
                    <label for="cardNumber">Card number:</label>
                    <input type="text" name="cardNumber" id="cardNumber">
                    <br>
                    <label for="cardExp">Expiry date:</label>
                    <input type="text" name="cardExp" placeholder="MM/YY" id="cardExp">
                    <br>
                    <label for="cardCVV">CVV:</label>
                    <input type="text" name="cardCVV" id="cardCVV">
                    <br>
                    <label for="shippingAddress">Shipping address:</label>
                    <input type="text" name="shippingAddress" id="shippingAddress">
                    <br>
                </div>

                
                <button type="submit" id="confirmPayment" onclick="return validateForm()">Confirm</a>
          </td>
        </tr>
        </table>
        </form>
                
        <script>
            function validateForm() {
                var address1 = document.getElementById("address1").value;
                if (address1 === "") {
                  alert("Please fill in the delivery address.");
                  return false;
                }

                var paymentMethods = document.getElementsByName("paymentMethod");
                var selectedPaymentMethod = false;
                for (var i = 0; i < paymentMethods.length; i++) {
                  if (paymentMethods[i].checked) {
                    selectedPaymentMethod = true;
                    break;
                  }
                }
                
                if (!selectedPaymentMethod) {
                  alert("Please select a payment method.");
                  return false;
                }

                if (document.getElementById("cashRadio").checked) {
                  return true;
                }

                // Validation code for card payments
                var cardType = document.getElementById("cardType").value;
                var cardName = document.getElementById("cardName").value;
                var cardNumber = document.getElementById("cardNumber").value;
                var cardExp = document.getElementById("cardExp").value;
                var cardCVV = document.getElementById("cardCVV").value;

                if (cardType === "" || cardName === "" || cardExp === "" || cardCVV === "") {
                  alert("Please fill in all the card details.");
                  return false;
                }
                
                // Card number validation
                var cardNumberRegex = /^\d{16}$/;
                if (!cardNumberRegex.test(cardNumber)) {
                  alert("Please enter a valid 16-digit card number.");
                  return false;
                }

                // Expiry date validation
                var cardExpRegex = /^(0?[1-9]|1[0-2])\/([2-9][3-9])$/;
                if (!cardExpRegex.test(cardExp)) {
                  alert("Please enter a valid expiry date in the format of MM/YY.");
                  return false;
                }

                var expMonth = parseInt(cardExp.split('/')[0]);
                var expYear = parseInt(cardExp.split('/')[1]) + 2000;

                if (expMonth < 1 || expMonth > 12) {
                  alert("Please enter a valid month for expiry date.");
                  return false;
                }

                var currentYear = new Date().getFullYear();
                if (expYear < currentYear || expYear > currentYear + 10) {
                  alert("Please enter a valid year for expiry date.");
                  return false;
                }

                // CVV validation
                var cardCVVRegex = /^\d{3}$/;
                if (!cardCVVRegex.test(cardCVV)) {
                  alert("Please enter a valid 3-digit CVV.");
                  return false;
                }
            }
            
            const visaRadio = document.getElementById("visaRadio");
            const creditCardRadio = document.getElementById("creditCardRadio");
            const cashRadio = document.getElementById("cashRadio");
            const cardDetails = document.getElementById("cardDetails");
            const deliveryAddress = document.querySelector('input[name="address1"]');

            visaRadio.addEventListener("click", () => {
                cardDetails.style.display = "block";
            });

            creditCardRadio.addEventListener("click", () => {
                cardDetails.style.display = "block";
            });

            cashRadio.addEventListener("click", () => {
                cardDetails.style.display = "none";
            });
            
            function updateLink() {
                var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
                var address = document.getElementById('address1').value;
                var link = document.getElementById("confirmPayment");
                link.href = '<%= ROOT_PATH %>/pages/product/FindCustOrder?paymentMethod=' + paymentMethod + '&address=' + encodeURIComponent(address);
            }

            // Add an event listener to the payment method radio buttons
            var paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
            paymentRadios.forEach(function(radio) {
              radio.addEventListener('change', updateLink);
            });
        </script>
    </body>
</html>

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

