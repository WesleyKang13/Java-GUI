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

@WebServlet(name = "AddNewStaff", urlPatterns = {"/pages/admin/AddNewStaff"})
public class AddNewStaff extends HttpServlet {

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
        response.sendRedirect("LoadStaff?addNewAction=true");
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
        String staffUserName = (String)request.getParameter("addNew_userName");
        String staffPassword = (String)request.getParameter("addNew_password");
        String staffFullName = (String)request.getParameter("addNew_fullName");
        String staffPhoneNum = (String)request.getParameter("addNew_phoneNum");
        String staffEmail = (String)request.getParameter("addNew_email");
        String staffPosition = (String)request.getParameter("addNew_position");
        String staffPermission = (String)request.getParameter("addNew_permission");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;

        try {
            // Begin transaction
            utx.begin();

            // Create and Update User fields
            User user = new User();
            user.setUserName(staffUserName);
            user.setUserEmail(staffEmail);
            user.setUserPassword(staffPassword);

            // Persist User entity to generate userId
            em.persist(user);
            em.flush(); // flush changes to the database to generate the id

            // Create and Update Staff entity with generated userId
            Admin admin = new Admin();
            admin.setAdminFullName(staffFullName);
            admin.setAdminPhoneNum(staffPhoneNum);
            admin.setAdminPosition(staffPosition);
            admin.setAdminPermission(Integer.valueOf(staffPermission));
            admin.setUserId(user); // set the generated user id as the foreign key

            // Persist Staff entity
            em.persist(admin);

            // Commit transaction
            utx.commit();
            
            successMsg="Admin ID "+admin.getAdminId()+" ("+admin.getAdminFullName()+") CREATED Successfully!";
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
