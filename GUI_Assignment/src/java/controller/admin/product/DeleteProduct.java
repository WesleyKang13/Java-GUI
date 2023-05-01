package controller.admin.product;

import java.util.List;
import entity.Inventory;
import entity.Product;
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


@WebServlet(name = "DeleteProduct", urlPatterns = {"/pages/admin/DeleteProduct"})
public class DeleteProduct extends HttpServlet {

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
        response.sendRedirect("LoadProduct");
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
        String errorMsg = "";
        String successMsg = "";
        boolean forwardPage = true;

    try {
        String productId = (String) request.getParameter("deleteId");
        // Begin transaction
        utx.begin();

        // Find Product entity to be deleted
        Product product = em.find(Product.class, Integer.valueOf(productId));

        if (product != null) {
            
            // Get all inventory items associated with the product
            Query query = em.createQuery("SELECT i FROM Inventory i WHERE i.prodId = :prodId");
            query.setParameter("prodId", product);
            List<Inventory> inventoryList = query.getResultList();

            // Iterate over each inventory item and delete its corresponding cart item and the inventory item itself
            for (Inventory inventory : inventoryList) {
                // Delete cart item
                Query deleteCartQuery = em.createQuery("DELETE FROM Cart c WHERE c.invId = :invId");
                deleteCartQuery.setParameter("invId", inventory);
                deleteCartQuery.executeUpdate();

                // Delete inventory item
                Query deleteInventoryQuery = em.createQuery("DELETE FROM Inventory i WHERE i = :invId");
                deleteInventoryQuery.setParameter("invId", inventory);
                deleteInventoryQuery.executeUpdate();
            }

            // Delete all reviews related to the product
            Query query3 = em.createQuery("DELETE FROM Review r WHERE r.prodId = :prodId");
            query3.setParameter("prodId", product);
            query3.executeUpdate();
            
            // Delete all order_items related to the product
            Query query4 = em.createQuery("DELETE FROM OrderItem oi WHERE oi.prodId = :prodId");
            query4.setParameter("prodId", product);
            query4.executeUpdate();

            // Finally, delete the product
            em.remove(product);
        }

        // Commit transaction
        utx.commit();

        successMsg = "Product ID " + product.getProdId() + " DELETED Successfully!";
    } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg = e.getMessage();
            }
            errorMsg += ex.getMessage();
            forwardPage = false;
            // error page
            response.sendRedirect("../../pages/error.jsp?errorMsg="+errorMsg);
        }

        if (forwardPage) {
            String url = "LoadProduct";
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
