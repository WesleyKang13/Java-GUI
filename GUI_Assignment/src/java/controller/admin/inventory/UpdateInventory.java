package controller.admin.inventory;

import entity.Inventory;
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

@WebServlet(name = "AdminUpdateInventory", urlPatterns = {"/pages/admin/UpdateInventory"})
public class UpdateInventory extends HttpServlet {

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
        response.sendRedirect("LoadInventory");
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
//            out.println("<h1>"+invId+"</h1>");
//            out.println("<h1>"+invProdId+"</h1>");
//            out.println("<h1>"+invQuantity+"</h1>");
//            out.println("<h1>"+invColor+"</h1>");
//            out.println("<h1>"+invSize+"</h1>");
//        }
        
        try {
            String invId = (String)request.getParameter("edit_Id");
            String invProdId = (String)request.getParameter("edit_invProduct");
            String invQuantity = (String)request.getParameter("edit_invQuantity");
            String invColor = (String)request.getParameter("edit_invColor");
            String invSize = (String)request.getParameter("edit_invSize");
            
            // Begin transaction
            utx.begin();

            // Find Product entity to be updated
            Inventory inventory = em.find(Inventory.class, Integer.valueOf(invId));
            Product prod = em.find(Product.class, Integer.valueOf(invProdId));

            // Update fields in entities
            inventory.setProdId(prod);
            inventory.setInvQuantity(Integer.valueOf(invQuantity));
            inventory.setInvColor(invColor);
            inventory.setInvShoeSize(Double.valueOf(invSize));

            // Commit transaction
            utx.commit();

            successMsg = "Iventory ID " + inventory.getInvId()+ " UPDATED Successfully!";
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
            String url = "LoadInventory";
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
