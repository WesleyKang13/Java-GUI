package controller.customer;

import entity.Cart;
import entity.Customer;
import entity.Inventory;
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "FindCheckout", urlPatterns = {"/pages/customer/FindCheckout"})
public class FindCheckout extends HttpServlet {

    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
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
                if(!response.isCommitted()){
                    String message = "Admin/Staff not allow purchase items, please register a customer account.";
                    request.setAttribute("message", message);
                    String redirectUrl = "../../index.jsp";
                    String alertScript = "<script>alert('" + message + "');</script>";
                    response.getWriter().write(alertScript);
                    response.setHeader("Refresh", "0; URL=" + redirectUrl);
                }
            }
            
            else{
                
                int customerId = (int) request.getSession().getAttribute("customerId");
                Customer customer = em.find(Customer.class, customerId);
                request.setAttribute("customer", customer);

                // Query to search for a customer's cart items based on the customer ID
                Query query = em.createQuery("SELECT c FROM Cart c WHERE c.custId = :custId");
                query.setParameter("custId", customer);

                List<Cart> checkoutItems = query.getResultList();

                if(checkoutItems.isEmpty()){
                    response.sendRedirect("../../pages/product/FindProduct?NoCheckout=true");
                }

                request.setAttribute("checkoutItems", checkoutItems);

                // Calculate the total quantity and subtotal price
                int totalQuantity = 0;
                double subtotalPrice = 0.0;

                for (Cart item : checkoutItems) {
                    totalQuantity += item.getCartQuantity();

                    subtotalPrice += item.getProdId().getProdId().getProdPrice() * 
                            item.getCartQuantity();
                }

                // Determine delivery fee
                double deliveryFee = 0.0;
                if (subtotalPrice < 200) {
                    deliveryFee = 25.0;
                    subtotalPrice += deliveryFee;
                }

                // Set the total quantity, subtotal price, and delivery fee in the request attributes
                request.setAttribute("totalQuantity", totalQuantity);
                request.setAttribute("subtotalPrice", subtotalPrice);
                request.setAttribute("deliveryFee", deliveryFee);

                if(!response.isCommitted()){
                    RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
                    dispatcher.forward(request, response);
                }
            }
        } catch (IOException | ServletException ex) {
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
