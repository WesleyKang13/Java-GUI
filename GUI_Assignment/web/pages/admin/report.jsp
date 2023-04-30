<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="entity.OrderItem"%>
<%@page import="java.util.List"%>
<%@page import="controller.admin.report.ProductSales"%>
<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/admin/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>
<script>
    const body = document.querySelector('body');
    body.querySelector(".nav-link.report").classList.add("active");
</script>

<link rel="stylesheet" href="../../css/admin/report.css">
        
<main>
    <%
        //Redirect to home page if it's not admin
        int validatePermission = session.getAttribute("userPermission") != null ? (Integer)session.getAttribute("userPermission") : 999 ;
        if(validatePermission == 999 || validatePermission != 0){
            response.sendRedirect(ROOT_PATH+"index.html");
        }
    %>
    <%!
        public static String convertTimestamp(Date timestamp) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // Create a date format object
            String formattedDate = sdf.format(timestamp); // Format the date as a string
            return formattedDate;
        }
    %>
    <div class="container salesReport">
        <h1 style="padding-bottom: 1.5rem">Sales Report</h1>

        <p>Generated Date: <strong><%=convertTimestamp(new Date())%></strong></p>

        <table class="weekly report table horizontal-table">
            <% 
            List<ProductSales> productList = (List<ProductSales>) request.getAttribute("productList");
            if (productList != null) {
                for(int i=0; i < productList.size();i++) {
                ProductSales ps = productList.get(i);
            %>
                    
         
            <tr>
                <td><strong>Product <%=i+1%></strong></td>
                <td>
                    <table>
                            <tr>
                                <td><strong>Product ID</strong></td>
                                <td><strong>Product Name</strong></td>
                                <td><strong>Sales Count</strong></td>
                                <td><strong>Unit Price (RM)</strong></td>
                                <td><strong>Total Sales (RM)</strong></td>
                            </tr>

                            <tr>
                                <td><%=ps.getProductId().getProdId()%></td>
                                <td><%=ps.getProductId().getProdName()%></td>
                                <td><%=ps.getSalesCount()%></td>
                                <td><%=String.format("%.2f",ps.getProductId().getProdPrice())%></td>
                                <td><%=String.format("%.2f",ps.getProductId().getProdPrice()*ps.getSalesCount())%></td>
                            </tr>
                    </table>
                </td>
            </tr>
            <% } } %>
        </table>
    </div>
</main>
</body>
</html>