<%@page import="entity.CustOrder"%>
<%@page import="entity.Payment"%>
<%@page import="entity.Customer"%>
<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<%
        
    Customer customer = session.getAttribute("customer")!=null?(Customer)session.getAttribute("customer"):null;
    CustOrder order = session.getAttribute("order")!=null?(CustOrder)session.getAttribute("order"):null;
    Payment payment = session.getAttribute("payment")!=null?(Payment)session.getAttribute("payment"):null;
    session.removeAttribute("customer");
    session.removeAttribute("order");
    session.removeAttribute("payment");
    
%>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

<body >
    
    <style>
        input{
            position:relative;
            left:190px;
            width:90%;
        }
        .paymentDetails:hover,.back:hover{
            color:grey;
            
        }
    </style>

    <table>
            <tr>
                <td>
                    <h1 style="text-align:center; ">Payment Received!</h1>
                       
                    <p>Transaction number: <%= payment.getPaytId()%></p>
                    <p > Mr/Ms  <%=customer.getCustFullName()%>, </p>
                    <p style="line-height:22px;">Your transaction was successful! <br>Thank you for your support. We here at Banana Store are grateful for your patronage and look forward to serving  you in the future.  </p>
                    
                        <p><strong>Payment Details:</strong></p>
                         
                        <table>
                            <tr>
                                <td>Customer Name:</td>
                                <td><%=customer.getCustFullName()%></td>
                            </tr>
                            <tr>
                                <td>Phone Number:</td>
                                <td><%=customer.getCustPhoneNum()%></td>
                            </tr>
                            
                            <tr>
                                <td>Payment method:</td>
                                <td><%=payment.getPaytMethod()%></td>
                            </tr>
                            
                            <tr>
                                <td>Order id:</td>
                                <td><%=order.getOrderId()%></td>
                            </tr>
                            
                            <tr>
                                <td>Total amount:</td>
                                <td><%=payment.getPaytTotalAmount()%></td>
                            </tr>
                            
                            <tr>
                                <td>Order Date:</td>
                                <td><%=order.getDate()%></td>
                            </tr>
                        </table>
                                <br>
                                <a href="<%=ROOT_PATH+"pages/customer/panel/LoadOrder/orderID/"+order.getOrderId()%>" class="#">Click Me to view Product Order Details</a>
                        <p><strong>*We advise you to keep this receipt for future reference.*</strong></p>
                        <a href="<%=ROOT_PATH+"index.jsp"%>" class="back" style="text-align: center; text-decoration:none;">
                            Back to Home Page
                        </a>
                        
                    
                </td>
            </tr>
        
            

       
    </table>

</body>
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>