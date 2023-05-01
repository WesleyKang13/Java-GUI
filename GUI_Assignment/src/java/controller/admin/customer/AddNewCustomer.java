package controller.admin.customer;

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
import javax.transaction.UserTransaction;

@WebServlet(name = "AdminAddNewCustomer", urlPatterns = {"/pages/admin/AddNewCustomer"})
public class AddNewCustomer extends HttpServlet {

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
        response.sendRedirect("LoadCustomer?addNewAction=true");
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
            String custUserName = (String)request.getParameter("addNew_userName");
            String custPassword = (String)request.getParameter("addNew_password");
            String custFullName = (String)request.getParameter("addNew_fullName");
            String custPhoneNum = (String)request.getParameter("addNew_phoneNum");
            String custEmail = (String)request.getParameter("addNew_email");
            String custShippingAddress = (String)request.getParameter("addNew_shippingAddress");
            
            // Begin transaction
            utx.begin();

            // Create and Update User fields
            User user = new User();
            user.setUserName(custUserName);
            user.setUserEmail(custEmail);
            user.setUserPassword(custPassword);

            // Persist User entity to generate userId
            em.persist(user);
            em.flush(); // flush changes to the database to generate the id

            // Create and Update Customer entity with generated userId
            Customer customer = new Customer();
            customer.setCustFullName(custFullName);
            customer.setCustPhoneNum(custPhoneNum);
            customer.setCustShippingAddress(custShippingAddress);
            customer.setUserId(user); // set the generated user id as the foreign key

            // Persist Customer entity
            em.persist(customer);

            // Commit transaction
            utx.commit();
            
            successMsg="Customer ID "+customer.getCustId()+" ("+customer.getCustFullName()+") CREATED Successfully!";
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
            String url = "LoadCustomer";
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
