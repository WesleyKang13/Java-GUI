package controller.admin.product;

import java.util.List;
import entity.Cart;
import entity.CustOrder;
import entity.Customer;
import entity.OrderItem;
import entity.Product;
import entity.Review;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
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
        String productId = (String) request.getParameter("deleteId");
        String errorMsg = "";
        String successMsg = "";
        boolean forwardPage = true;

    try {
        // Begin transaction
        utx.begin();

        // Find Product entity to be deleted
        Product product = em.find(Product.class, Integer.valueOf(productId));

        if (product != null) {
            // Delete all inventory items related to the product
            Query query1 = em.createQuery("DELETE FROM Inventory i WHERE i.prodId = :prodId");
            query1.setParameter("prodId", product);
            query1.executeUpdate();

            // Delete all items from customer's cart related to the product
            Query query2 = em.createQuery("DELETE FROM Cart c WHERE c.prodId = :prodId");
            query2.setParameter("prodId", product);
            query2.executeUpdate();

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
                errorMsg = "Error Occurred: Please try again. (" + e.getMessage() + ")";
                throw new ServletException(e);
            }
            errorMsg += "Error Occurred: Please try again. (" + ex.getMessage() + ")";
            forwardPage = false;
            // error page
            throw new ServletException(ex);
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
