<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="entity.Inquiry"%>

<% String ROOT_PATH = "../../"; %>

<%!
    public static String convertTimestamp(Date timestamp) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // Create a date format object
        String formattedDate = sdf.format(timestamp); // Format the date as a string
        return formattedDate;
    }
%>

<% 
    //Redirect to home page if it's not admin
    int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
    if(validatePermission == 999 || validatePermission != 0 && validatePermission != 1){
        response.sendRedirect(ROOT_PATH+"index.html");
    }
    
    List<Inquiry> inquiryList = (List<Inquiry>) request.getAttribute("inquiryList") != null ? (List<Inquiry>) request.getAttribute("inquiryList")  : null;
    
%>

<jsp:include page="<%= ROOT_PATH + "pages/admin/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.inquiry").classList.add("active");
</script>

<link rel="stylesheet" href="../../css/admin/inquiry.css">
        
<main>
    <div class="container inquiryList">
        <div class="text">
            <h1>Inquiry List</h1>
            <p><%=inquiryList.size()%> record(s) found</p>
        </div>
        
        <table class="table horizontal-table">
            <thead>
                <tr>
                    <th style="padding-left:0.2rem;">Inquiry ID</th>
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
                    <td style="padding-left:0.2rem;"><%=inquiry.getInqId()%></td>
                    <td><%=inquiry.getInqName() %></td>
                    <td><a style="margin-right: 20px;" href="mailto:<%=inquiry.getInqEmail()%>"
                    class="actionRoundBtn"><i class="fa-solid fa-envelope"></i></i></a></td>
                    <td><%=inquiry.getInqSubject()%></td>
                    <td><%=inquiry.getInqDescription()%></td>
                    <td><%=convertTimestamp(inquiry.getInqCreatedDate())%></td>
                    <td>
                    <div style="display: flex;">
                        <button class="actionRoundBtn danger" onclick="if(confirm('Are you sure you want to delete this customer?')) 
                        { location.href='<%=ROOT_PATH+"pages/admin/DeleteCustomer?deleteId="+inquiry.getInqId()%>'; }
                        else{return false;}"><i class="fa-solid fa-trash fa-spin fa-spin"></i></button>
                    </div>
                    </td>
                <% } %>
            </tbody>
        </table>
    </div>
</main>
</body>
</html>