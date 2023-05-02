package controller.customer;

import entity.Cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
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

@WebServlet(name = "UpdateQuantity", urlPatterns = {"/pages/product/UpdateQuantity"})
public class UpdateQuantity extends HttpServlet {
    
    @PersistenceContext EntityManager em;
    @Resource UserTransaction utx;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.sendRedirect("FindCart");
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
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String[] quantities = request.getParameterValues("quantity");
        String[] cartIds = request.getParameterValues("cartId");
        
            try {
                utx.begin();
                
                for (int i=0;i<cartIds.length;i++) {
                    //String cartId : cartIds
                    int cartIdInt = Integer.parseInt(cartIds[i]);
                    int quantityInt = Integer.parseInt(quantities[i]);
                
                    Cart cart = em.find(Cart.class, cartIdInt);

                    cart.setCartQuantity(quantityInt);
                    em.merge(cart);
                    
                    if(quantityInt < 1){
                        em.createQuery("Delete FROM Cart c WHERE c.cartId =:cartId")
                                .setParameter("cartId", cartIdInt).executeUpdate();
                    }
                    
                }
                
                utx.commit();
                RequestDispatcher dispatcher = request.getRequestDispatcher("../customer/FindCart");
                dispatcher.forward(request, response);
                
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
