<%@page import="entity.Review"%>
<%@page import="entity.Inventory"%>
<%@page import="entity.Product"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>

<% 
    //Get notification from controllers
    String successMsg = request.getParameter("successMsg") != null ? (String) request.getParameter("successMsg") : null;
    String errorMsg = request.getParameter("errorMsg") != null ? (String)request.getParameter("errorMsg") : null;
    String searchValue = request.getAttribute("searchValue") != null ? (String)request.getAttribute("searchValue") : null;
    request.removeAttribute("searchValue");
    
    //Get root path (from controller)
    String ROOT_PATH = (String) request.getAttribute("ROOT_PATH");
    
    //Redirect to home page if it's not admin
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 0 && validatePermission != 1){
        System.out.println("helllllllo");
        response.sendRedirect(ROOT_PATH+"index.html");
    }
    
    //Get reviews information from controller (LoadReview.jsp)
    //Declare variable
    List<Review> reviewList=(List<Review>) request.getAttribute("reviewList") != null ? (List<Review>) request.getAttribute("reviewList") : null;
    Review replyReview=(Review) request.getAttribute("replyReview") != null ? (Review) request.getAttribute("replyReview") : null;
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.order").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/review.css"%>">

<main>
    
    <div class="groupTabs">
        
        <input type="radio" id="order" name="tab">
        <label for="order" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadOrder"%>'">Order</label>
        
        <input type="radio" id="payment" name="tab">
        <label for="payment" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadPayment"%>'">Payment</label>
        
        <input type="radio" id="review" name="tab" checked="checked">
        <label for="review" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadReview"%>'">Review</label>
        <div class="container reviewList tab">
    <% 
        //Start Display Cstomer List
        if(reviewList != null){ 
    %>  
        <div class="reviewList">
            <div class="text">
                <h1>Review List </h1>
                <% //Display search value when searching
                    if(searchValue!=null){
                        out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/admin/LoadReview'>Reset</a>)</h3>");
                    }
                %>
                <%!
                    private String maintainSearchBarValue(String searchValue){
                        if(searchValue != null) return "value='"+searchValue+"'"; 
                        return "";
                    }
                %>
                <p><%=reviewList.size()%> record(s) found</p>
            </div>

            <div class="searchBar">
                <input id="searchInput" type="search" placeholder="Search ..." <%=maintainSearchBarValue(searchValue)%> required>
                <a id="searchBtn" href="#"><i class='fa-solid fa-magnifying-glass fa-bounce'></i></a>
            </div>

            <script>
                const searchBtn = document.querySelector('#searchBtn');
                const searchInput = document.querySelector('#searchInput');

                searchBtn.addEventListener('click', (event) => {
                  event.preventDefault();
                  const searchValue = searchInput.value;
                  const url = "<%=ROOT_PATH+"pages/admin/LoadReview/search/"%>" + searchValue;
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
            <% }if(reviewList.size() > 0){ %>

            <table class="table horizontal-table">
                <thead>
                    <tr>
                        <th><i class="fa-solid fa-hashtag" ></i></th>
                        <th>ID</th>
                        <th>Order</th>
                        <th>Product</th>
                        <th>Customer</th>
                        <th>Score</th>
                        <th>Description</th>
                        <th>Reply</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for(int i=0; i<reviewList.size();i++){
                            Review r = reviewList.get(i);
                            
                            if(r.getProdId()==null || r.getCustId()==null || r.getReviewScore()==null){
                                continue;
                            }
                            //Product Detail
                            String prodDetails = r.getProdId().getProdName();
                            if(prodDetails.length() > 10){
                                prodDetails = prodDetails.substring(0, 10)+"...";
                            }
                            prodDetails = r.getProdId().getProdId() + " - " + prodDetails;
                            
                            //Customer Detail
                            String custDetails = r.getCustId().getCustFullName();
                            if(custDetails.length() > 10){
                                custDetails = custDetails.substring(0, 10)+"...";
                            }
                            custDetails = r.getCustId().getCustId() + " - " + custDetails;
                            
                            //Replied this review or not
                            String replyDetail = "null";
                            if(r.getReviewReply() != null){
                                replyDetail = "<i class='fa-solid fa-check replyIconSuccess'></i>";
                            }else{
                                replyDetail = "<i class='fa-solid fa-xmark replyIconDanger'></i>";
                            }
                            
                            //Description
                            String description = r.getReviewDescription();
                            if(description.length() > 10){
                                description = description.substring(0, 10)+"...";
                            }
                    %>
                    <tr>
                        <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                        <td><%=r.getReviewId()%></td>
                        <td><%=r.getOrderId().getOrderId()%></td>
                        <td><%=prodDetails%></td>
                        <td><%=custDetails%></td>
                        <td><%=r.getReviewScore()%></td>
                        <td><%=description%></td>
                        <td><%=replyDetail%></td>
                        <td>
                            <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadReview/replyReviewID/"+r.getReviewId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                            <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this review?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteReview?deleteId="+r.getReviewId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } //End if (if review size >= 0)%> 
        </div>
        
        <% 
            //Start Edit Review
            }else if(replyReview != null){
                    
                    
        %>
        <div class="replyReview">
            <div class="text">
                <h1>Reply Review</h1>
                <p><strong>ID - <%=replyReview.getReviewId()+" by Customer ID "+replyReview.getCustId().getCustId()+" ("+replyReview.getCustId().getCustFullName()+")"%></strong></p>
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

            <!-- Start Edit Review Form-->
            <form action="<%=ROOT_PATH+"pages/admin/ReplyReview" %>" method="POST">
                <input type="hidden" name="reply_Id" id="reply_Id" value="<%=replyReview.getReviewId()%>">
                <table class="table vertical-table">
                    <tr>
                        <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                        <td><%=replyReview.getReviewId()%></td>
                    </tr>
                    <tr>
                        <td><strong>Customer</strong></strong></td>
                        <td>
                            <table>
                                <tr>
                                    <td><strong>Cust ID</strong></strong></td>
                                    <td><%=replyReview.getCustId().getCustId()%></td>
                                </tr>
                                <tr>
                                    <td><strong>Full Name</strong></strong></td>
                                    <td><%=replyReview.getCustId().getCustFullName()%></td>
                                </tr>
                                <tr>
                                    <td><strong>Contact</strong></strong></td>
                                  <td>
                                      <% if(replyReview.getCustId().getUserId().getUserEmail() != null){%>
                                              <a style="width: 1rem; padding: 0 0.5rem;" href="mailto:<%=replyReview.getCustId().getUserId().getUserEmail()%>" class="contactRoundBtn"><i class="fa-solid fa-envelope"></i></i></a>
                                      <%}if(replyReview.getCustId().getCustPhoneNum() != null){ %>
                                              <a style="width: 1rem;padding: 0 0.5rem;" href="tel:<%=replyReview.getCustId().getCustPhoneNum()%>" class="contactRoundBtn"><i class="fa-solid fa-phone"></i></a>
                                      <% } %>
                                  </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Order</strong></strong></td>
                        <td>
                            <table>
                                <tr>
                                    <td><strong>Order ID</strong></strong></td>
                                    <td><%=replyReview.getOrderId().getOrderId()%></td>
                                </tr>
                                <tr>
                                    <td><strong>Shipping Address</strong></strong></td>
                                    <td><%=replyReview.getOrderId().getOrderShippingAddress()%></td>
                                </tr>
                                <tr>
                                    <td><strong>Status</strong></strong></td>
                                    <td><%=replyReview.getOrderId().getOrderStatus()%></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Score</strong></strong></td>
                        <td><%=replyReview.getReviewScore()%></td>
                    </tr>
                    <tr>
                        <td><strong>Description</strong></strong></td>
                        <td><%=replyReview.getReviewDescription()%></td>
                    </tr>
                    <%
                        String replyMsg ="";
                        if(request.getAttribute("replyMsg")!=null){
                            replyMsg = (String)request.getAttribute("replyMsg");
                            request.removeAttribute("replyMsg");
                        }
                    %>
                    <tr>
                        <td><strong>Reply Message</strong></strong></td>
                        <td><input type="text" name="edit_replyMsg" id="edit_replyMsg" value="<%=replyMsg%>" disabled></td>
                    </tr>
                </table>

            <div class="edit-action hide">
                <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this order?')) { return true; }else{return false;}">Save</button>
            </div>
        </form>
                    
        <div class="edit-action hide">
                <button class="replyReviewBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadReview"%>'" style="float: left;">Back</button>
                <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this reivew?')) { return true; }else{return false;}">Save</button>
        </div>
        <!--End Edit Order Form-->
            
        <div class="detail-action">
            <button class="editReviewBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadReview"%>'" style="float: left;">Back</button>
            <button class="editBtn btn success">Edit</button>
            <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this review?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteReview?deleteId="+replyReview.getReviewId()%>'; }else{return false;}">Delete</button>
        </div>

    </div>
    <% } %>
    
        </div>
    </div>
    
        
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
                document.getElementById('edit_replyMsg').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>