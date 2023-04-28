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
    String filter = request.getAttribute("filter") != null ? (String)request.getAttribute("filter") : null;
    request.removeAttribute("filter");
    
    //Get root path (from controller)
    String ROOT_PATH = (String) request.getAttribute("ROOT_PATH");
    
    //Redirect to home page if it's not admin
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 0 && validatePermission != 1){
        System.out.println("helllllllo");
        response.sendRedirect(ROOT_PATH+"index.html");
    }
    
    //Get products information from controller (LoadProduct.jsp)
    //Declare variable
    List<Product> productList = null;
    Product editProduct= null;
    
    //Get variable from Query String
    boolean addNewAction = request.getParameter("addNewAction") != null ? true : false;
    
    if(!addNewAction){
        //Product List
        productList=(List<Product>) request.getAttribute("productList") != null ? (List<Product>) request.getAttribute("productList") : null;
        //Edit Product
        editProduct=(Product) request.getAttribute("editProduct") != null ? (Product) request.getAttribute("editProduct") : null;
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

<link rel="stylesheet" href="<%=ROOT_PATH+"css/admin/product.css"%>">

<main>
    
    <div class="groupTabs">
        
        <input type="radio" id="product" name="tab" checked="checked">
        <label for="product" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadProduct"%>'">Product</label>
        <div class="container productList tab">
    <% 
        //Start Display Cstomer List
        if(productList != null){ 
    %>  
        <div class="productList">
            <div class="text">
                <h1>Product List </h1>
                <% //Display search value when searching
                    if(searchValue!=null){
                        out.print("<h3 style='padding-bottom:0.4rem;'>Searching - "+searchValue+" (<a href='"+ROOT_PATH+"pages/admin/LoadProduct'>Reset</a>)</h3>");
                    }
                %>
                <%!
                    private String maintainSearchBarValue(String searchValue){
                        if(searchValue != null) return "value='"+searchValue+"'"; 
                        return "";
                    }
                %>
                <p><%=productList.size()%> record(s) found</p>
            </div>

            <button class="addNew btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadProduct?addNewAction=true"%>'">Add New</button>
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
                <button type="button" <%=validateFilter("all", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadProduct"%>'">All</button>
                <button type="button" <%=validateFilter("MEN", filter)%> value="MEN" onclick="filterProducts('MEN')">Men</button>
                <button type="button" <%=validateFilter("WOMEN", filter)%> value="WOMEN" onclick="filterProducts('WOMEN')">Women</button>
                <button type="button" <%=validateFilter("KIDS", filter)%> value="KIDS" onclick="filterProducts('KIDS')">Kids</button>
                <button type="button" <%=validateFilter("COUPLE", filter)%> value="COUPLE" onclick="filterProducts('COUPLE')">Couple</button>
                <button type="button" <%=validateFilter("FAMILY", filter)%> value="FAMILY" onclick="filterProducts('FAMILY')">Family</button>
            </div>

            <script>
                const filterProducts = (type) => {
                  const url = "<%=ROOT_PATH+"pages/admin/LoadProduct/filter/"%>" + type;
                  window.location.href = url;
                };

                const searchBtn = document.querySelector('#searchBtn');
                const searchInput = document.querySelector('#searchInput');

                searchBtn.addEventListener('click', (event) => {
                  event.preventDefault();
                  const searchValue = searchInput.value;
                  const url = "<%=ROOT_PATH+"pages/admin/LoadProduct/search/"%>" + searchValue;
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
            <% }if(productList.size() > 0){ %>

            <table class="table horizontal-table">
                <thead>
                    <tr>
                        <th><i class="fa-solid fa-hashtag" ></i></th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Price (RM)</th>
                        <th>Description</th>
                        <th>Type</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for(int i=0; i<productList.size();i++){
                            Product p = productList.get(i);

                            String desciption = p.getProdDescription();
                            if(desciption.length() > 20){
                                desciption = desciption.substring(0, 20)+"...";
                            }

                            String prodName = p.getProdName();
                            if(prodName.length() > 15){
                                prodName = prodName.substring(0, 15)+"...";
                            }
                    %>
                    <tr>
                        <td style="font-weight:600;width:0rem;"><%=i+1%></td>
                        <td><%=p.getProdId()%></td>
                        <td><%=prodName%></td>
                        <td><%=p.getProdBrand()%></td>
                        <td><%=String.format("%.2f",p.getProdPrice())%></td>
                        <td><%=desciption%></td>
                        <td><%=p.getProdType()%></td>
                        <td>
                            <button class="actionRoundBtn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadProduct/editProductID/"+p.getProdId()%>'"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                            <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this product?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteProduct?deleteId="+p.getProdId()%>'; }else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } //End if (if product size >= 0)%> 
        </div>


        <% } 
            //Start Add New Product
            else if(addNewAction){
        %>

        <div class="addProduct">
            <div class="text">
                <h1>Add Product</h1>
            </div>

            <div class="notificationBox success">
                <span class="message">Record Deleted Successfully !</span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>

            <div class="notificationBox error">
                <span class="message">Error Occurred, Please Try Again !</span>
                <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
            </div>

            <form action="<%=ROOT_PATH+"pages/admin/AddNewProduct" %>" method="POST">
                <table class="table vertical-table">
                    <tr>
                        <td><strong>Name</strong></strong></td>
                        <td><input type="text" name="addNew_prodName" id="addNew_prodName"></td>
                    </tr>
                    <tr>
                        <td><strong>Brand</strong></strong></td>
                        <td><input type="text" name="addNew_prodBrand" id="addNew_prodBrand"></td>
                    </tr>
                    <tr>
                        <td><strong>Price (RM)</strong></strong></td>
                        <td><input type="text" name="addNew_prodPrice" id="addNew_prodPrice"></td>
                    </tr>
                    <tr>
                        <td><strong>Description</strong></strong></td>
                        <td><input type="text" name="addNew_prodDesc" id="addNew_prodDesc"></td>
                    </tr>
                    <tr>
                        <td><strong>Type</strong></strong></td>
                        <td>
                            <select name="addNew_type" id="addNew_type">
                                <option value="#" >PLEASE SELECT</option>
                                <option value="MEN" >MEN</option>
                                <option value="WOMEN" >WOMEN</option>
                                <option value="KIDS" >KIDS</option>
                                <option value="COUPLE" >COUPLE</option>
                                <option value="FAMILY" >FAMILY</option>
                            </select>
                        </td>
                    </tr>
                </table>

                <div class="addNew-action">
                    <button type="button" class="editCustBackBtn backBtn btn" onclick="if(confirm('Are you sure you want to go back?')) { location.href='<%=ROOT_PATH+"pages/admin/LoadProduct" %>'; } else { return false; }" style="float: left;">Back</button>
                    <button type="submit" class="submitBtn btn success" onclick="if(confirm('Are you sure you want to add new product?')) { return true; } else { return false; }">Submit</button>
                    <button type="reset" class="resetBtn btn danger" onclick="if(confirm('Are you sure you want to reset the form?')) { this.form.reset(); } else { return false; }">Reset</button>
                </div>
            </form>
        </div>


        <% 
            //Start Edit Product
            }else if(editProduct != null){
        %>
        <div class="productDetail">
            <div class="text">
                <h1>Product Detail</h1>
                <p><strong>ID - <%=editProduct.getProdId()+" ("+editProduct.getProdName()+")"%></strong></p>
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

            <!-- Start Edit Product Form-->
            <form action="<%=ROOT_PATH+"pages/admin/UpdateProduct" %>" method="POST">
                <input type="hidden" name="edit_Id" id="edit_Id" value="<%=editProduct.getProdId()%>">
                <table class="table vertical-table">
                    <tr>
                        <td><strong>ID </strong><small>(*ID can't be modified)</small></td>
                        <td><input type="text" value="<%=editProduct.getProdId()%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Name</strong></strong></td>
                        <td><input type="text" name="edit_prodName" id="edit_prodName" value="<%=editProduct.getProdName()%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Brand</strong></strong></td>
                        <td><input type="text" name="edit_prodBrand" id="edit_prodBrand" value="<%=editProduct.getProdBrand()%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Price (RM)</strong></strong></td>
                        <td><input type="text" name="edit_prodPrice" id="edit_prodPrice" value="<%=String.format("%.2f",editProduct.getProdPrice())%>" disabled></td>
                    </tr>
                    <tr>
                        <td><strong>Description</strong></strong></td>
                        <td><input type="text" name="edit_prodDesc" id="edit_prodDesc" value="<%=editProduct.getProdDescription()%>" disabled></td>
                    </tr>
                    <%!
                        private String validateType(String type, String value) {
                            if (type.equals(value)) return "selected=\"selected\"";
                            return "";
                        }
                    %>
                    <tr>
                        <td><strong>Type</strong></strong></td>
                        <td>
                            <select name="edit_type" id="edit_type" disabled>
                                <option value="MEN" <%=validateType("MEN", editProduct.getProdType())%>>MEN</option>
                                <option value="WOMEN" <%=validateType("WOMEN", editProduct.getProdType())%>>WOMEN</option>
                                <option value="KIDS" <%=validateType("KIDS", editProduct.getProdType())%>>KIDS</option>
                                <option value="COUPLE" <%=validateType("COUPLE", editProduct.getProdType())%>>COUPLE</option>
                                <option value="FAMILY" <%=validateType("FAMILY", editProduct.getProdType())%>>FAMILY</option>
                            </select>
                        </td>
                    </tr>
                    <%
                        List<Inventory> editInvList=(List<Inventory>) request.getAttribute("inventoryList") != null ? (List<Inventory>) request.getAttribute("inventoryList") : null;
                        if(editInvList!=null){
                            for(int i=0;i<editInvList.size();i++){
                                Inventory inv = editInvList.get(i);
                    %>
                    <tr>
                        <td><strong>Inventory <%=i+1%></strong></strong></td>
                        <td style="padding:1rem 8vw;">
                            <table>
                                <tr>
                                  <td><strong>Inv ID</strong></td>
                                  <td><%=inv.getInvId()%></td>
                                </tr>
                                <tr>
                                  <td><strong>Quantity</strong></td>
                                  <td><%=inv.getInvQuantity()%></td>
                                </tr>
                                <tr>
                                  <td><strong>Color</strong></td>
                                  <td><%=inv.getInvColor()%></td>
                                </tr>
                                <tr>
                                  <td><strong>Shoe Size</strong></td>
                                  <td><%=inv.getInvShoeSize()%></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%}}%>
                </table>

                <div class="edit-action hide">
                    <button type="button" class="delete btn danger" onclick="if(confirm('Are you sure you want to cancel?')) { history.go(0); }" style="float: left;">Cancel</button>
                    <button type="submit" class="edit btn success" onclick="if(confirm('Are you sure you want to edit this product?')) { return true; }else{return false;}">Save</button>
                </div>
            </form>
            <!--End Edit Product Form-->

            <div class="detail-action">
                <button class="editProductBackBtn backBtn btn" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadProduct"%>'" style="float: left;">Back</button>
                <button class="editBtn btn success">Edit</button>
                <button class="deleteBtn btn danger" onclick="if(confirm('Are you sure you want to delete this product?')) { location.href='<%=ROOT_PATH+"pages/admin/DeleteProduct?deleteId="+editProduct.getProdId()%>'; }else{return false;}">Delete</button>
            </div>
        </div>
    <% } %>
    
        </div>
    
        <input type="radio" id="inventory" name="tab">
        <label for="inventory" onclick="location.href='<%=ROOT_PATH+"pages/admin/LoadInventory"%>'">Inventory</label>
    
    
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
                document.getElementById('edit_prodName').removeAttribute("disabled");
                document.getElementById('edit_prodBrand').removeAttribute("disabled");
                document.getElementById('edit_prodPrice').removeAttribute("disabled");
                document.getElementById('edit_prodDesc').removeAttribute("disabled");
                document.getElementById('edit_type').removeAttribute("disabled");
            });
        }
    </script>
</main>
</body>
</html>