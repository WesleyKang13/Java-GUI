<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

<body >
    

   

    <table style="background-color: rgb(207, 199, 199); margin:0 auto; border:2px black solid; border-radius:10px; box-shadow: 10px 10px; width:550px;height:380px; margin-top:20px;margin-bottom:20px;">
            <tr>
                <td>
                    <h1 style="text-align:center; ">Payment Received!</h1>
                    <p> Mr/Ms [name], </p>
                    <p style="line-height:22px;">Your transaction was successful! <br>Thank you for your support. We here at Banana Store are grateful for your patronage and look forward to serving  you in the future.  </p>
                    
                        <p><strong>Payment Details:</strong></p>
                         
                        <table>
                            <tr>
                                <td>
                                    Payment Method:
                                </td>
                                <td>
                                    <input type="text" value="${payment.method}"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Date:
                                </td>
                                <td>
                                    <input type="text" value="${payment.date}"/>
                                </td>
                            </tr>   
                            <tr>
                                <td>
                                    Payment Id:
                                </td>
                                <td>
                                    <input type="text" value="${payment.id}"/>
                                </td>
                            </tr> 

                        </table>
                                <br>
                                <a href="">Product Order Details</a>
                        <p><strong>*We advise you to keep this receipt for future reference.*</strong></p>
                        <a href="" style="text-align: center; text-decoration:none;">
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