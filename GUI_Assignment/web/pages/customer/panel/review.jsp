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
    
    //Redirect to home page if it's not customer
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 2){
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
    body.querySelector(".nav-link.review").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/customer/panel/review.css"%>">

<main>
    <% 
        //Start Display Cstomer List
        if(reviewList != null){ 
    %>  
        <div class="reviewList container">
            <div class="text">
                <h1>Review List </h1>
                <% //Display search value when searching
                    if(searchValue!=null){
                        out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/customer/panel/LoadReview'>Reset</a>)</h3>");
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
                  const url = "<%=ROOT_PATH+"pages/customer/panel/LoadReview/search/"%>" + searchValue;
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
                            if(prodDetails.length() > 15){
                                prodDetails = prodDetails.substring(0, 15)+"...";
                            }
                            prodDetails = r.getProdId().getProdId() + " - " + prodDetails;
                            
                            //Description
                            String description = r.getReviewDescription();
                            if(description.length() > 20){
                                description = description.substring(0, 20)+"...";
                            }
                            
                            //Replied this review or not
                            String replyDetail = "null";
                            if(r.getReviewReply() != null){
                                replyDetail = "<i class='fa-solid fa-check replyIconSuccess'></i>";
                            }else{
                                replyDetail = "<i class='fa-solid fa-xmark replyIconDanger'></i>";
                            }
                    %>
                    <tr>
                        <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                        <td><%=r.getReviewId()%></td>
                        <td><%=r.getOrderId().getOrderId()%></td>
                        <td><%=prodDetails%></td>
                        <td><%=r.getReviewScore()%></td>
                        <td><%=description%></td>
                        <td><%=replyDetail%></td>
                        <td>
                            <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/customer/panel/LoadReview/reviewDetail/"+r.getReviewId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
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
        <div class="replyReview container">
            <div class="text">
                <h1>Reply Review</h1>
            </div>

    <!-- Start Review Detail-->
        <input type="hidden" name="reply_Id" id="reply_Id" value="<%=replyReview.getReviewId()%>">
        <table class="table vertical-table">
            <tr>
                <td><strong>ID </strong></td>
                <td><%=replyReview.getReviewId()%></td>
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
                <td><strong>Product</strong></strong></td>
                <td>
                    <table>
                        <tr>
                            <td><strong>Product ID</strong></strong></td>
                            <td><%=replyReview.getProdId().getProdId()%></td>
                        </tr>
                        <tr>
                            <td><strong>Product Name</strong></strong></td>
                            <td><%=replyReview.getProdId().getProdName()%></td>
                        </tr>
                        <tr>
                            <td><strong>Product Type</strong></strong></td>
                            <td><%=replyReview.getProdId().getProdType()%></td>
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
                String replyMsg =" - ";
                if(request.getAttribute("replyMsg")!=null){
                    replyMsg = (String)request.getAttribute("replyMsg");
                    request.removeAttribute("replyMsg");
                }
            %>
            <tr>
                <td><strong>Reply Message from Staff</strong></strong></td>
                <td><%=replyMsg%></td>
            </tr>
        </table>
            
        <div class="detail-action">
            <button class="reviewDetailBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/customer/panel/LoadReview"%>'">Back</button>
        </div>
    </div>
    <% } %>
    
        </div>
    </div>
</main>
</body>
</html>