package controller.admin.inventory;

import entity.Inventory;
import entity.Product;
import java.io.IOException;
import java.util.List;
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


@WebServlet(name = "AdminDeleteInventory", urlPatterns = {"/pages/admin/DeleteInventory"})
public class DeleteInventory extends HttpServlet {

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
        response.sendRedirect("LoadInventory");
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
        String invId = (String) request.getParameter("deleteId");
        String errorMsg = "";
        String successMsg = "";
        boolean forwardPage = true;

    try {
        // Begin transaction
        utx.begin();

        // Find Product entity to be deleted
        Inventory inventory = em.find(Inventory.class, Integer.valueOf(invId));

        if (inventory != null) {

            // Iterate over each inventory item and delete its corresponding cart item and the inventory item itself
            
            // Delete cart item
            Query deleteCartQuery = em.createQuery("DELETE FROM Cart c WHERE c.invId = :invId");
            deleteCartQuery.setParameter("invId", inventory);
            deleteCartQuery.executeUpdate();

            // Delete inventory item
            Query deleteInventoryQuery = em.createQuery("DELETE FROM Inventory i WHERE i = :invId");
            deleteInventoryQuery.setParameter("invId", inventory);
            deleteInventoryQuery.executeUpdate();
            
        }

        // Commit transaction
        utx.commit();

        successMsg = "Inventory ID " + inventory.getInvId()+ " DELETED Successfully!";
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
            String url = "LoadInventory";
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
