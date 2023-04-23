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

@WebServlet(name = "AddNewInventory", urlPatterns = {"/pages/admin/AddNewInventory"})
public class AddNewInventory extends HttpServlet {

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
        response.sendRedirect("LoadInventory?addNewAction=true");
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
        String prodId = (String)request.getParameter("addNew_prodId");
        int invQuantity = Integer.parseInt(request.getParameter("addNew_invQuantity"));
        String invColor = (String) request.getParameter("addNew_invColor");
        double invSize = Double.parseDouble(request.getParameter("addNew_invSize"));
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;

        try {
            // Begin transaction
            utx.begin();
            
            // Find inventory 
            Product prod = em.find(Product.class, Integer.valueOf(prodId));

            // Create and persist Product entity
            Inventory inventory = new Inventory();
            inventory.setProdId(prod);
            inventory.setInvQuantity(invQuantity);
            inventory.setInvColor(invColor);
            inventory.setInvShoeSize(invSize);
            em.persist(inventory);

            // Commit transaction
            utx.commit();

            successMsg="New Inventory ID "+inventory.getInvId()+" CREATED Successfully!";
        } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg="Error Occurred: Please try again. ("+e.getMessage()+")";
                throw new ServletException(e);
            }
            errorMsg += "Error Occurred: Please try again. ("+ex.getMessage()+")";

            forwardPage=false;
            //error page
            throw new ServletException(ex);
        }

        if(forwardPage){
            String url = "LoadInventory";
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
