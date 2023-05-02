package controller.customer;

import entity.CustOrder;
import entity.Customer;
import entity.Inventory;
import entity.OrderItem;
import entity.Payment;
import entity.Product;
import java.io.IOException;
import java.util.Date;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;

/**
 *
 * @author User
 */
@WebServlet(name = "CustomerPaidOrder", urlPatterns = {"/pages/product/PaidOrder"})
public class PaidOrder extends HttpServlet {

    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("../error.jsp");
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
    @Resource UserTransaction utx;
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
        
        // Get the customer ID from the session
        int customerId = (int) request.getSession().getAttribute("customerId");
        
        String paymentMethod = request.getParameter("paymentMethod");
        String shippingAddress = request.getParameter("address1");
        String totalPrice = request.getParameter("subTotalPrice");
                
            try{
                Customer customer = em.find(Customer.class, customerId);
                utx.begin();

                // Create a new Payment entity and set the payment information
                Payment payment = new Payment();
                payment.setPaytMethod(paymentMethod);
                payment.setPaytTotalAmount(Double.valueOf(totalPrice));
                payment.setPaytDate(new Date());

                //Insert into payment table
                em.persist(payment);
                em.flush();
                
                // Create a new CustOrder entity and set the customer, payment, and shipping information
                CustOrder newOrder = new CustOrder();
                newOrder.setCustId(customer);
                newOrder.setPaytId(payment);
                newOrder.setOrderShippingAddress(shippingAddress);
                newOrder.setOrderStatus("PACKAGING");
                newOrder.setDate(new Date());

                em.persist(newOrder);
                em.flush();
                
                String[] productValues = request.getParameterValues("product");
                String[] productQuantityValues = request.getParameterValues("productQuantity");
                if (productValues != null) {
                    for (int i = 0; i < productValues.length; i++) {
                        int p = Integer.parseInt(productValues[i]);
                        int q = Integer.parseInt(productQuantityValues[i]);
                        Product productOrdered = em.find(Product.class, p);
                        
                        //create new orderItemId and set orderId, prodId and quantity
                        OrderItem newOrderItem = new OrderItem();
                        newOrderItem.setOrderId(newOrder);
                        newOrderItem.setProdId(productOrdered);
                        newOrderItem.setOrderItemQuantity(q);
                        
                        em.persist(newOrderItem);
                    }
                }
                
                //Clear cart after make order
                Query query = em.createQuery("DELETE FROM Cart c WHERE c.custId.custId = :custId");
                query.setParameter("custId", customerId);
                query.executeUpdate();
                
                utx.commit();
                //Set necessary info for Payment Successful page
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                session.setAttribute("order", newOrder);
                session.setAttribute("payment", payment);
                
                response.sendRedirect("../customer/PaymentSuccessful.jsp");
                
            }catch(Exception ex){
                response.sendRedirect("../../pages/error.jsp?errorMsg="+ex.getMessage());
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
