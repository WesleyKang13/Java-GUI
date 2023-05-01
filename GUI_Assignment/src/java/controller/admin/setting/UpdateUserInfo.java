package controller.admin.setting;

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
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;

@WebServlet(name = "AdminUpdateUserInfo", urlPatterns = {"/pages/admin/UpdateUserInfo"})
public class UpdateUserInfo extends HttpServlet {

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
        response.sendRedirect("LoadSetting");
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
            int adminId = (int) request.getSession().getAttribute("adminId");
            String adminUserName = (String)request.getParameter("userName");
            String adminPassword = (String)request.getParameter("password");
            String emailFullName = (String)request.getParameter("fullName");
            String emailPhoneNum = (String)request.getParameter("phoneNum");
            String emailEmail = (String)request.getParameter("email");
            // Begin transaction
            utx.begin();

            // Find User and Staff entities to be updated
            //Tempor user id
            Admin admin = em.find(Admin.class, adminId);
            User user = admin.getUserId();

            // Update fields in entities
            user.setUserName(adminUserName);
            if(adminPassword != null && !"".equals(adminPassword)){
                user.setUserPassword(adminPassword);
            }
            user.setUserEmail(emailEmail);
            admin.setAdminFullName(emailFullName);
            admin.setAdminPhoneNum(emailPhoneNum);

            // Commit transaction
            utx.commit();
            
            
            //STORE USER INFO INFO TO SESSION
            HttpSession session = request.getSession();
            session.setAttribute("userName",user.getUserName());
            session.setAttribute("userEmail",user.getUserEmail());
            session.setAttribute("adminFullName",admin.getAdminFullName());

            successMsg="Your information UPDATED Successfully!";
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
            String url = "LoadSetting";
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
