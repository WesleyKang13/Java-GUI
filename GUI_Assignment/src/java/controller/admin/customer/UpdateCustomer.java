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

@WebServlet(name = "AdminUpdateCustomer", urlPatterns = {"/pages/admin/UpdateCustomer"})
public class UpdateCustomer extends HttpServlet {

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
        response.sendRedirect("LoadCustomer");
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
        
        String custId = (String)request.getParameter("edit_Id");
        String custUserName = (String)request.getParameter("edit_userName");
        String custFullName = (String)request.getParameter("edit_fullName");
        String custPhoneNum = (String)request.getParameter("edit_phoneNum");
        String custEmail = (String)request.getParameter("edit_email");
        String custShippingAddress = (String)request.getParameter("edit_shippingAddress");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<h1>"+custId+"</h1>");
//            out.println("<h1>"+custUserName+"</h1>");
//            out.println("<h1>"+custFullName+"</h1>");
//            out.println("<h1>"+custPhoneNum+"</h1>");
//            out.println("<h1>"+custEmail+"</h1>");
//            out.println("<h1>"+custShippingAddress+"</h1>");
//        }
        
        try {
            // Begin transaction
            utx.begin();

            // Find User and Customer entities to be updated
            Customer customer = em.find(Customer.class, Integer.valueOf(custId));
            User user = customer.getUserId();

            // Update fields in entities
            user.setUserName(custUserName);
            user.setUserEmail(custEmail);
            customer.setCustFullName(custFullName);
            customer.setCustPhoneNum(custPhoneNum);
            customer.setCustShippingAddress(custShippingAddress);

            // Commit transaction
            utx.commit();

            successMsg="Customer ID "+customer.getCustId()+" ("+customer.getCustFullName()+") UPDATED Successfully!";
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
