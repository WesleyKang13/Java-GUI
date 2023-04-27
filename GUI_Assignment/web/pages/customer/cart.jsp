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
                <th>Product details</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
            
            <%
                List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems") != null ? (List<Cart>) request.getAttribute("cartItems") : null;
    
                if(cartItems != null){
                for (Cart cartItem : cartItems) {
            %>
            <tr>
                <th><%= cartItem.getProdId().getProdName()%></td>
                <td><%= cartItem.getProdId().getProdPrice() %></td>
                <td><%= cartItem.getCartQuantity()%></td>
                <td><%= cartItem.getTotalAmount() %></td>
            </tr>
            <% } }%>

        </table>
        
        <a href="./pages/customer/FindCheckout">Checkout</a>
        
    </body>
</html>
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
