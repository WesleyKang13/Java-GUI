package controller.customer;

import entity.Cart;
import entity.Customer;
import entity.Inventory;
import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

@WebServlet(name = "UpdateCart", urlPatterns = {"/pages/product/UpdateCart"})
public class UpdateCart extends HttpServlet {
    
    @PersistenceContext EntityManager em;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.sendRedirect("FindProduct");
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @Resource UserTransaction utx;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the customer ID from the session
        int customerId = (int) request.getSession().getAttribute("customerId");
        
        int productId = Integer.parseInt(request.getParameter("productId"));
        String color = request.getParameter("color");
        float size = Float.parseFloat(request.getParameter("size"));
            try{
                Customer customer = em.find(Customer.class, customerId);
                
                Inventory inventory = (Inventory) em.createQuery("SELECT i FROM Inventory i WHERE i.prodId.prodId = :productId AND i.invColor = :color AND i.invShoeSize = :size")
                             .setParameter("productId", productId)
                             .setParameter("color", color)
                             .setParameter("size", size)
                             .getSingleResult();
                
                utx.begin();

                Cart cart = new Cart();
                cart.setCustId(customer);
                cart.setInvId(inventory);
                cart.setCartQuantity(1); 
                em.persist(cart);

                utx.commit();

                response.sendRedirect("FindProduct");
                
            }catch(Exception ex){
                    try (PrintWriter out = response.getWriter()) {
                    out.println("Error");
                    out.println(ex.getMessage());
                }
            }
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
