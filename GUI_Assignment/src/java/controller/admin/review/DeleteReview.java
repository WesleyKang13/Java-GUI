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


@WebServlet(name = "DeleteReview", urlPatterns = {"/pages/admin/DeleteReview"})
public class DeleteReview extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errorMsg = "";
        String successMsg = "";
        boolean forwardPage = true;

    try {
        String reviewId = (String) request.getParameter("deleteId");
        // Begin transaction
        utx.begin();

        // Find Product entity to be deleted
        Review review = em.find(Review.class, Integer.valueOf(reviewId));

        //Delete the Review
        em.remove(review);
        
        // Commit transaction
        utx.commit();

        successMsg = "Review ID " + review.getReviewId()+ " DELETED Successfully!";
    } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg = e.getMessage();
            }
            errorMsg += ex.getMessage();
            forwardPage = false;
            // error page
            response.sendRedirect("../../pages/error.jsp?errorMsg="+errorMsg);
        }

        if (forwardPage) {
            String url = "LoadReview";
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
