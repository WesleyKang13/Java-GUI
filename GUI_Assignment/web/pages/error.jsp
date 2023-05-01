<% String ROOT_PATH = "../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/header.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>


    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<body >
    
    <style>
        table{
            background-color: rgb(207, 199, 199);
            margin:0 auto;
            border:2px black solid;
            border-radius:10px;
            box-shadow: 10px 10px;
            width:550px;
            height:60vh;
            margin-top:20px;
            margin-bottom:20px;
        }
    </style>

   

    <table>
            <tr>
                <td>
                    <h1 style="text-align:center;">Error Occurred!</h1>
                    <h2 style="text-align:center;">Please Try Again Later.</h2>
                    <% if(request.getParameter("errorMsg")!=null){ %>
                            <h3 style="text-align:center;">Error: <%=request.getParameter("errorMsg")%></h3>
                    <% } %>
                    <% if(request.getAttribute("errorMsg")!=null){ %>
                            <h3 style="text-align:center;">Error: <%=request.getAttribute("errorMsg")%></h3>
                    <% } %>
                    <h3 style="text-align:center;">[<a href="<%= ROOT_PATH + "index.html"%>">Back to Home Page</a>]</h3>
                </td>
            </tr>
    </table>

</body>
<!-- Include footer page -->
<jsp:include page="<%= ROOT_PATH + "pages/footer.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>