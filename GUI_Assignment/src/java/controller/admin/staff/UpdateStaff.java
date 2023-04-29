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

@WebServlet(name = "AdminUpdateStaff", urlPatterns = {"/pages/admin/UpdateStaff"})
public class UpdateStaff extends HttpServlet {

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
        
        String staffId = (String)request.getParameter("edit_Id");
        String staffUserName = (String)request.getParameter("edit_userName");
        String staffFullName = (String)request.getParameter("edit_fullName");
        String staffPhoneNum = (String)request.getParameter("edit_phoneNum");
        String staffEmail = (String)request.getParameter("edit_email");
        String staffPosition = (String)request.getParameter("edit_position");
        String staffPermission = (String)request.getParameter("edit_permission");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<h1>"+staffId+"</h1>");
//            out.println("<h1>"+staffUserName+"</h1>");
//            out.println("<h1>"+staffFullName+"</h1>");
//            out.println("<h1>"+staffPhoneNum+"</h1>");
//            out.println("<h1>"+staffEmail+"</h1>");
//            out.println("<h1>"+staffPosition+"</h1>");
//            out.println("<h1>"+staffPermission+"</h1>");
//        }
        
        try {
            // Begin transaction
            utx.begin();

            // Find User and Staff entities to be updated
            Admin admin = em.find(Admin.class, Integer.valueOf(staffId));
            User user = admin.getUserId();

            // Update fields in entities
            user.setUserName(staffUserName);
            user.setUserEmail(staffEmail);
            admin.setAdminFullName(staffFullName);
            admin.setAdminPhoneNum(staffPhoneNum);
            admin.setAdminPosition(staffPosition);
            admin.setAdminPermission(Integer.valueOf(staffPermission));

            // Commit transaction
            utx.commit();

            successMsg="Staff ID "+admin.getAdminId()+" ("+admin.getAdminFullName()+") UPDATED Successfully!";
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
