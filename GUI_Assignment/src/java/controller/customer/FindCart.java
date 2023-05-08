package controller.customer;

import entity.Cart;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FindCart", urlPatterns = {"/pages/customer/FindCart"})
public class FindCart extends HttpServlet {
    @PersistenceContext EntityManager em;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            if(request.getSession().getAttribute("userPermission") == null){
                
                String message = "You must be logged in first in order to perform the following action";
                request.setAttribute("message", message);
                String redirectUrl = "../../pages/UserLogin.jsp";
                String alertScript = "<script>alert('" + message + "');</script>";
                response.getWriter().write(alertScript);
                response.setHeader("Refresh", "0; URL=" + redirectUrl);
                return;
            }
            
            if((int)request.getSession().getAttribute("userPermission")==0 ||(int)request.getSession().getAttribute("userPermission")==1){
                String message = "Admin/Staff not allow purchase items, please register a customer account.";
                request.setAttribute("message", message);
                String redirectUrl = "../../index.jsp";
                String alertScript = "<script>alert('" + message + "');</script>";
                response.getWriter().write(alertScript);
                response.setHeader("Refresh", "0; URL=" + redirectUrl);
            }
            else{
                // Get the customer ID from the session
                int customerId = (int) request.getSession().getAttribute("customerId");
            
                Customer customer = em.find(Customer.class, customerId);

                request.setAttribute("custId", customer);

                // Query to search for a customer based on search value
                Query query = em.createQuery(" SELECT c FROM Cart c WHERE c.custId = :custId");
                query.setParameter("custId", customer);
                List<Cart> cartItems = query.getResultList();

                request.setAttribute("cartItems", cartItems);

                RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
                dispatcher.forward(request, response);
            }
        }catch(Exception ex){
            try (PrintWriter out = response.getWriter()) {
                out.println("Error");
                out.println(ex.getMessage());
            }
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
