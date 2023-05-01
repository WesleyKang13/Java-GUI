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
        
        String filter = request.getAttribute("filter") == null ? "MOST" : "LEAST";
        request.removeAttribute("filter");
    %>
    <%!
        public static String convertTimestamp(Date timestamp) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss"); // Create a date format object
            String formattedDate = sdf.format(timestamp); // Format the date as a string
            return formattedDate;
        }

        private String validateFilter(String value, String filter){
            if (filter == null || filter.equals("MOST")) {
                if (value.equals("MOST")) {
                    return "class='active'";
                }
                return "";
            } else if (value.equals(filter)) {
                return "class='active'";
            }
            return "";
        }
    %>
    <div class="container salesReport">
        <h1><%=filter.equals("MOST")?"Most":"Least"%> Product Sales Report</h1>
        
        <div class="filter" style="padding-bottom: 1rem">
            <button type="button" <%=validateFilter("MOST", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadSalesReport"%>'" style="margin-right: 0.2rem">Most Sales</button>
            <button type="button" <%=validateFilter("LEAST", filter)%> onclick="window.location.href='<%=ROOT_PATH+"pages/admin/LoadSalesReport?LeastReport=true"%>'">Least Sales</button>
        </div>
        
        <p>Generated Date: <strong><%=convertTimestamp(new Date())%></strong></p>

        
        <button class="print btn" onclick="printContent()" style="padding:0.5rem;"><i class="fa-solid fa-print"></i></button>
        <div class="printable-content">
        <table class="weekly report table horizontal-table">
            <% 
            List<ProductSales> productList = (List<ProductSales>) request.getAttribute("productList");
            if (productList != null) {
                for(int i=0; i < productList.size();i++) {
                ProductSales ps = productList.get(i);
            %>
                    
         
            <tr>
                <td>
                    <table>
                            <tr>
                                <td colspan="5" style="background:var(--color-shadow);"><strong>Product <%=i+1%></strong></td>
                            </tr>
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
        <p style="text-align:center;">copyright</p>
    </div>
    </div>
</main>
        
<script>
    function printContent() {
        const content = document.querySelector('.printable-content').innerHTML;
        const newWindow = window.open('', '_blank', 'height=500,width=700');
        newWindow.document.write('<link href=<%=ROOT_PATH + "css/reset.css"%> rel="stylesheet">');
        newWindow.document.write('<link href=<%=ROOT_PATH + "css/admin/admin_general.css"%> rel="stylesheet">');
        newWindow.document.write('<link href=<%=ROOT_PATH + "css/admin/print.css"%> rel="stylesheet">');
        newWindow.document.write('<html><head><title>Sales Report</title>');
        newWindow.document.write('<h1 style="padding-bottom: 0.2rem; text-align:center;">Banana Shoe Store</h1>');
        newWindow.document.write('<h3 style="padding-bottom: 1.5rem; text-align:center;">email@example.com</h3>');
        newWindow.document.write('<h2 style="padding-bottom: 0.5rem; text-align:center;"><%=filter%> PRODUCT SALES REPORT</h2>');
        newWindow.document.write('<p style="text-align:center;">Generated Date: <strong><%=convertTimestamp(new Date())%></strong></p>');
        newWindow.document.write('</head><body>');
        newWindow.document.write(content);
        newWindow.document.write('</body></html>');
        newWindow.document.close();
        newWindow.focus();
        newWindow.print();
        //newWindow.close();
    }
</script>
        
        
</body>
</html>