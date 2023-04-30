package controller.customer.panel.order;

import entity.CustOrder;
import entity.OrderItem;
import entity.Product;
import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "CustomerLoadOrder", urlPatterns = {"/pages/customer/panel/LoadOrder/*"})
public class LoadOrder extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            // Get the customer ID from the session
            int customerId = (int) request.getSession().getAttribute("customerId");

            // Load all orders for the customer ID
            Query q = em.createQuery("SELECT o FROM CustOrder o WHERE o.custId.custId = :customerId ORDER BY o.orderId DESC");
            q.setParameter("customerId", customerId);
            List<CustOrder> orderList = q.getResultList();

            // Forward Page
            request.removeAttribute("ROOT_PATH");
            request.setAttribute("orderList", orderList);
            request.setAttribute("ROOT_PATH", "../../../");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/customer/panel/order.jsp");
            dispatcher.forward(request, response);
        }catch(Exception ex){
            //error
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) { //No action require
            processRequest(request, response);
            return;
        }

        boolean forwardPage = true;
        request.setAttribute("ROOT_PATH", "../../../../../");
        //Remove orderList
        request.removeAttribute("orderList");

        String[] pathParts = pathInfo.split("/");
        
        if (pathParts[1].equals("orderID")) {
            // Edit the order with the specified ID
            int orderID = Integer.parseInt(pathParts[2]);
            CustOrder orderDetail = em.find(CustOrder.class, orderID);

            // Query to fetch all the order items for the specified order
            Query query = em.createQuery("SELECT oi FROM OrderItem oi WHERE oi.orderId = :orderID");
            query.setParameter("orderID", orderDetail);

            // Execute the query and retrieve the result
            List<OrderItem> orderItems = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("orderDetail", orderDetail);
            request.setAttribute("orderItems", orderItems);
        }
        
        
        else if (pathParts[1].equals("search")) {
            // Get the search value from the request
            String searchValue = "";
            if (pathParts.length > 2) {
                searchValue = pathParts[2];
            }
            // Query to search for a order based on search value
            int customerId = (int) request.getSession().getAttribute("customerId");

            Query q = em.createQuery("SELECT o FROM CustOrder o JOIN o.custId c JOIN c.userId u JOIN o.paytId p WHERE c.custId = :customerId AND (c.custFullName LIKE :searchValue OR u.userName LIKE :searchValue OR c.custPhoneNum LIKE :searchValue OR u.userEmail LIKE :searchValue OR c.custShippingAddress LIKE :searchValue OR o.orderShippingAddress LIKE :searchValue OR o.orderStatus LIKE :searchValue OR p.paytMethod LIKE :searchValue)");
            q.setParameter("customerId", customerId);
            q.setParameter("searchValue", "%" + searchValue + "%");

            // Execute the query and retrieve the result
            List<CustOrder> orderList = q.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("orderList", orderList);
            request.setAttribute("searchValue", searchValue);
        } 
        
        
        else if (pathParts[1].equals("filter")) {
            // Get the status value from the request
            String filter = "";
            if (pathParts.length > 2) {
                filter = pathParts[2];
            }
            // Query to search for orders based on the status
            int customerId = (int) request.getSession().getAttribute("customerId");

            // Load all orders for the specified customer with the given status filter
            Query q = em.createQuery("SELECT o FROM CustOrder o WHERE o.custId.custId = :customerId AND o.orderStatus = :status");
            q.setParameter("customerId", customerId);
            q.setParameter("status", filter);

            // Execute the query and retrieve the result
            List<CustOrder> orderList = q.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("orderList", orderList);
            request.setAttribute("filter", filter);
        }
                
        else if (pathParts[1].equals("ReviewOrder")) {
            // Get the order and product IDs from the path
            int orderID = Integer.parseInt(pathParts[2]);
            int productID = Integer.parseInt(pathParts[4]);

            // Query the database to check if the order and product exist
            Query orderQuery = em.createQuery("SELECT o FROM CustOrder o WHERE o.orderId = :orderID");
            orderQuery.setParameter("orderID", orderID);

            Query productQuery = em.createQuery("SELECT p FROM Product p WHERE p.prodId = :productID");
            productQuery.setParameter("productID", productID);
            request.setAttribute("ROOT_PATH", "../../../../../../../");

            try {
                // Get the order and product objects
                CustOrder order = (CustOrder) orderQuery.getSingleResult();
                Product product = (Product) productQuery.getSingleResult();

                // Set the order and product as attributes for the request
                request.setAttribute("reviewOrder", order);
                request.setAttribute("reviewProduct", product);
            } catch (NoResultException e) {
                // If the order or product does not exist, redirect to an error page
                response.sendRedirect("errorPage.jsp");
            }
        }
        
        else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/customer/panel/order.jsp");
            dispatcher.forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
