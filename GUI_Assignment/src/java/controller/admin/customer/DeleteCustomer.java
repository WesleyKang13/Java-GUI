package controller.admin.customer;

import java.util.List;
import entity.CustOrder;
import entity.Customer;
import entity.Payment;
import entity.User;
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


@WebServlet(name = "AdminDeleteCustomer", urlPatterns = {"/pages/admin/DeleteCustomer"})
public class DeleteCustomer extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String custId = (String)request.getParameter("deleteId");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
        try {
            // Begin transaction
            utx.begin();
            
            // Find User and Customer entities to be deleted
            Customer customer = em.find(Customer.class, Integer.valueOf(custId));
            User user = em.find(User.class, customer.getUserId().getUserId());
            
            //Delete rows of record
            if (customer != null) {

                // Delete all carts related to the customer
                Query query1 = em.createQuery("DELETE FROM Cart c WHERE c.custId = :custId");
                query1.setParameter("custId", customer);
                query1.executeUpdate();

                // Delete all order_items related to the customer and delete the order items
                List<CustOrder> orders = em.createQuery("SELECT o FROM CustOrder o WHERE o.custId = :custId", CustOrder.class)
                        .setParameter("custId", customer)
                        .getResultList();

                for (CustOrder order : orders) {
                    Payment payment = (Payment) em.createQuery("Select o.paytId FROM CustOrder o WHERE o = :orderId").setParameter("orderId", order).getSingleResult();
                    
                    // Delete reviews related to the order and product
                    Query query2 = em.createQuery("DELETE FROM Review r WHERE r.orderId = :orderId");
                    query2.setParameter("orderId", order);
                    query2.executeUpdate();

                    // Delete order items related to the order
                    Query query3 = em.createQuery("DELETE FROM OrderItem oi WHERE oi.orderId = :orderId");
                    query3.setParameter("orderId", order);
                    query3.executeUpdate();
                    
                    // Delete all orders related to the customer
                    Query query4 = em.createQuery("DELETE FROM CustOrder o WHERE o = :order");
                    query4.setParameter("order", order);
                    query4.executeUpdate();
                    
                    // Delete all orders related to the customer
                    Query query5 = em.createQuery("DELETE FROM Payment p WHERE p = :payment");
                    query5.setParameter("payment", payment);
                    query5.executeUpdate();
                }
                
                // Delete all orders related to the customer
                Query query6 = em.createQuery("DELETE FROM CustOrder o WHERE o.custId = :custId");
                query6.setParameter("custId", customer);
                query6.executeUpdate();
                
                // Delete reviews related to the customer
                Query query7 = em.createQuery("DELETE FROM Review r WHERE r.custId = :custId");
                query7.setParameter("custId", customer);
                query7.executeUpdate();

                // Finally, delete the customer
                em.remove(customer);
                em.remove(user);
            }
            
            // Commit transaction
            utx.commit();
            
            successMsg="Customer ID "+customer.getCustId()+" ("+customer.getCustFullName()+") DELETED Successfully!";
        }catch(Exception ex){
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg="Error Occurred: Please try again. ("+e.getMessage()+")";
                throw new ServletException(e);
            }
            errorMsg += "Error Occurred: Please try again. ("+ex.getMessage()+")";
            forwardPage=false;
            //error page
            throw new ServletException(ex);
        }
        
        if(forwardPage){
            String url = "LoadCustomer";
            if(!successMsg.equals("")){
                url +="?successMsg=" + successMsg;
            }if(!errorMsg.equals("")){
                url +="?errorMsg=" + errorMsg;
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
