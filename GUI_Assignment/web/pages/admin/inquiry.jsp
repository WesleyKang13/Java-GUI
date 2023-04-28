<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entity.Inquiry"%>

<% String ROOT_PATH = "../../"; %>

<% 
    
    boolean addNewAction = request.getParameter("addNewAction") != null ? true : false;
    
    List<Inquiry> inquiryList = (List<Inquiry>) request.getAttribute("inquiryList") != null ? (List<Inquiry>) request.getAttribute("inquiryList")  : null;
    
        
    
%>

<jsp:include page="<%= ROOT_PATH + "pages/admin/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    body.querySelector(".nav-link.inquiry").classList.add("active");
</script>

<link rel="stylesheet" href="../../css/admin/inquiry.css">
        
<main>
    <div class="container inquiryList">
        <div class="text">
            <h1>Inquiry List</h1>
            <p><%=inquiryList.size()%> record(s) found</p>
        </div>

        <button class="addNew btn">Add New</button>
        <div class="searchBar">
            <input type="search" placeholder="Search ..." required>
            <a href="#"><i class='fa-solid fa-magnifying-glass fa-bounce'></i></a>
        </div>

        
<!--    <div class="filter">
        <a href="#" class="active">All</a>
        <a href="#">Casual</a>
        <a href="#">Work</a>
        <a href="#">Sport</a>
        <a href="#">Others</a>
    </div>-->

<!--        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Occurred, Please Try Again !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>
        -->
        <table class="table horizontal-table">
            <thead>
                <tr>
                    <td class="checkAllIcon" style="padding:0.5rem;"><i class="fa-solid fa-list-check fa-spin" style="transition: none;"></i></td>
                    <th style="padding-left:0.2rem;">Inqury ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Subject</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
           
            <tbody>
                <%
                     
                  for(int i=0; i<inquiryList.size(); i++){
                      Inquiry inquiry = inquiryList.get(i);
                      Integer id = inquiry.getInqId();
                      String name = inquiry.getInqName();
                      String email = inquiry.getInqEmail();
                      String subject = inquiry.getInqSubject();
                      String description = inquiry.getInqDescription();
                      Date date = inquiry.getInqCreatedDate();

                    
                %>
                <tr>
                    <td style="padding:0;"><input type="checkbox"></td>
                    <td style="padding-left:0.2rem;"><%=inquiry.getInqId()%></td>
                    <td><%=inquiry.getInqName() %></td>
                    <td><a style="margin-right: 20px;" href="mailto:<%=inquiry.getInqEmail()%>"
                    class="actionRoundBtn"><i class="fa-solid fa-envelope"></i></i></a></td>
                    <td><%=inquiry.getInqSubject()%></td>
                    <td><%=inquiry.getInqDescription()%></td>
                    <td><%=inquiry.getInqCreatedDate()%></td>
                    <td>
                    <div style="display: flex;">
                        <button style=" margin-right: 15px;" class="actionRoundBtn"><i class="fa-solid fa-circle-info fa-spin"></i></button>
                        <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this customer?')) 
                        { location.href='<%=ROOT_PATH+"pages/admin/DeleteCustomer?deleteId="+inquiry.getInqId()%>'; }
                        else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                    </div>
                    </td>
                <% } %>
            </tbody>
        </table>
<!--        <button class="editCustBtn btn success">Edit</button>-->
    </div>

    <div class="container addInquiry hide">
        <div class="text">
            <h1>Add Inquiry</h1>
        </div>

        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Occurred, Please Try Again !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>
        
        <table class="table vertical-table">
            <tr>
                <td>Rank</td>
                <td><input type="text" value="1"></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><input type="text" value="Domenic"></td>
            </tr>
            <tr>
                <td>Points</td>
                <td><input type="text" value="8810"></td>
            </tr>
            <tr>
                <td>Team</td>
                <td><input type="text" value="Timothythythy"></td>
            </tr>
        </table>

        <div class="addNew-action">
            <button class="addNewBackBtn backBtn btn" style="float: left;">Back</button>
            <button class="submitBtn btn success">Submit</button>
            <button class="resetBtn btn danger">Reset</button>
        </div>
    </div>

    <div class="container inquiryDetail hide">
        <div class="text">
            <h1>Inquiry Detail</h1>
            <p>230101YWM - YAP WAI MENG</p>
        </div>

        <div class="notificationBox success">
            <span class="message">Record Deleted Successfully !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>

        <div class="notificationBox error">
            <span class="message">Error Occurred, Please Try Again !</span>
            <span class="closeBtn" onclick="this.parentElement.style.display='none';"><i class="fa-solid fa-xmark"></i></span> 
        </div>
        
        <table class="table vertical-table">
            <tr>
                <td>Rank</td>
                <td><input type="text" name="rank" id="rank" value="1" disabled></td>
            </tr>
            <tr>
                <td>Name</td>
                <td><input type="text" name="name" id="name" value="Domenic" disabled></td>
            </tr>
            <tr>
                <td>Points</td>
                <td><input type="text" name="point" id="point" value="8810" disabled></td>
            </tr>
            <tr>
                <td>Team</td>
                <td><input type="text" name="team" id="team" value="Timothythythy" disabled></td>
            </tr>
        </table>

        <div class="detail-action">
            <button class="editCustBackBtn backBtn btn" style="float: left;">Back</button>
            <button class="deleteBtn btn danger">Delete</button>
            <button class="editBtn btn success">Edit</button>
        </div>

        <div class="edit-action hide">
            <button class="back btn" style="float: left;">Restore</button>
            <button class="edit btn success">Save</button>
            <button class="delete btn danger">Cancel</button>
        </div>
    </div>
</main>
<script>
    //SHOW and HIDE Container
    const custListField = body.querySelector('.inquiryList'),
        addCustField = body.querySelector('.addInquiry'),
        custDetailField = body.querySelector('.inquiryDetail'),
        addNewBtn = body.querySelector('.addNew.btn'),
        addNewBackBtn = body.querySelector('.addNewBackBtn'),
        editCustBtn = body.querySelector('.editCustBtn'),
        editCustBackBtn = body.querySelector('.editCustBackBtn');

    addNewBtn.addEventListener("click" , () =>{
        custListField.style.opacity = 0;
        addCustField.style.opacity = 1;
        custDetailField.style.opacity = 0;

        setTimeout(() => {
            custListField.classList.add("hide");
            addCustField.classList.remove("hide");
        }, 200);
    });

    addNewBackBtn.addEventListener("click" , () =>{
        addCustField.style.opacity = 0;
        custListField.style.opacity = 1;
        custDetailField.style.opacity = 0;
        
        setTimeout(() => {
            addCustField.classList.add("hide");
            custListField.classList.remove("hide");
        }, 200);
    });

    editCustBtn.addEventListener("click" , () =>{
        addCustField.style.opacity = 0;
        custListField.style.opacity = 0;
        custDetailField.style.opacity = 1;
        
        setTimeout(() => {
            custListField.classList.add("hide");
            custDetailField.classList.remove("hide");
        }, 200);
    });

    editCustBackBtn.addEventListener("click" , () =>{
        addCustField.style.opacity = 0;
        custListField.style.opacity = 1;
        custDetailField.style.opacity = 0;
        
        setTimeout(() => {
            custDetailField.classList.add("hide");
            custListField.classList.remove("hide");
        }, 200);
    });

    //SHOW and HIDE Action Button
    const editBtn = body.querySelector('.editBtn'),
        actionBtnField = body.querySelector('.detail-action'),
        editActionBtnField = body.querySelector('.edit-action');
    //Get Text Field and remove 'disabled'

    editBtn.addEventListener("click" , () =>{
        actionBtnField.classList.add("hide");
        editActionBtnField.classList.remove("hide");
        document.getElementById('rank').removeAttribute("disabled");
        document.getElementById('name').removeAttribute("disabled");
        document.getElementById('point').removeAttribute("disabled");
        document.getElementById('team').removeAttribute("disabled");
    });
</script>
</body>
</html>