package controller.admin.product;

import entity.Product;
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

@WebServlet(name = "UpdateProduct", urlPatterns = {"/pages/admin/UpdateProduct"})
public class UpdateProduct extends HttpServlet {

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
        response.sendRedirect("LoadProduct");
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
        
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<h1>"+orderId+"</h1>");
//            out.println("<h1>"+prodName+"</h1>");
//            out.println("<h1>"+prodBrand+"</h1>");
//            out.println("<h1>"+prodPrice+"</h1>");
//            out.println("<h1>"+prodDesc+"</h1>");
//            out.println("<h1>"+type+"</h1>");
//        }
        
        try {
            String prodId = (String)request.getParameter("edit_Id");
            String prodName = (String)request.getParameter("edit_prodName");
            String prodBrand = (String)request.getParameter("edit_prodBrand");
            String prodPrice = (String)request.getParameter("edit_prodPrice");
            String prodDesc = (String)request.getParameter("edit_prodDesc");
            String type = (String)request.getParameter("edit_type");
            // Begin transaction
            utx.begin();

            // Find Product entity to be updated
            Product product = em.find(Product.class, Integer.valueOf(prodId));

            // Update fields in entities
            product.setProdName(prodName);
            product.setProdBrand(prodBrand);
            product.setProdPrice(Double.valueOf(prodPrice));
            product.setProdDescription(prodDesc);
            product.setProdType(type);

            // Commit transaction
            utx.commit();

            successMsg = "Product ID " + product.getProdId() + " UPDATED Successfully!";
        } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg = e.getMessage();
            }
            errorMsg += ex.getMessage();

            forwardPage = false;
            //error page
            response.sendRedirect("../../pages/error.jsp?errorMsg="+errorMsg);
        }

        if (forwardPage) {
            String url = "LoadProduct";
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
