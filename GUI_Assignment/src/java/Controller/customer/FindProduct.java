package controller.customer;

import entity.Product;
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

/**
 *
 * @Wesley
 */
@WebServlet(name = "FindProduct", urlPatterns = {"/pages/product/FindProduct"})
public class FindProduct extends HttpServlet {
    
     @PersistenceContext private EntityManager em;

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        try{
                
            Query q = em.createNamedQuery("Product.findAll");
            List<Product> productList = q.getResultList();
            request.setAttribute("productList", productList);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Products.jsp");
            dispatcher.forward(request, response);
            
        }catch(IOException | ServletException ex){
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<h1>Congratulation, you get an error!</h1>");
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
        
        String filterType = request.getParameter("productType");
        
        try {
            Query q;

           List<Product> productList = null;
        if (filterType == null) {
            // No filter selected, retrieve all products
             q = em.createNamedQuery("Product.findAll");
            productList = q.getResultList();
        } else {
            // Filter selected, retrieve products by type
            q = em.createNamedQuery("Product.findByProdType");
            q.setParameter("prodType", filterType);
            productList = q.getResultList();
        }

            request.setAttribute("productList", productList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("Products.jsp");
            dispatcher.forward(request, response);
        } catch(IOException | ServletException ex) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<h1>Congratulations, you have encountered an error!</h1>");
                out.println("<h1>"+ex.getMessage()+"</h1>");
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
        
        String searchName = request.getParameter("prodName");
        
        try{
            Query q = em.createQuery("Select p From Product p Where p.prodName LIKE :searchName OR p.prodBrand LIKE :searchName");
            q.setParameter("searchName", "%" + searchName + "%");
            List<Product> productList = q.getResultList();
            request.setAttribute("productList", productList);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("Products.jsp");
            dispatcher.forward(request, response);
        }catch(IOException | ServletException ex){
             try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<h1>Congratulation, you get an error!</h1>");
            out.println("<h1>"+ex.getMessage()+"</h1>");
        }
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
