<%@page import="java.util.List"%>
<%@page import="entity.Customer"%>

<% 
    //Get notification from controllers
    String successMsg = request.getParameter("successMsg") != null ? (String) request.getParameter("successMsg") : null;
    String errorMsg = request.getParameter("errorMsg") != null ? (String)request.getParameter("errorMsg") : null;
    String searchValue = request.getAttribute("searchValue") != null ? (String)request.getAttribute("searchValue") : null;
    request.removeAttribute("searchValue");
    
    //Get root path (from controller)
    String ROOT_PATH = (String) request.getAttribute("ROOT_PATH");
    
    //Get variable from Query String
    boolean addNewAction = request.getParameter("addNewAction") != null ? true : false;
    
    //Get customers information from controller (LoadCustomer.jsp)
    //Declare variable
    List<Customer> customerList=null;
    Customer editCustomer=null;
    
    if(!addNewAction){
        //Customer List
        customerList = (List<Customer>) request.getAttribute("customerList") != null ? (List<Customer>) request.getAttribute("customerList") : null;
        //Edit Customer
        editCustomer = (Customer) request.getAttribute("editCustomer") != null ? (Customer) request.getAttribute("editCustomer") : null;
    }
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.customer").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/customer.css"%>">

<main>
    <% 
        //Start Display Cstomer List
        if(customerList != null){ 
    %>
    <div class="container customerList">
        <div class="text">
            <h1>Customer List</h1>
            <% //Display search value when searching
                if(searchValue!=null){
                    out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+"</h3>");
                    out.print("<a href='"+ROOT_PATH+"pages/admin/LoadCustomer'>Reset</a>");
                }
            %>
            <p><%=customerList.size()%> record(s) found</p>
        </div>
        <button class="addNew btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadCustomer?addNewAction=true"%>'">Add New</button>
        <div class="searchBar">
            <input id="searchInput" type="search" placeholder="Search ..." required>
            <a id="searchBtn" href="#"><i class='fa-solid fa-magnifying-glass fa-bounce'></i></a>
        </div>

        <script>
            const searchBtn = document.querySelector('#searchBtn');
            const searchInput = document.querySelector('#searchInput');

            searchBtn.addEventListener('click', (event) => {
              event.preventDefault();
              const searchValue = searchInput.value;
              const url = "<%=ROOT_PATH+"pages/admin/LoadCustomer/search/"%>" + searchValue;
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
        <%} if(customerList.size() > 0){%>

        <table class="table horizontal-table">
            <thead>
                <tr>
                    <th><i class="fa-solid fa-hashtag"></i></th>
                    <th>ID</th>
                    <th>User Name</th>
                    <th>Full Name</th>
                    <th>Contact</th>
                    <th>Shipping Address</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(int i=0; i<customerList.size();i++){
                        Customer c = customerList.get(i);
                        //Handle long string
                        String username = c.getUserId().getUserName();
                        if(username == null){
                            username = "&#8212;";
                        }
                        if(username.length() > 10){
                            username = username.substring(0, 10)+"...";
                        }
                        
                        String fullname = c.getCustFullName();
                        if(fullname.length() > 20){
                            fullname = fullname.substring(0, 20)+"...";
                        }

                        String shippingAddress = c.getCustShippingAddress();
                        if(shippingAddress.length() > 20){
                            shippingAddress = shippingAddress.substring(0, 20)+"...";
                        }
                %>
                <tr>
                    <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                    <td><%=c.getCustId()%></td>
                    <td><%=username%></td>
                    <td><%=fullname%></td>
                    <td>
                        <% if(c.getUserId().getUserEmail() != null){%>
                            <button class="actionRoundBtn contact" onclick="location.href='mailto:<%=c.getUserId().getUserEmail()%>'"><i class="fa-solid fa-envelope"></i></button>
                        <%}if(c.getCustPhoneNum() != null){ %>
                            <button class="actionRoundBtn contact" onclick="location.href='tel:<%=c.getCustPhoneNum()%>'"><i class="fa-solid fa-phone"></i></button>
                        <% } %>
                    </td>
                    <td><%=shippingAddress%></td>
                    <td>
                        <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadCustomer/editCustID/"+c.getCustId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                        <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this customer?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteCustomer?deleteId="+c.getCustId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } //End if (if customer size >= 0)%> 
    </div>
    <% } 
        //Start Add New Customer
        else if(addNewAction){
    %>
    <div class="container addCustomer ">
        <div class="text">
            <h1>Add Customer</h1>
        </div>

        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Occurred, Please Try Again !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <form action="<%=ROOT_PATH+"pages/admin/AddNewCustomer" %>" method="POST">
            <table class="table vertical-table">
                <tr>
                    <td><strong>User Name</strong></td>
                    <td><input type="text" name="addNew_userName"></td>
                </tr>
                <tr>
                    <td><strong>Password</strong></td>
                    <td><input type="password" name="addNew_password"></td>
                </tr>
                <tr>
                    <td><strong>Confirm Password</strong></td>
                    <td><input type="password" name="addNew_confirmPassword"></td>
                </tr>
                <tr>
                    <td><strong>Full Name</strong></td>
                    <td><input type="text" name="addNew_fullName"></td>
                </tr>
                <tr>
                    <td><strong>Phone Number</strong></td>
                    <td><input type="text" name="addNew_phoneNum"></td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><input type="email" name="addNew_email"></td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><input type="text" name="addNew_shippingAddress"></td>
                </tr>
            </table>

            <div class="addNew-action">
                <button type="button" class="editCustBackBtn backBtn btn" onclick="if(confirm('Are you sure you want to go back?')) { location.href='<%=ROOT_PATH+"pages/admin/LoadCustomer" %>'; } else { return false; }" style="float: left;">Back</button>
                <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to add new customer?')) { return true; } else { return false; }">Submit</button>
                <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }">Reset</button>
            </div>
        </form>
    </div>

    <%
        //Start Edit Customer
        }else if(editCustomer != null){
    %>
    <div class="container customerDetail">
        <div class="text">
            <h1>Customer Detail</h1>
            <p><strong>ID <%=editCustomer.getCustId()%> - <%=editCustomer.getCustFullName()%></strong></p>
        </div>

        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Message</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <!-- Start Edit Customer Form-->
        <form action="<%=ROOT_PATH+"pages/admin/UpdateCustomer" %>" method="POST">
            <table class="table vertical-table">
                <tr>
                    <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                    <td><input type="text" value="<%=editCustomer.getCustId()%>" disabled></td>
                    <input type="hidden" name="edit_Id" id="edit_Id" value="<%=editCustomer.getCustId()%>">
                </tr>
                <tr>
                    <td><strong>User Name</strong></strong></td>
                    <td><input type="text" name="edit_userName" id="edit_userName" value="<%=editCustomer.getUserId().getUserName()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Full Name</strong></strong></td>
                    <td><input type="text" name="edit_fullName" id="edit_fullName" value="<%=editCustomer.getCustFullName()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Phone Number</strong></td>
                    <td><input type="text" name="edit_phoneNum" id="edit_phoneNum" value="<%=editCustomer.getCustPhoneNum()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><input type="text" name="edit_email" id="edit_email" value="<%=editCustomer.getUserId().getUserEmail()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Shipping Address</strong></td>
                    <td><input type="text" name="edit_shippingAddress" id="edit_shippingAddress" value="<%=editCustomer.getCustShippingAddress()%>" disabled></td>
                </tr>
            </table>

            <div class="edit-action hide">
                <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this customer?')) { return true; }else{return false;}">Save</button>
            </div>
        </form>
        <!--End Edit Customer Form-->
            
        <div class="detail-action">
            <button class="editCustBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadCustomer"%>'" style="float: left;">Back</button>
            <button class="editBtn btn success">Edit</button>
            <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this customer?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteCustomer?deleteId="+editCustomer.getCustId()%>'; }else{return false;}">Delete</button>
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
                document.getElementById('edit_userName').removeAttribute("disabled");
                document.getElementById('edit_fullName').removeAttribute("disabled");
                document.getElementById('edit_phoneNum').removeAttribute("disabled");
                document.getElementById('edit_email').removeAttribute("disabled");
                document.getElementById('edit_shippingAddress').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>