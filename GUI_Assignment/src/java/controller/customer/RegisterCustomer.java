/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import entity.Customer;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.UserTransaction;

/**
 *
 * @author User
 */
@WebServlet(name = "RegisterCustomer", urlPatterns = {"/pages/customer/RegisterCustomer"})
public class RegisterCustomer extends HttpServlet {

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
        response.sendRedirect("CustomerRegister.jsp");
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
        
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String accEmail = request.getParameter("accEmail");
        String accIc = request.getParameter("accIc");
        String accPhone = request.getParameter("accPhone");
        String accPass = request.getParameter("accPass");
        String confirmPass = request.getParameter("confirmPass");
        String shippingAddress = request.getParameter("shippingAddress");
        String successMsg="";
        
        //validation user inputs
        //email regex(format)
        String emailRegex = "^([a-zA-Z0-9_\\.-]+)@([a-zA-Z0-9_\\.-]+)\\.([a-zA-Z]{2,5})$";
        boolean emailIsValid = accEmail.matches(emailRegex);
        

        PrintWriter out = response.getWriter();
        
            if(!emailIsValid){
                response.setContentType("text/html");
                out.println("<html><body>");
                out.println("<h2>Please enter a valid Email!</h2>");
                out.println("</body></html>");
                
            }
          
            
            if(accPhone.length() != 10 ){
                response.setContentType("text/html");
                out.println("<html><body>");
                out.println("<h2>Please enter a valid 10-digit phone number.</h2>");
                out.println("</body></html>");
              
            }
              
              
            if(!accPass.equals(confirmPass)){
                response.setContentType("text/html");
                out.println("<html><body>");
                out.println("<h2>The first password field does not match with the second password field!</h2>");
                out.println("</body></html>");
           
            }
             out.println("<a href='CustomerRegister.jsp'>Back to Register</a>");
                
        
        try{
            // Begin transaction
            utx.begin();

            // Create and Update User fields
            User user = new User();
            user.setUserEmail(accEmail);
            user.setUserName(username);
            user.setUserPassword(accPass);

            // Persist User entity to generate userId
            em.persist(user);
            em.flush(); // flush changes to the database to generate the id

            // Create and Update Customer entity with generated userId
            Customer customer = new Customer();
            customer.setCustFullName(fullname);
            customer.setCustPhoneNum(accPhone);
            customer.setCustShippingAddress(shippingAddress);
            customer.setUserId(user); // set the generated user id as the foreign key

            // Persist Customer entity
            em.persist(customer);

            // Commit transaction
            utx.commit();
            
            
            successMsg= "Welcome, "+customer.getCustFullName()+". Please Log In!";
        }catch(Exception ex){
            //error
        }
        
        
            //Set info and forward page
            request.setAttribute("registerSuccessful", successMsg);
            RequestDispatcher dispatcher = request.getRequestDispatcher("../UserLogin.jsp");

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
