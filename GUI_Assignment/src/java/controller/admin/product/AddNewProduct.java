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

@WebServlet(name = "AddNewProduct", urlPatterns = {"/pages/admin/AddNewProduct"})
public class AddNewProduct extends HttpServlet {

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
        
        request.setAttribute("ROOT_PATH", "../../");

        //Forward Page
        response.sendRedirect("LoadProduct?addNewAction=true");
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

        try {
            String prodName = (String)request.getParameter("addNew_prodName");
            String prodBrand = (String)request.getParameter("addNew_prodBrand");
            double prodPrice = Double.parseDouble(request.getParameter("addNew_prodPrice"));
            String prodDesc = (String)request.getParameter("addNew_prodDesc");
            String type = (String)request.getParameter("addNew_type");
            // Begin transaction
            utx.begin();

            // Create and persist Product entity
            Product product = new Product();
            product.setProdName(prodName);
            product.setProdBrand(prodBrand);
            product.setProdPrice(prodPrice);
            product.setProdDescription(prodDesc);
            product.setProdType(type);

            em.persist(product);

            // Commit transaction
            utx.commit();

            successMsg="Product ID "+product.getProdId()+" ("+product.getProdName()+") CREATED Successfully!";
        } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg=e.getMessage();
            }
            errorMsg += ex.getMessage();

            forwardPage=false;
            //error page
            response.sendRedirect("../../pages/error.jsp?errorMsg="+errorMsg);
        }

        if(forwardPage){
            String url = "LoadProduct";
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
