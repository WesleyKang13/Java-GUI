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
    <div class="reportTabs">
        
        <input type="radio" id="weekly" name="tab" checked="checked">
        <label for="weekly">Weekly</label>
        <div class="container reportList tab">
            <div class="text">
                <h1>Weekly Sales Report</h1>
                <p>Start Date: <strong>DD-MM-YYYY</strong><span class="tab-space"></span>
                    End Date: <strong>DD-MM-YYYY</strong></p>
                <p>Generated Date: <strong>DD-MM-YYYY</strong></p>
            </div>
            
            <table class="weekly report table horizontal-table">
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Product 1</th>
                        <th>Product 2</th>
                        <th>Product 3</th>
                        <th>Product 4</th>
                        <th>Product 5</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        
        <input type="radio" id="monthly" name="tab">
        <label for="monthly">Monthly</label>
        <div class="container reportList tab">
            <div class="text">
                <h1>Monthly Sales Report</h1>
                <p>Start Date: <strong>DD-MM-YYYY</strong><span class="tab-space"></span>
                    End Date: <strong>DD-MM-YYYY</strong></p>
                <p>Generated Date: <strong>DD-MM-YYYY</strong></p>
            </div>
            
            <table class="montly report table horizontal-table">
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Product 1</th>
                        <th>Product 2</th>
                        <th>Product 3</th>
                        <th>Product 4</th>
                        <th>Product 5</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <input type="radio" id="yearly" name="tab">
        <label for="yearly">Yearly</label>
        <div class="container reportList tab">
            <div class="text">
                <h1>Yearly Sales Report</h1>
                <p>Start Date: <strong>DD-MM-YYYY</strong><span class="tab-space"></span>
                    End Date: <strong>DD-MM-YYYY</strong></p>
                <p>Generated Date: <strong>DD-MM-YYYY</strong></p>
            </div>
            
            <table class="yearly report table horizontal-table">
                <thead>
                    <tr>
                        <th>Year</th>
                        <th>Product 1</th>
                        <th>Product 2</th>
                        <th>Product 3</th>
                        <th>Product 4</th>
                        <th>Product 5</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>2020</td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                        <td>
                            ID: <strong>ABD001</strong><br>
                            Name: <strong>Product 1</strong><br>
                            Sales: <strong>RM9999.99</strong>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</main>
</body>
</html>