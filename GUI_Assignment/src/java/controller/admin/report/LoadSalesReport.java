package controller.admin.report;

import entity.Product;
import java.io.IOException;
import java.util.ArrayList;
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


@WebServlet(name = "LoadSalesReport", urlPatterns = {"/pages/admin/LoadSalesReport"})
public class LoadSalesReport extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all products in database
            Query query = em.createQuery("SELECT oi.prodId, SUM(oi.orderItemQuantity) FROM OrderItem oi GROUP BY oi.prodId ORDER BY SUM(oi.orderItemQuantity) DESC");

            if(request.getParameter("LeastReport") != null){
                query = em.createQuery("SELECT oi.prodId, SUM(oi.orderItemQuantity) FROM OrderItem oi GROUP BY oi.prodId ORDER BY SUM(oi.orderItemQuantity)");
                request.setAttribute("filter", "true");
            }
            
            query.setMaxResults(5);
            List<Object[]> salesList = query.getResultList();

            List<ProductSales> productList = new ArrayList<>();
            for (Object[] result : salesList) {
                Product prodId = (Product) result[0];
                long salesCount = (long) result[1];
                ProductSales productSales = new ProductSales(prodId, salesCount);
                productList.add(productSales);
            }

            request.setAttribute("productList", productList);
            
            
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/report.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception ex){
            response.sendRedirect("../../pages/error.jsp?errorMsg="+ex.getMessage());
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
