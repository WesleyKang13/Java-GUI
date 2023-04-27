package controller.admin.review;

import entity.Inventory;
import entity.Product;
import entity.Review;
import java.io.IOException;
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


@WebServlet(name = "LoadReview", urlPatterns = {"/pages/admin/LoadReview/*"})
public class LoadReview extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all reviews in database
            Query q = em.createNamedQuery("Review.findAllDescId");
            List<Review> reviewList = q.getResultList();
            request.setAttribute("reviewList", reviewList);
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/review.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception ex){
            //error
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
        request.setAttribute("ROOT_PATH", "../../../../");
        //Remove productList
        request.removeAttribute("reviewList");

        String[] pathParts = pathInfo.split("/");
        
        if (pathParts[1].equals("replyReviewID")) {
            // Find the inventory with the specified ID
            int replyReviewID = Integer.parseInt(pathParts[2]);
            Review replyReview = em.find(Review.class, replyReviewID);
            request.setAttribute("replyReview", replyReview);
            
            if(replyReview.getReviewReply() != null){
                Review replyMsg = em.find(Review.class, replyReview.getReviewReply());
                request.setAttribute("replyMsg", replyMsg.getReviewDescription());
            }
        }
        
    else if (pathParts[1].equals("search")) {
        // Get the search value from the request
        String searchValue = "";
        if (pathParts.length > 2) {
            searchValue = pathParts[2];
        }
        // Query to search for reviews based on customer name, product name, and review description
        Query query = em.createQuery("SELECT r FROM Review r JOIN r.custId c JOIN r.prodId p WHERE c.custFullName LIKE :searchValue OR p.prodName LIKE :searchValue OR r.reviewDescription LIKE :searchValue");
        query.setParameter("searchValue", "%" + searchValue + "%");
        
        // Execute the query and retrieve the result
        List<Review> reviewList = query.getResultList();
        
        // Set the result as an attribute for the request
        request.setAttribute("reviewList", reviewList);
        request.setAttribute("searchValue", searchValue);
        
    }
        else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/review.jsp");
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
