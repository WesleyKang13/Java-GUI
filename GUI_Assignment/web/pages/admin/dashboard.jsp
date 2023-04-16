<% String ROOT_PATH = "../../"; %>
<jsp:include page="<%= ROOT_PATH + "pages/admin/sidebar.jsp"%>">
    <jsp:param name="ROOT_PATH" value="<%=ROOT_PATH%>" />
</jsp:include>

<script>
    body.querySelector(".nav-link.dashboard").classList.add("active");
</script>


<link rel="stylesheet" href="../../css/admin/customer.css">

<main>
</main>
</body>
</html>