package controller.customer;

import entity.Inventory;
import entity.Product;
import java.awt.HeadlessException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
@WebServlet(name = "FIndDetails", urlPatterns = {"/pages/product/FIndDetails"})
public class FindDetails extends HttpServlet {
    
    @PersistenceContext EntityManager em;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int prodId = Integer.parseInt(request.getParameter("prodId"));
            TypedQuery<Object[]> query = em.createNamedQuery("Product.findByIdWithInventory", Object[].class);
            query.setParameter("prodId", prodId);
            List<Object[]> resultList = query.getResultList();

        if (resultList.isEmpty()) {
            JOptionPane.showMessageDialog(null, "Empty record");
        } else {
            Product product = (Product) resultList.get(0)[0];
            List<Inventory> inventoryList = new ArrayList<>();
            for (Object[] obj : resultList) {
                inventoryList.add((Inventory) obj[1]);
            }

            request.setAttribute("product", product);
            request.setAttribute("inventoryList", inventoryList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("ProductDetails.jsp");
            dispatcher.forward(request, response);
          }
        }catch(HeadlessException | IOException | NumberFormatException | ServletException ex){
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
