/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import entity.Admin;
import entity.Customer;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;


@WebServlet(name = "ValidateLogin", urlPatterns = {"/pages/ValidateLogin"})
public class ValidateLogin extends HttpServlet {
    
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
        response.sendRedirect("../UserLogin.jsp");
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
                
            String account = request.getParameter("account");  
            String password = request.getParameter("password"); 
            
            try {
                // Query to search for a user based on search value
                Query query = em.createQuery("SELECT u FROM User u WHERE u.userName = :input OR u.userEmail = :input");
                query.setParameter("input", account);
                User user  = (User) query.getSingleResult();

                if((user.getUserPassword()).equals(password)){
                    HttpSession session = request.getSession();
                    
                    //STORE USER INFO INFO TO SESSION
                    session.setAttribute("userName",user.getUserName());
                    session.setAttribute("userEmail",user.getUserEmail());
                    
                    // Query to check if user is a customer
                    Query custQuery = em.createQuery("SELECT c FROM Customer c WHERE c.userId.userId = :userId");
                    custQuery.setParameter("userId", user.getUserId());
                    try {
                        Customer customer = (Customer) custQuery.getSingleResult();
                        session.setAttribute("customerId", customer.getCustId());
                        session.setAttribute("userPermission", 1);
                        response.sendRedirect("../home.jsp?successLogin=true");
                    } catch (NoResultException ex) {
                        // User is not a customer, check if user is an admin
                        Query adminQuery = em.createQuery("SELECT a FROM Admin a WHERE a.userId.userId = :userId");
                        adminQuery.setParameter("userId", user.getUserId());
                        try {
                            Admin admin = (Admin) adminQuery.getSingleResult();
                            session.setAttribute("adminId", admin.getAdminId());
                            session.setAttribute("userPermission", 0);
                            response.sendRedirect("admin/dashboard.jsp");
                        } catch (NoResultException ex2) {
                            // User is not a customer or an admin
                            session.removeAttribute("userName");
                            session.removeAttribute("userEmail");
                            
                            // TODO: Handle this case (redirect to error page)
                        }
                    }
                } 
            } catch (NoResultException ex) {
                //No Result found
                response.sendRedirect("UserLogin.jsp?loginFail=true");
                
            } catch (Exception ex2) {
                // TODO: Handle this case (redirect to error page)
            }
            
            if (!response.isCommitted()) {
                response.sendRedirect("../UserLogin.jsp");
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
