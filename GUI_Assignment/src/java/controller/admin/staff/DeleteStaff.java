package controller.admin.staff;

import entity.Admin;
import entity.User;
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


@WebServlet(name = "AdminDeleteStaff", urlPatterns = {"/pages/admin/DeleteStaff"})
public class DeleteStaff extends HttpServlet {

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
        response.sendRedirect("LoadStaff");
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
        
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
        try {
            String staffId = (String)request.getParameter("deleteId");
            // Begin transaction
            utx.begin();
            
            // Find User and Staff entities to be deleted
            Admin admin = em.find(Admin.class, Integer.valueOf(staffId));
            User user = em.find(User.class, admin.getUserId().getUserId());
            
            //Delete rows of record
            if (admin != null) {
                // Delete the staff and user table
                em.remove(admin);
                em.remove(user);
            }
            
            // Commit transaction
            utx.commit();
            
            successMsg="Staff ID "+admin.getAdminId()+" ("+admin.getAdminFullName()+") DELETED Successfully!";
        }catch(Exception ex){
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
            String url = "LoadStaff";
            if(!successMsg.equals("")){
                url +="?successMsg=" + successMsg;
            }if(!errorMsg.equals("")){
                url +="?errorMsg=" + errorMsg;
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
