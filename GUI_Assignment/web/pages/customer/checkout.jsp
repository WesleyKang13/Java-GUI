<% String ROOT_PATH = "../../"; %>
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
        
        <table class="checkout-table">
            <tr>
            <div class="details-container">
                
                <td class="items">
                    <div class="image">
                        <picture>
                            <img src="../../assets/product/dummy1.jpg" alt="">
                        </picture>
                    </div>
                    
                    <p class="items-details">
                        Name: Nike run 2017<br>
                        Price (RM): 599.00<br>
                        Size chosen (UK): 9<br>
                        Quantity: 1
                    </p>
                </td>
                
            </div>

                <td class="summary">

                    <h2>Checkout summary</h2>
                    <p class="summary-details">
                        Total item(s): <strong>1</strong><br>
                    Estimated delivery &handling : <strong>FREE</strong><br>
                    Subtotal (RM): <strong>599.00</strong><br>
                    </p>

                    <div class="shipping-details">
                        <h3>Shipping address:</h3>
                        <p>
                            <label for="address1">Delivery address:</label>
                            <br>
                            <input type="text" name="address1">
                            <br>
                        </p>
                    </div>

                    <div class="voucher">
                        <h3>Voucher</h3>
                        <select name="voucher" id="voucher">
                            <option value="none"><h3>Apply voucher</h3></option>
                            <option value=""></option>
                            <option value=""></option>
                        </select>
                    </div>
                        
                    <div class="paymentMethod">
                        <h3>Payment method</h3>
                        <input type="radio" value="VISA" name="paymentMethod">
                        <label for="visa"><i class="fa-solid fa-credit-card"></i> Debit Card</label>
                        <br>
                        <input type="radio" value="Credit card" name="paymentMethod">
                        <label for="creditCard"><i class="fa-regular fa-credit-card"></i> Credit Card</label>
                        <br>
                        <input type="radio" value="cash" name="paymentMethod">
                        <label for="cash"><i class="fa-solid fa-sack-dollar"></i> Cash</label>
                        <br>
                    </div>
                
                    <button class="checkout-button">Confirm</button>
                </td>
            </tr>
        </table>
        
    </body>
</html>

<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

