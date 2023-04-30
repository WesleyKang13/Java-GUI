<%@page import="entity.Product"%>
<%@page import="entity.OrderItem"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entity.CustOrder"%>

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
    
    //Redirect to home page if it's not customer
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 2){
        response.sendRedirect(ROOT_PATH+"index.html");
    }
    
    //Get orders information from controller (LoadOrder.jsp)
    //Order List
    List<CustOrder> orderList=(List<CustOrder>) request.getAttribute("orderList") != null ? (List<CustOrder>) request.getAttribute("orderList") : null;
    //Edit Order
    CustOrder orderDetail=(CustOrder) request.getAttribute("orderDetail") != null ? (CustOrder) request.getAttribute("orderDetail") : null;
    CustOrder reviewOrder=(CustOrder) request.getAttribute("reviewOrder") != null ? (CustOrder) request.getAttribute("reviewOrder") : null;
    Product reviewProduct =(Product) request.getAttribute("reviewProduct") != null ? (Product) request.getAttribute("reviewProduct") : null;
    
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.order").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/customer/panel/order.css"%>">

<main>
    <% 
        //Start Display Cstomer List
        if(orderList != null){ 
    %>
    <div class="orderList container">
        <div class="text">
            <h1>Order List </h1>
            <% //Display search value when searching
                if(searchValue!=null){
                    out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/customer/panel/LoadOrder'>Reset</a>)</h3>");
                }
            %>
            <%!
                private String maintainSearchBarValue(String searchValue){
                    if(searchValue != null) return "value='"+searchValue+"'"; 
                    return "";
                }
            %>
            <p><%=orderList.size()%> record(s) found</p>
        </div>
        <div class="searchBar">
            <input id="searchInput" type="search" placeholder="Search ..." <%=maintainSearchBarValue(searchValue)%> required>
            <a id="searchBtn" href="#"><i class='fa-solid fa-magnifying-glass fa-bounce'></i></a>
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
            <button type="button" <%=validateFilter("all", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/customer/panel/LoadOrder"%>'">All</button>
            <button type="button" <%=validateFilter("PENDING", filter)%> value="PENDING" onclick="filterOrders('PENDING')">Pending</button>
            <button type="button" <%=validateFilter("SHIPPING", filter)%> value="SHIPPING" onclick="filterOrders('SHIPPING')">Shipping</button>
            <button type="button" <%=validateFilter("POSTPONED", filter)%> value="POSTPONED" onclick="filterOrders('POSTPONED')">Postponed</button>
            <button type="button" <%=validateFilter("CANCELLED", filter)%> value="CANCELLED" onclick="filterOrders('CANCELLED')">Cancelled</button>
            <button type="button" <%=validateFilter("COMPLETED", filter)%> value="COMPLETED" onclick="filterOrders('COMPLETED')">Completed</button>
        </div>

        <script>
            const filterOrders = (status) => {
              const url = "<%=ROOT_PATH+"pages/customer/panel/LoadOrder/filter/"%>" + status;
              window.location.href = url;
            };
            
            const searchBtn = document.querySelector('#searchBtn');
            const searchInput = document.querySelector('#searchInput');

            searchBtn.addEventListener('click', (event) => {
              event.preventDefault();
              const searchValue = searchInput.value;
              const url = "<%=ROOT_PATH+"pages/customer/panel/LoadOrder/search/"%>" + searchValue;
              window.location.href = url;
            });
        </script>

        <!--Display Notification Area-->
        <%if(successMsg!=null){%>
            <div class="notificationBox success">
                <span class="message"><%=successMsg%></span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>
        <%} if(errorMsg!=null){%>
            <div class="notificationBox error">
                <span class="message"><%=errorMsg%></span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>
        <%}if(orderList.size() > 0){%>

        <table class="table horizontal-table">
            <thead>
                <tr>
                    <th><i class="fa-solid fa-hashtag"></i></th>
                    <th>ID</th>
                    <th>Payt ID</th>
                    <th>Order Date</th>
                    <th>Shipping Address</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(int i=0; i<orderList.size();i++){
                    CustOrder o = orderList.get(i);
                %>
                <tr>
                    <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                    <td><%=o.getOrderId()%></td><td><%=o.getPaytId().getPaytId()%></td>
                    <td><%=convertTimestamp(o.getDate())%></td>
                    <td><%=o.getOrderShippingAddress()%></td>
                    <td><%=o.getOrderStatus()%></td>
                    <td>
                        <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/customer/panel/LoadOrder/orderID/"+o.getOrderId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } //End if (if product size >= 0)%> 
    </div>
    <% 
        //Start Order Detail
        }else if(orderDetail != null){
    %>
    <div class="orderDetail container">
        <div class="text">
            <h1>Order Detail</h1>
        </div>
        
        <!-- Start Order Table-->
            <table class="table vertical-table">
                <tr>
                    <td><strong>ID </strong></td>
                    <td><%=orderDetail.getOrderId()%></td>
                </tr>
                <tr>
                    <td><strong>Order Date</strong></td>
                    <td><%=convertTimestamp(orderDetail.getDate())%></td>
                </tr>
                <tr>
                    <td><strong>Payment</strong></strong></td>
                    <td>
                        <table>
                            <tr>
                              <td><strong>PAYT ID</strong></td>
                              <td><%=orderDetail.getPaytId().getPaytId()%></td>
                            </tr>
                            <tr>
                              <td><strong>Total Amount</strong></td>
                              <td>RM <%=orderDetail.getPaytId().getPaytTotalAmount()%></td>
                            </tr>
                            <tr>
                              <td><strong>Method</strong></td>
                              <td><%=orderDetail.getPaytId().getPaytMethod()%></td>
                            </tr>
                            <tr>
                              <td><strong>Date</strong></td>
                              <td><%=convertTimestamp(orderDetail.getPaytId().getPaytDate())%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><%=orderDetail.getOrderShippingAddress()%></td>
                </tr>
                <tr>
                    <td><strong>Status</strong></td>
                    <td><%=orderDetail.getOrderStatus()%></td>
                </tr>
                <%List<OrderItem> orderItems = (List<OrderItem>)request.getAttribute("orderItems");%>
                <tr>
                    <td><strong>Order Item</strong></td>
                    <td>Total purchased <%=orderItems.size()%> item(s).</td>
                </tr>
                <%
                    for (int i = 0; i < orderItems.size(); i++) {
                        OrderItem oi = orderItems.get(i);
                %>
                <tr>
                    <td><strong>Item <%=i+1%></strong></td>
                    <td>
                        <table>
                            <tr>
                              <td><strong>Prod ID</strong></td>
                              <td><%=oi.getProdId().getProdId()%></td>
                            </tr>
                            <tr>
                              <td><strong>Prod Name</strong></td>
                              <td><%=oi.getProdId().getProdName()%></td>
                            </tr>
                            <tr>
                              <td><strong>Quantity</strong></td>
                              <td><%=oi.getOrderItemQuantity()%></td>
                            </tr>
                            <tr>
                              <td colspan="2" style="text-align: center;"><button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/customer/panel/LoadOrder/ReviewOrder/"+orderDetail.getOrderId()+"/ProdId/"+oi.getProdId().getProdId()%>'"><i class="fa-solid fa-comments fa-spin"></i></button></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                    <% } %>
            </table>
        <!--End Order Detail-->
            
        <div class="detail-action">
            <button class="orderDetailBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/customer/panel/LoadOrder"%>'">Back</button>
        </div> 
    </div>
    
    <% } else if(reviewOrder != null){%>
        <div class="reviewOrder container">
            <h2>Leave a Review</h2>
            <form action="<%=ROOT_PATH+"pages/customer/panel/ReviewProduct" %>" method="POST">
            <table class="table vertical-table">
                <input type="hidden" name="order_id" value="<%=reviewOrder.getOrderId()%>">
                <input type="hidden" name="prod_id" value="<%=reviewProduct.getProdId()%>">
                <tr>
                    <td><strong>Order ID</strong></td>
                    <td><%=reviewOrder.getOrderId()%></td>
                </tr>
                <tr>
                    <td><strong>Product</strong></td>
                    <td><%=reviewProduct.getProdId()+" - "+reviewProduct.getProdName()%></td>
                </tr>
                <tr>
                    <td><strong>Score</strong></td>
                    <td><input type="number" min="1" max="5" step="0.5" name="review_score"></td>
                </tr>
                <tr>
                    <td><strong>Comment</strong></td>
                    <td><input type="text" minlength="5" maxlength="500" name="review_comment"></td>
                </tr>
            </table>

            <div class="addNew-action">
                <button type="button" class="editCustBackBtn backBtn btn" onclick="if(confirm('Are you sure you want to go back?')) { location.href='<%=ROOT_PATH+"pages/customer/panel/LoadOrder" %>'; } else { return false; }" style="float: left;">Back</button>
                <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to add new review?')) { return true; } else { return false; }">Submit</button>
                <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }">Reset</button>
            </div>
        </form>
        </div>
    <% } %>
    
</main>
</body>
</html>