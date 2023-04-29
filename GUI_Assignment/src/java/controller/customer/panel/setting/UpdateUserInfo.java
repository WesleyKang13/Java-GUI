package controller.customer.panel.setting;

import entity.Customer;
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

@WebServlet(name = "CustomerUpdateUserInfo", urlPatterns = {"/pages/customer/panel/UpdateUserInfo"})
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
        
        int editID = (int) request.getSession().getAttribute("customerId");
        String custUserName = (String)request.getParameter("userName");
        String custPassword = (String)request.getParameter("password");
        String custFullName = (String)request.getParameter("fullName");
        String custPhoneNum = (String)request.getParameter("phoneNum");
        String custEmail = (String)request.getParameter("email");
        String custshippingAddress = (String)request.getParameter("shippingAddress");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
        try {
            // Begin transaction
            utx.begin();

            // Find User and Staff entities to be updated
            //Tempor user id
            Customer customer = em.find(Customer.class, editID);
            User user = customer.getUserId();

            // Update fields in entities
            user.setUserName(custUserName);
            if(custPassword != null && !"".equals(custPassword)){
                user.setUserPassword(custPassword);
            }
            user.setUserEmail(custEmail);
            customer.setCustFullName(custFullName);
            customer.setCustPhoneNum(custPhoneNum);
            customer.setCustShippingAddress(custshippingAddress);
            
            // Commit transaction
            utx.commit();
            
            
            //STORE USER INFO INFO TO SESSION
            HttpSession session = request.getSession();
            session.setAttribute("userName",user.getUserName());
            session.setAttribute("userEmail",user.getUserEmail());
            session.setAttribute("customerFullName",customer.getCustFullName());

            successMsg="Your information UPDATED Successfully!";
        } catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
            } catch (Exception e) {
                errorMsg = "Error Occurred: Please try again. (" + e.getMessage() + ")";
                throw new ServletException(e);
            }
            errorMsg += "Error Occurred: Please try again. (" + ex.getMessage() + ")";

            forwardPage = false;
            //error page
            throw new ServletException(ex);
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
