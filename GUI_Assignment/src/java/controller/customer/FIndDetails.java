package controller.customer;

import entity.Inventory;
import entity.Product;
import entity.Review;
import java.awt.HeadlessException;
import java.io.IOException;
import java.io.PrintWriter;
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
import javax.swing.JOptionPane;

/**
 *
 * @Wesley
 */
@WebServlet(name = "FindDetails", urlPatterns = {"/pages/product/FindDetails"})
public class FindDetails extends HttpServlet {
    
    @PersistenceContext EntityManager em;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect("../../index.jsp");

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
        
                try {
                int prodId = Integer.parseInt(request.getParameter("productId"));
                List<Review> reviewList = em.createQuery("SELECT r FROM Review r WHERE r.prodId.prodId = :prodId")
                  .setParameter("prodId", prodId)
                  .getResultList();

               

                double reviewScore = 0;
                for (Review review : reviewList) {
                    reviewScore += review.getReviewScore();
                }
                reviewScore /= reviewList.size();

                Product product = em.find(Product.class, prodId);

                List<Inventory> inventoryList = em.createQuery("SELECT i FROM Inventory i WHERE i.prodId.prodId = :prodId", Inventory.class)
                        .setParameter("prodId", prodId)
                        .getResultList();

                request.setAttribute("reviewList", reviewList);
                request.setAttribute("product", product);
                request.setAttribute("inventoryList", inventoryList);
                request.setAttribute("reviewScore", reviewScore);
                RequestDispatcher dispatcher = request.getRequestDispatcher("ProductDetails.jsp");
                dispatcher.forward(request, response);
            

            }catch(Exception ex){

                try (PrintWriter out = response.getWriter()) {
                    out.println("Error");
                    out.println(ex.getMessage());
                }
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
