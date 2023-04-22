package controller.admin.order;

import entity.CustOrder;
import entity.OrderItem;
import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "LoadOrder", urlPatterns = {"/pages/admin/LoadOrder/*"})
public class LoadOrder extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all orders in database
            Query q = em.createNamedQuery("CustOrder.findAllDescId");
            List<CustOrder> orderList = q.getResultList();
            request.setAttribute("orderList", orderList);
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/order.jsp");
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
        request.setAttribute("ROOT_PATH", "../../../../");
        //Remove orderList
        request.removeAttribute("orderList");

        String[] pathParts = pathInfo.split("/");
        
        if (pathParts[1].equals("editOrderID")) {
            // Edit the order with the specified ID
            int editOrderID = Integer.parseInt(pathParts[2]);
            CustOrder editOrder = em.find(CustOrder.class, editOrderID);

            // Query to fetch all the order items for the specified order
            Query query = em.createQuery("SELECT oi FROM OrderItem oi WHERE oi.orderId = :editOrderID");
            query.setParameter("editOrderID", editOrder);

            // Execute the query and retrieve the result
            List<OrderItem> orderItems = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("editOrder", editOrder);
            request.setAttribute("editOrderItems", orderItems);
        }
        
        
        else if (pathParts[1].equals("search")) {
            // Get the search value from the request
            String searchValue = "";
            if (pathParts.length > 2) {
                searchValue = pathParts[2];
            }
            // Query to search for a order based on search value
            Query query = em.createQuery("SELECT o FROM CustOrder o JOIN o.custId c JOIN c.userId u JOIN o.paytId p WHERE c.custFullName LIKE :searchValue OR u.userName LIKE :searchValue OR c.custPhoneNum LIKE :searchValue OR u.userEmail LIKE :searchValue OR c.custShippingAddress LIKE :searchValue OR o.orderShippingAddress LIKE :searchValue OR o.orderStatus LIKE :searchValue OR p.paytMethod LIKE :searchValue");

            query.setParameter("searchValue", "%" + searchValue + "%");

            // Execute the query and retrieve the result
            List<CustOrder> orderList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("orderList", orderList);
            request.setAttribute("searchValue", searchValue);
        } else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/order.jsp");
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
