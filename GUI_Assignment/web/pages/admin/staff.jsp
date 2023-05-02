<%@page import="entity.Admin"%>
<%@page import="java.util.List"%>
<%@page import="entity.Customer"%>

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
    if(validatePermission == 999 || validatePermission != 0){
        response.sendRedirect(ROOT_PATH+"index.jsp");
    }
    
    //Get variable from Query String
    boolean addNewAction = request.getParameter("addNewAction") != null ? true : false;
    
    //Get staffs information from controller (LoadStaff.jsp)
    //Declare variable
    List<Admin> staffList=null;
    Admin editStaff=null;
    
    if(!addNewAction){
        //Staff List
        staffList = (List<Admin>) request.getAttribute("staffList") != null ? (List<Admin>) request.getAttribute("staffList") : null;
        //Edit Staff
        editStaff = (Admin) request.getAttribute("editStaff") != null ? (Admin) request.getAttribute("editStaff") : null;
    }
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.staff").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/staff.css"%>">

<main>
    <% 
        //Start Display Cstomer List
        if(staffList != null){ 
    %>
    <div class="container staffList">
        <div class="text">
            <h1>Staff List</h1>
            <% //Display search value when searching
                if(searchValue!=null){
                        out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/admin/LoadStaff'>Reset</a>)</h3>");
                }
            %>
            <p><%=staffList.size()%> record(s) found</p>
        </div>
        <button class="addNew btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadStaff?addNewAction=true"%>'">Add New</button>
        <div class="searchBar">
            <input id="searchInput" type="search" placeholder="Search ..." required>
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
            <button type="button" <%=validateFilter("all", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadStaff"%>'">All</button>
            <button type="button" <%=validateFilter("ADMIN", filter)%> value="ADMIN" onclick="filterOrders('ADMIN')">Admin</button>
            <button type="button" <%=validateFilter("STAFF", filter)%> value="STAFF" onclick="filterOrders('STAFF')">Staff</button>
        </div>

        <script>
            const filterOrders = (status) => {
              const url = "<%=ROOT_PATH+"pages/admin/LoadStaff/filter/"%>" + status;
              window.location.href = url;
            };
            
            const searchBtn = document.querySelector('#searchBtn');
            const searchInput = document.querySelector('#searchInput');

            searchBtn.addEventListener('click', (event) => {
              event.preventDefault();
              const searchValue = searchInput.value;
              const url = "<%=ROOT_PATH+"pages/admin/LoadStaff/search/"%>" + searchValue;
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
        <%} if(staffList.size() > 0){%>

        <table class="table horizontal-table">
            <thead>
                <tr>
                    <th><i class="fa-solid fa-hashtag"></i></th>
                    <th>ID</th>
                    <th>User Name</th>
                    <th>Full Name</th>
                    <th>Contact</th>
                    <th>Position</th>
                    <th>Permission</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(int i=0; i<staffList.size();i++){
                        Admin a = staffList.get(i);
                        //Handle long string
                        String username = a.getUserId().getUserName();
                        if(username == null){
                            username = "&#8212;";
                        }
                        if(username.length() > 10){
                            username = username.substring(0, 10)+"...";
                        }
                        
                        String fullname = a.getAdminFullName();
                        if(fullname.length() > 20){
                            fullname = fullname.substring(0, 20)+"...";
                        }

                        String position = a.getAdminPosition();
                        if(position.length() > 20){
                            position = position.substring(0, 20)+"...";
                        }
                        
                        int permission = a.getAdminPermission();
                        String permissionStr = "";
                        if(permission == 0){
                            permissionStr = "ADMIN";
                        }
                        if(permission == 1){
                            permissionStr = "STAFF";
                        }
                %>
                <tr>
                    <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                    <td><%=a.getUserId().getUserId()%></td>
                    <td><%=username%></td>
                    <td><%=fullname%></td>
                    <td>
                        <% if(a.getUserId().getUserEmail() != null){%>
                            <button class="actionRoundBtn contact" onclick="location.href='mailto:<%=a.getUserId().getUserEmail()%>'"><i class="fa-solid fa-envelope"></i></button>
                        <%}if(a.getAdminPhoneNum()!= null){ %>
                            <button class="actionRoundBtn contact" onclick="location.href='tel:<%=a.getAdminPhoneNum()%>'"><i class="fa-solid fa-phone"></i></button>
                        <% } %>
                    </td>
                    <td><%=position%></td>
                    <td><%=permissionStr%></td>
                    <td>
                        <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadStaff/editStaffID/"+a.getAdminId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                        <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this staff?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteStaff?deleteId="+a.getAdminId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } //End if (if staff size >= 0)%> 
    </div>
    <% } 
        //Start Add New Staff
        else if(addNewAction){
    %>
    <div class="container addStaff ">
        <div class="text">
            <h1>Add Staff</h1>
        </div>

        <form action="<%=ROOT_PATH+"pages/admin/AddNewStaff" %>" method="POST">
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
                    <td><strong>Position</strong></td>
                    <td><input type="text" name="addNew_position"></td>
                </tr>
                <tr>
                    <td><strong>Permission</strong></td>
                    <td> 
                        <select name="addNew_permission">
                            <option value="">Please Select</option>
                            <option value="0">Administrator</option>
                            <option value="1">Staff</option>
                        </select>
                    </td>
                </tr>
            </table>

            <div class="addNew-action">
                <button type="button" class="editCustBackBtn backBtn btn" onclick="if(confirm('Are you sure you want to go back?')) { location.href='<%=ROOT_PATH+"pages/admin/LoadStaff" %>'; } else { return false; }" style="float: left;">Back</button>
                <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to add new staff?')) { return true; } else { return false; }">Submit</button>
                <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }">Reset</button>
            </div>
        </form>
    </div>

    <%
        //Start Edit Staff
        }else if(editStaff != null){
    %>
    <div class="container staffDetail">
        <div class="text">
            <h1>Staff Detail</h1>
            <p><strong>ID <%=editStaff.getAdminId()%> - <%=editStaff.getAdminFullName()%></strong></p>
        </div>

        <!-- Start Edit Staff Form-->
        <form action="<%=ROOT_PATH+"pages/admin/UpdateStaff" %>" method="POST">
            <table class="table vertical-table">
                <tr>
                    <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                    <td><input type="text" value="<%=editStaff.getAdminId()%>" disabled></td>
                    <input type="hidden" name="edit_Id" id="edit_Id" value="<%=editStaff.getAdminId()%>">
                </tr>
                <tr>
                    <td><strong>User Name</strong></strong></td>
                    <td><input type="text" name="edit_userName" id="edit_userName" value="<%=editStaff.getUserId().getUserName()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Full Name</strong></strong></td>
                    <td><input type="text" name="edit_fullName" id="edit_fullName" value="<%=editStaff.getAdminFullName()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Phone Number</strong></td>
                    <td><input type="text" name="edit_phoneNum" id="edit_phoneNum" value="<%=editStaff.getAdminPhoneNum()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Email</strong></td>
                    <td><input type="text" name="edit_email" id="edit_email" value="<%=editStaff.getUserId().getUserEmail()%>" disabled></td>
                </tr>
                <tr>
                    <td><strong>Position</strong></td>
                    <td><input type="text" name="edit_position" id="edit_position" value="<%=editStaff.getAdminPosition()%>" disabled></td>
                </tr>
                <%!
                    private String validatePermission(int type, int value) {
                        if (type == value) return "selected=\"selected\"";
                        return "";
                    }
                %>
                <tr>
                    <td><strong>Permission</strong></td>
                    <td> 
                        <select name="edit_permission" id="edit_permission" disabled>
                            <option value="">Please Select</option>
                            <option value="0" <%=validatePermission(0, editStaff.getAdminPermission())%>>Administrator</option>
                            <option value="1" <%=validatePermission(1, editStaff.getAdminPermission())%>>Staff</option>
                        </select>
                    </td>
                </tr>
            </table>

            <div class="edit-action hide">
                <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this staff?')) { return true; }else{return false;}">Save</button>
            </div>
        </form>
        <!--End Edit Staff Form-->
            
        <div class="detail-action">
            <button class="editCustBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadStaff"%>'" style="float: left;">Back</button>
            <button class="editBtn btn success">Edit</button>
            <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this staff?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteStaff?deleteId="+editStaff.getAdminId()%>'; }else{return false;}">Delete</button>
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
                document.getElementById('edit_position').removeAttribute("disabled");
                document.getElementById('edit_permission').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>