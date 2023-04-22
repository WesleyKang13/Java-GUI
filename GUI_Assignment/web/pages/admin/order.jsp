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
    
    //Get orders information from controller (LoadOrder.jsp)
    //Order List
    List<CustOrder> orderList=(List<CustOrder>) request.getAttribute("orderList") != null ? (List<CustOrder>) request.getAttribute("orderList") : null;
    //Edit Order
    CustOrder editOrder=(CustOrder) request.getAttribute("editOrder") != null ? (CustOrder) request.getAttribute("editOrder") : null;
    
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    body.querySelector(".nav-link.order").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/order.css"%>">

<main>
    <% 
        //Start Display Cstomer List
        if(orderList != null){ 
    %>
    <div class="container orderList">
        <div class="text">
            <h1>Order List </h1>
            <% //Display search value when searching
                if(searchValue!=null){
                    out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+"</h3>");
                    out.print("<a href='"+ROOT_PATH+"pages/admin/LoadOrder'>Reset</a>");
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
            <button type="button" <%=validateFilter("all", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadOrder"%>'">All</button>
            <button type="button" <%=validateFilter("PENDING", filter)%> value="PENDING" onclick="filterOrders('PENDING')">Pending</button>
            <button type="button" <%=validateFilter("SHIPPING", filter)%> value="SHIPPING" onclick="filterOrders('SHIPPING')">Shipping</button>
            <button type="button" <%=validateFilter("POSTPONED", filter)%> value="POSTPONED" onclick="filterOrders('POSTPONED')">Postponed</button>
            <button type="button" <%=validateFilter("CANCELLED", filter)%> value="CANCELLED" onclick="filterOrders('CANCELLED')">Cancelled</button>
            <button type="button" <%=validateFilter("COMPLETED", filter)%> value="COMPLETED" onclick="filterOrders('COMPLETED')">Completed</button>
        </div>

        <script>
            const filterOrders = (status) => {
              const url = "<%=ROOT_PATH+"pages/admin/LoadOrder/filter/"%>" + status;
              window.location.href = url;
            };
            
            const searchBtn = document.querySelector('#searchBtn');
            const searchInput = document.querySelector('#searchInput');

            searchBtn.addEventListener('click', (event) => {
              event.preventDefault();
              const searchValue = searchInput.value;
              const url = "<%=ROOT_PATH+"pages/admin/LoadOrder/search/"%>" + searchValue;
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
        <%}if(orderList.size() >= 0){%>

        <table class="table horizontal-table">
            <thead>
                <tr>
                    <th><i class="fa-solid fa-hashtag" style="width:0rem;"></i></th>
                    <th>ID</th>
                    <th>Cust ID</th>
                    <th>Payt ID</th>
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
                    <td><%=o.getOrderId()%></td>
                    <td><%=o.getCustId().getCustId()%></td>
                    <td><%=o.getPaytId().getPaytId()%></td>
                    <td><%=o.getOrderShippingAddress()%></td>
                    <td><%=o.getOrderStatus()%></td>
                    <td>
                        <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadOrder/editOrderID/"+o.getOrderId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                        <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this order?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteOrder?deleteId="+o.getCustId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } //End if (if customer size >= 0)%> 
    </div>
    <% 
        //Start Edit Order
        }else if(editOrder != null){
    %>
    <div class="container orderDetail">
        <div class="text">
            <h1>Order Detail</h1>
            <p><strong>ID - <%=editOrder.getOrderId()+" by "+editOrder.getCustId().getCustFullName()%></strong></p>
            <p style="padding-top: 0.5rem;"><strong>Order Date  - <%=convertTimestamp(editOrder.getDate())%></strong></p>
        </div>

        <!--Notification Area-->
        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Message</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <!-- Start Edit Order Form-->
        <form action="<%=ROOT_PATH+"pages/admin/UpdateOrder" %>" method="POST">
            <table class="table vertical-table">
                <tr>
                    <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                    <td><input type="text" value="<%=editOrder.getOrderId()%>" disabled></td>
                    <input type="hidden" name="edit_Id" id="edit_Id" value="<%=editOrder.getOrderId()%>">
                </tr>
                <tr>
                    <td><strong>Customer</strong></strong></td>
                    <td>
                        <table>
                            <tr>
                              <td><strong>Cust ID</strong></td>
                              <td><%=editOrder.getCustId().getCustId()%></td>
                            </tr>
                            <tr>
                              <td><strong>Name</strong></td>
                              <td><%=editOrder.getCustId().getCustFullName()%></td>
                            </tr>
                            <tr>
                              <td><strong>Contact</strong></td>
                              <td>
                                  <% if(editOrder.getCustId().getUserId().getUserEmail() != null){%>
                                          <a style="width: 1rem; padding: 0 0.5rem;" href="mailto:<%=editOrder.getCustId().getUserId().getUserEmail()%>" class="contactRoundBtn"><i class="fa-solid fa-envelope"></i></i></a>
                                  <%}if(editOrder.getCustId().getCustPhoneNum() != null){ %>
                                          <a style="width: 1rem;padding: 0 0.5rem;" href="tel:<%=editOrder.getCustId().getCustPhoneNum()%>" class="contactRoundBtn"><i class="fa-solid fa-phone"></i></a>
                                  <% } %>
                              </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><strong>Payment</strong></strong></td>
                    <td>
                        <table>
                            <tr>
                              <td><strong>PAYT ID</strong></td>
                              <td><%=editOrder.getPaytId().getPaytId()%></td>
                            </tr>
                            <tr>
                              <td><strong>Total Amount</strong></td>
                              <td>RM <%=editOrder.getPaytId().getPaytTotalAmount()%></td>
                            </tr>
                            <tr>
                              <td><strong>Method</strong></td>
                              <td><%=editOrder.getPaytId().getPaytMethod()%></td>
                            </tr>
                            <tr>
                              <td><strong>Date</strong></td>
                              <td><%=convertTimestamp(editOrder.getPaytId().getPaytDate())%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><input type="text" name="edit_shippingAddress" id="edit_shippingAddress" value="<%=editOrder.getOrderShippingAddress()%>" disabled></td>
                </tr>
                <%!
                    private String validateStatus(String status, String value) {
                        if (status.equals(value)) return "selected=\"selected\"";
                        return "";
                    }
                %>
                <tr>
                    <td><strong>Status</strong></td>
                    <td>
                        <select name="edit_status" id="edit_status" disabled>
                            <option value="PENDING" <%=validateStatus("PENDING", editOrder.getOrderStatus())%>>Pending</option>
                            <option value="SHIPPING" <%=validateStatus("SHIPPING", editOrder.getOrderStatus())%>>Shipping</option>
                            <option value="POSTPONED" <%=validateStatus("POSTPONED", editOrder.getOrderStatus())%>>Postponed</option>
                            <option value="CANCELLED" <%=validateStatus("CANCELLED", editOrder.getOrderStatus())%>>Cancelled</option>
                            <option value="COMPLETED" <%=validateStatus("COMPLETED", editOrder.getOrderStatus())%>>Completed</option>
                        </select>
                    </td>
                </tr>
                <%List<OrderItem> editOrderItems = (List<OrderItem>)request.getAttribute("editOrderItems");%>
                <tr>
                    <td><strong>Order Item</strong></td>
                    <td>Total purchased <%=editOrderItems.size()%> item(s).</td>
                </tr>
                <%
                    for (int i = 0; i < editOrderItems.size(); i++) {
                        OrderItem oi = editOrderItems.get(i);
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
                        </table>
                    </td>
                </tr>
                    <% } %>
            </table>

            <div class="edit-action hide">
                <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this order?')) { return true; }else{return false;}">Save</button>
            </div>
        </form>
        <!--End Edit Order Form-->
            
        <div class="detail-action">
            <button class="editOrderBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadOrder"%>'" style="float: left;">Back</button>
            <button class="editBtn btn success">Edit</button>
            <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this order?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteOrder?deleteId="+editOrder.getOrderId()%>'; }else{return false;}">Delete</button>
        </div>
    </div>
    <% } %>
    <script>
        //SHOW and HIDE Action Button
        const editBtn = body.querySelector('.editBtn'),
            actionBtnField = body.querySelector('.detail-action'),
            editActionBtnField = body.querySelector('.edit-action');
    
        if (editBtn) {
            //Get Text Field and remove 'disabled'
            editBtn.addEventListener("click" , () =>{
                actionBtnField.classList.add("hide");
                editActionBtnField.classList.remove("hide");
                document.getElementById('edit_shippingAddress').removeAttribute("disabled");
                document.getElementById('edit_status').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>