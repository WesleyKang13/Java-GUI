<%@page import="entity.Payment"%>
<%@page import="entity.CustOrder"%>
<%@page import="entity.Inventory"%>
<%@page import="entity.Product"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>

<%!
    public static String convertTimestamp(Date timestamp) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // Create a date format object
        String formattedDate = sdf.format(timestamp); // Format the date as a string
        return formattedDate;
    }
%>

<% 
    //Get notification from controllers
    String successMsg = request.getParameter("successMsg") != null ? (String) request.getParameter("successMsg") : null;
    String errorMsg = request.getParameter("errorMsg") != null ? (String)request.getParameter("errorMsg") : null;
    String searchValue = request.getAttribute("searchValue") != null ? (String)request.getAttribute("searchValue") : null;
    request.removeAttribute("searchValue");
    String filter = request.getAttribute("filter") != null ? (String)request.getAttribute("filter") : null;
    request.removeAttribute("filter");
    
    //Get root path (from controller)
    String ROOT_PATH = (String) request.getAttribute("ROOT_PATH");
    
    //Redirect to home page if it's not admin
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 0 && validatePermission != 1){
        response.sendRedirect(ROOT_PATH+"index.html");
    }
    
    //Get payments information from controller (LoadPayment.jsp)
    //Declare variable
    List<Payment> paymentList=(List<Payment>) request.getAttribute("paymentList") != null ? (List<Payment>) request.getAttribute("paymentList") : null;
    Payment paymentDetail=(Payment) request.getAttribute("paymentDetail") != null ? (Payment) request.getAttribute("paymentDetail") : null;
    CustOrder orderDetail=(CustOrder) request.getAttribute("orderDetail") != null ? (CustOrder) request.getAttribute("orderDetail") : null;
    
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.order").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/payment.css"%>">

<main>
    
    <div class="groupTabs">
        
        <input type="radio" id="order" name="tab">
        <label for="order" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadOrder"%>'">Order</label>
        
    
        <input type="radio" id="payment" name="tab" checked="checked">
        <label for="payment" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadPayment"%>'">Payment</label>
        <div class="container paymentList tab">
    <% 
        //Start Display Cstomer List
        if(paymentList != null){ 
    %>  
        <div class="paymentList">
            <div class="text">
                <h1>Payment List</h1>
                <p><%=paymentList.size()%> record(s) found</p>
            </div>

            <%!
                private String validateFilter(String value, String filter){
                    if (filter == null || filter.equals("all")) {
                        if (value.equals("all")) {
                            return "class='active'";
                        }
                        return "";
                    } else if (value.equals(filter)) {
                        return "class='active'";
                    }
                    return "";
                }
            %>
            <div class="filter">
                <button type="button" <%=validateFilter("all", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadPayment"%>'">All</button>
                <button type="button" <%=validateFilter("CASH", filter)%> value="CASH" onclick="filterMethods('CASH')">Cash</button>
                <button type="button" <%=validateFilter("DEBIT", filter)%> value="DEBIT" onclick="filterMethods('DEBIT')">Debit Card</button>
                <button type="button" <%=validateFilter("CREDIT", filter)%> value="CREDIT" onclick="filterMethods('CREDIT')">Credit Card</button>
            </div>

            <script>
                const filterMethods = (type) => {
                  const url = "<%=ROOT_PATH+"pages/admin/LoadPayment/filter/"%>" + type;
                  window.location.href = url;
                };
            </script>

            
            <% if(paymentList.size() > 0){ %>

            <table class="table horizontal-table">
                <thead>
                    <tr>
                        <th><i class="fa-solid fa-hashtag" ></i></th>
                        <th>ID</th>
                        <th>Total Amount (RM)</th>
                        <th>Method</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for(int i=0; i<paymentList.size();i++){
                            Payment p = paymentList.get(i);
                    %>
                    <tr>
                        <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                        <td><%=p.getPaytId()%></td>
                        <td><%=p.getPaytTotalAmount()%></td>
                        <td><%=p.getPaytMethod()%></td>
                        <td><%=convertTimestamp(p.getPaytDate())%></td>
                        <td>
                            <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadPayment/paymentDetailID/"+p.getPaytId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } //End if (if payment size >= 0)%> 
        </div>


    <% 
        //Start Edit Payment
        }else if(paymentDetail != null){
        
        
    %>
        <div class="paymentDetail">
            <div class="text">
                <h1>Payment Detail</h1>
                <p><strong><%= "BY Customer ID " + orderDetail.getCustId().getCustId()+ " - " +orderDetail.getCustId().getCustFullName()%></strong></p>
            </div>

            <!-- Start Show Payment Info-->
            <table class="table vertical-table">
                <tr>
                    <td><strong>ID</strong></td>
                    <td><%=paymentDetail.getPaytId()%></td>
                </tr>
                <tr>
                    <td><strong>Total Amount (RM)</strong></strong></td>
                    <td><%=paymentDetail.getPaytTotalAmount()%></td>
                </tr>
                <tr>
                    <td><strong>Order</strong></td>
                    <td>
                        <table>
                            <tr>
                                <td><strong>Order ID</strong></strong></td>
                                <td><%=orderDetail.getOrderId()%></td>
                            </tr>
                            <tr>
                                <td><strong>Shipping Address</strong></strong></td>
                                <td><%=orderDetail.getOrderShippingAddress()%></td>
                            </tr>
                            <tr>
                                <td><strong>Status</strong></strong></td>
                                <td><%=orderDetail.getOrderStatus()%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><strong>Customer</strong></td>
                    <td>
                        <table>
                            <tr>
                                <td><strong>Cust ID</strong></strong></td>
                                <td><%=orderDetail.getCustId().getCustId()%></td>
                            </tr>
                            <tr>
                                <td><strong>Full Name</strong></strong></td>
                                <td><%=orderDetail.getCustId().getCustFullName()%></td>
                            </tr>
                            <tr>
                                <td><strong>Contact</strong></strong></td>
                              <td>
                                  <% if(orderDetail.getCustId().getUserId().getUserEmail() != null){%>
                                          <a style="width: 1rem; padding: 0 0.5rem;" href="mailto:<%=orderDetail.getCustId().getUserId().getUserEmail()%>" class="contactRoundBtn"><i class="fa-solid fa-envelope"></i></i></a>
                                  <%}if(orderDetail.getCustId().getCustPhoneNum() != null){ %>
                                          <a style="width: 1rem;padding: 0 0.5rem;" href="tel:<%=orderDetail.getCustId().getCustPhoneNum()%>" class="contactRoundBtn"><i class="fa-solid fa-phone"></i></a>
                                  <% } %>
                              </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><strong>Payment Method</strong></strong></td>
                    <td><%=paymentDetail.getPaytMethod()%></td>
                </tr>
                <tr>
                    <td><strong>Payment Date</strong></strong></td>
                    <td><%=convertTimestamp(paymentDetail.getPaytDate())%></td>
                </tr>
            </table>
                    
            <!--End Show Payment Info-->
            <div class="detail-action">
                <button class="paymentBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadPayment"%>'">Back</button>
            </div>
        </div>
    <% } %>
    
        </div>
        <input type="radio" id="review" name="tab">
        <label for="review" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadReview"%>'">Review</label>
    </div>
</main>
</body>
</html>