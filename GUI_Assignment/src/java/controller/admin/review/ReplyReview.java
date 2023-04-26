package controller.admin.review;

import entity.Review;
import java.io.IOException;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

@WebServlet(name = "ReplyReview", urlPatterns = {"/pages/admin/ReplyReview"})
public class ReplyReview extends HttpServlet {

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
        
        String reviewId = (String)request.getParameter("reply_Id");
        String replyMsg = (String)request.getParameter("edit_replyMsg");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<h1>"+invId+"</h1>");
//            out.println("<h1>"+invProdId+"</h1>");
//            out.println("<h1>"+invQuantity+"</h1>");
//            out.println("<h1>"+invColor+"</h1>");
//            out.println("<h1>"+invSize+"</h1>");
//        }
        
        try {
            // Begin transaction
            utx.begin();

            // Find Review entity to be updated or add new one
            Review review = em.find(Review.class, Integer.valueOf(reviewId));
            Review reply = null;

            // Check if current review has a reply
            if (review.getReviewReply() != null) {
                // Update fields in existing reply entity
                reply = em.find(Review.class, review.getReviewReply());
                reply.setReviewDescription(replyMsg);
            } else {
                // Create new reply entity
                reply = new Review();
                reply.setReviewDescription(replyMsg);

                // Persist Review entity to generate review Id
                em.persist(reply);
                em.flush(); // flush changes to the database to generate the id

                // Set the reply id in the current review entity
                review.setReviewReply(reply.getReviewId());
            }

            // Commit transaction
            utx.commit();

            successMsg = "Review ID " + review.getReviewId() + " REPLIED successfully!";
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
            //error page
            throw new ServletException(ex);
        }

        if (forwardPage) {
            String url = "LoadReview";
            if (!successMsg.equals("")) {
                url += "?successMsg=" + successMsg;
            }
            if (!errorMsg.equals("")) {
                if (url.contains("?")) {
                    url += "&errorMsg=" + errorMsg;
                } else {
                    url += "?errorMsg=" + errorMsg;
                }
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
