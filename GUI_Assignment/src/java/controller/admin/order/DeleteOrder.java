package controller.admin.order;

import entity.CustOrder;
import java.io.IOException;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;


@WebServlet(name = "AdminDeleteOrder", urlPatterns = {"/pages/admin/DeleteOrder"})
public class DeleteOrder extends HttpServlet {

    @PersistenceContext EntityManager em;
    @Resource UserTransaction utx;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("LoadCustomer");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = (String) request.getParameter("deleteId");
        String errorMsg = "";
        String successMsg = "";
        boolean forwardPage = true;

        try {
            // Begin transaction
            utx.begin();

            // Find Order entity to be deleted
            CustOrder order = em.find(CustOrder.class, Integer.valueOf(orderId));

            if (order != null) {
                // Delete all order items related to the order
                Query query1 = em.createQuery("DELETE FROM OrderItem oi WHERE oi.orderId = :orderId");
                query1.setParameter("orderId", order);
                query1.executeUpdate();

                // Delete all reviews related to the order
                Query query2 = em.createQuery("DELETE FROM Review r WHERE r.orderId = :orderId");
                query2.setParameter("orderId", order);
                query2.executeUpdate();

                // Finally, delete the order
                em.remove(order);
            }

            // Commit transaction
            utx.commit();

            successMsg = "Order ID " + order.getOrderId() + " DELETED Successfully!";
        } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg = "Error Occurred: Please try again. (" + e.getMessage() + ")";
                throw new ServletException(e);
            }
            errorMsg += "Error Occurred: Please try again. (" + ex.getMessage() + ")";
            forwardPage = false;
            // error page
            throw new ServletException(ex);
        }

        if (forwardPage) {
            String url = "LoadOrder";
            if (!successMsg.equals("")) {
                url += "?successMsg=" + successMsg;
            }
            if (!errorMsg.equals("")) {
                url += "?errorMsg=" + errorMsg;
            }
            response.sendRedirect(url);
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
