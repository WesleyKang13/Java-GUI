package controller.customer.panel.payment;

import entity.CustOrder;
import entity.Payment;
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


@WebServlet(name = "CustomerLoadPayment", urlPatterns = {"/pages/customer/panel/LoadPayment/*"})
public class LoadPayment extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            // Get the customer ID from the session
            int customerId = (int) request.getSession().getAttribute("customerId");
            
            //Load all payments in database
            Query q = em.createQuery("SELECT p FROM Payment p JOIN p.custOrderList o JOIN o.custId c WHERE c.custId = :customerId ORDER BY p.paytId DESC");

            q.setParameter("customerId", customerId);
            List<Payment> paymentList = q.getResultList();
            request.setAttribute("paymentList", paymentList);
            request.removeAttribute("ROOT_PATH");
            request.setAttribute("ROOT_PATH", "../../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/customer/panel/payment.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception ex){
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<h1>"+ex.getMessage()+"</h1>");
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

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) { //No action require
            processRequest(request, response);
            return;
        }

        boolean forwardPage = true;
        request.removeAttribute("ROOT_PATH");
        request.setAttribute("ROOT_PATH", "../../../../../");
        //Remove paymentList
        request.removeAttribute("paymentList");

        String[] pathParts = pathInfo.split("/");
        
        if (pathParts[1].equals("paymentDetailID")) {
            // Find the payment with the specified ID
            int paymentDetailID = Integer.parseInt(pathParts[2]);
            Payment paymentDetail = em.find(Payment.class, paymentDetailID);
            request.setAttribute("paymentDetail", paymentDetail);
            
            // Query to fetch corresponding Order Detail
            Query query = em.createQuery("SELECT o FROM CustOrder o WHERE o.paytId.paytId = :paytId");
            query.setParameter("paytId", paymentDetail.getPaytId());
            CustOrder orderDetail = (CustOrder) query.getSingleResult();
            request.setAttribute("orderDetail", orderDetail);
        }
        
        else if (pathParts[1].equals("filter")) {
            // Get the payment method value from the request
            String filter = "";
            if (pathParts.length > 2) {
                filter = pathParts[2];
            }
            
            // Get the customer ID from the session
            int customerId = (int) request.getSession().getAttribute("customerId");
            //
            // Query to search for payments based on the payment method
            Query query = em.createQuery("SELECT p FROM Payment p JOIN p.custOrderList o JOIN o.custId c WHERE c.custId = :customerId AND p.paytMethod LIKE :method ORDER BY p.paytId DESC");
            query.setParameter("customerId", customerId);
            query.setParameter("method", "%" + filter + "%");

            // Execute the query and retrieve the result
            List<Payment> paymentList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("paymentList", paymentList);
            request.setAttribute("filter", filter);
        } 
        else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/customer/panel/payment.jsp");
            dispatcher.forward(request, response);
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
