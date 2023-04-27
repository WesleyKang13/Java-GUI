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
    
    //Get inventorys information from controller (LoadInventory.jsp)
    //Declare variable
    List<Inventory> inventoryList = null;
    Inventory editInventory= null;
    
    //Get variable from Query String
    boolean addNewAction = request.getParameter("addNewAction") != null ? true : false;
    
    if(!addNewAction){
        //Inventory List
        inventoryList=(List<Inventory>) request.getAttribute("inventoryList") != null ? (List<Inventory>) request.getAttribute("inventoryList") : null;
        //Edit Product
        editInventory=(Inventory) request.getAttribute("editInventory") != null ? (Inventory) request.getAttribute("editInventory") : null;
    }
    
%>

<!-- Include Header -->
<jsp:include page="sidebar.jsp">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.product").classList.add("active");
</script>

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/inventory.css"%>">

<main>
    
    <div class="groupTabs">
        
        <input type="radio" id="product" name="tab">
        <label for="product" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadProduct"%>'">Product</label>
        
    
        <input type="radio" id="inventory" name="tab" checked="checked">
        <label for="inventory" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadInventory"%>'">Inventory</label>
        <div class="container inventoryList tab">
    <% 
        //Start Display Cstomer List
        if(inventoryList != null){ 
    %>  
        <div class="inventoryList">
            <div class="text">
                <h1>Inventory List </h1>
                <% //Display search value when searching
                    if(searchValue!=null){
                        out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/admin/LoadInventory'>Reset</a>)</h3>");
                    }
                %>
                <%!
                    private String maintainSearchBarValue(String searchValue){
                        if(searchValue != null) return "value='"+searchValue+"'"; 
                        return "";
                    }
                %>
                <p><%=inventoryList.size()%> record(s) found</p>
            </div>

            <button class="addNew btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadInventory?addNewAction=true"%>'">Add New</button>
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
                  const url = "<%=ROOT_PATH+"pages/admin/LoadInventory/search/"%>" + searchValue;
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
            <% }if(inventoryList.size() > 0){ %>

            <table class="table horizontal-table">
                <thead>
                    <tr>
                        <th><i class="fa-solid fa-hashtag" ></i></th>
                        <th>ID</th>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th>Color</th>
                        <th>Size</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for(int i=0; i<inventoryList.size();i++){
                            Inventory inv = inventoryList.get(i);

                            
                            String prodName = inv.getProdId().getProdName();
                            if(prodName.length() > 15){
                                prodName = prodName.substring(0, 15)+"...";
                            }
                    %>
                    <tr>
                        <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                        <td><%=inv.getInvId()%></td>
                        <td><%=inv.getProdId().getProdId()+" - "+prodName%></td>
                        <td><%=inv.getInvQuantity()%></td>
                        <td><%=inv.getInvColor()%></td>
                        <td><%=inv.getInvShoeSize()%></td>
                        <td>
                            <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadInventory/editInventoryID/"+inv.getInvId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                            <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this inventory?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteInventory?deleteId="+inv.getInvId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } //End if (if inventory size >= 0)%> 
        </div>


        <% } 
            //Start Add New Inventory
            else if(addNewAction){
        %>

        <div class="addInventory">
            <div class="text">
                <h1>Add Inventory</h1>
            </div>

            <div class="notificationBox success">
                <span class="message">Record Deleted Successfully !</span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>

            <div class="notificationBox error">
                <span class="message">Error Occurred, Please Try Again !</span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>

            <form action="<%=ROOT_PATH+"pages/admin/AddNewInventory" %>" method="POST">
                <table class="table vertical-table">
                    <tr>
                        <td><strong>Product</strong></strong></td>
                        <td>
                            <select name="addNew_prodId" id="addNew_prodId">
                                <option value="#">Please Select</option>
                                <%
                                    List<Product> productList=(List<Product>) request.getAttribute("productList") != null ? (List<Product>) request.getAttribute("productList") : null;

                                    for(Product p: productList){
                                        out.print("<option value="+p.getProdId()+">ID "+p.getProdId()+" - "+p.getProdName()+"</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Quantity</strong></strong></td>
                        <td><input type="text" name="addNew_invQuantity" id="addNew_invQuantity"></td>
                    </tr>
                    <tr>
                        <td><strong>Color</strong></strong></td>
                        <td><input type="text" name="addNew_invColor" id="addNew_invColor"></td>
                    </tr>
                    <tr>
                        <td><strong>Size</strong></strong></td>
                        <td><input type="text" name="addNew_invSize" id="addNew_invSize"></td>
                    </tr>
                </table>

                <div class="addNew-action">
                    <button type="button" class="editCustBackBtn backBtn btn" onclick="if(confirm('Are you sure you want to go back?')) { location.href='<%=ROOT_PATH+"pages/admin/LoadInventory" %>'; } else { return false; }" style="float: left;">Back</button>
                    <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to add new customer?')) { return true; } else { return false; }">Submit</button>
                    <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }">Reset</button>
                </div>
            </form>
        </div>


        <% 
            //Start Edit Inventory
            }else if(editInventory != null){
                    
                    
        %>
        <div class="inventoryDetail">
            <div class="text">
                <h1>Inventory Detail</h1>
                <p><strong>ID - <%=editInventory.getInvId()+" by Product ID "+editInventory.getProdId().getProdId()+" ("+editInventory.getProdId().getProdName()+")"%></strong></p>
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

            <!-- Start Edit Inventory Form-->
            <form action="<%=ROOT_PATH+"pages/admin/UpdateInventory" %>" method="POST">
                <input type="hidden" name="edit_Id" id="edit_Id" value="<%=editInventory.getInvId()%>">
                <table class="table vertical-table">
                    <tr>
                        <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                        <td><input type="text" value="<%=editInventory.getInvId()%>" disabled></td>
                    </tr>
                    
                    <%!
                        private String validateProduct(int type, int value) {
                            if (type == value) return "selected=\"selected\"";
                            return "";
                        }
                    %>
                    <tr>
                        <td><strong>Product</strong></strong></td>
                        <td>
                            <select name="edit_invProduct" id="edit_invProduct" disabled>
                                <%
                                    List<Product> productList=(List<Product>) request.getAttribute("productList") != null ? (List<Product>) request.getAttribute("productList") : null;

                                    for(Product p: productList){
                                        out.print("<option value='"+p.getProdId()+"' "+validateProduct(p.getProdId(), editInventory.getProdId().getProdId())+" "+">ID "+p.getProdId()+" - "+p.getProdName()+"</option>");
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Quantity</strong></strong></td>
                        <td><input type="text" name="edit_invQuantity" id="edit_invQuantity" value="<%=editInventory.getInvQuantity()%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Color</strong></strong></td>
                        <td><input type="text" name="edit_invColor" id="edit_invColor" value="<%=editInventory.getInvColor()%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Size</strong></strong></td>
                        <td><input type="text" name="edit_invSize" id="edit_invSize" value="<%=editInventory.getInvShoeSize()%>" disabled></td>
                    </tr>
                </table>

                <div class="edit-action hide">
                    <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                    <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this inventory?')) { return true; }else{return false;}">Save</button>
                </div>
            </form>
            <!--End Edit Inventory Form-->

            <div class="detail-action">
                <button class="editInventoryBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadInventory"%>'" style="float: left;">Back</button>
                <button class="editBtn btn success">Edit</button>
                <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this inventory?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteInventory?deleteId="+editInventory.getProdId()%>'; }else{return false;}">Delete</button>
            </div>
        </div>
    <% } %>
    
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
                document.getElementById('edit_invProduct').removeAttribute("disabled");
                document.getElementById('edit_invQuantity').removeAttribute("disabled");
                document.getElementById('edit_invColor').removeAttribute("disabled");
                document.getElementById('edit_invSize').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>