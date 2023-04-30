/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer.panel.review;

import entity.CustOrder;
import entity.Customer;
import entity.Product;
import entity.Review;
import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

/**
 *
 * @author yapwa
 */
@WebServlet(name = "CustomerReviewProduct", urlPatterns = {"/pages/customer/panel/ReviewProduct"})
public class ReviewProduct extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("LoadReview");
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
        // Retrieve review parameters from HTTP request
        int orderID = Integer.parseInt(request.getParameter("order_id"));
        int prodID = Integer.parseInt(request.getParameter("prod_id"));
        int custID = (int) request.getSession().getAttribute("customerId");
        double score = Double.parseDouble(request.getParameter("review_score"));
        String description = request.getParameter("review_comment");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;

        CustOrder order = em.find(CustOrder.class, orderID);
        Product product = em.find(Product.class, prodID);
        Customer customer = em.find(Customer.class, custID);
        

        try {
            // Begin transaction
            utx.begin();
            
            // Create new review object
            Review review = new Review();

            // Set review properties
            review.setCustId(customer);
            review.setOrderId(order);
            review.setProdId(product);
            review.setReviewScore(score);
            review.setReviewDescription(description);

            // Persist new review in database
            em.persist(review);

            // Commit transaction
            utx.commit();

            successMsg="Review ADDED Successfully!";
        } catch (Exception ex) {
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
            String url = "LoadReview";
            if(!successMsg.equals("")){
                url +="?successMsg=" + successMsg;
            }if(!errorMsg.equals("")){
                url +="?errorMsg=" + errorMsg;
            }
            response.sendRedirect(url);
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
