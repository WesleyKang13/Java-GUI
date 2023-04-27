/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import entity.Customer;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
                
            String acountName = request.getParameter("acountName");  
            String password = request.getParameter("password"); 
            
            System.out.println("acountName: " + acountName); 
            
           
            User user  = (User)em.createNamedQuery("User.findByUserEmail").setParameter("acountName", acountName).getSingleResult();
            
             String passwordDB = user.getUserPassword();
             System.out.println("password: " + passwordDB); 
            if((user.getUserPassword()).equals(password)){
                HttpSession session = request.getSession();  
                session.setAttribute("acountName",acountName);
                
                //TODO 1: STORE USER NAME INFO TO SESSION
               int userPermission = integer.parseInt
                session.setAttribute("userName",user.getUserName());
                session.setAttribute("userName",user.getUserEmail());
                session.setAttribute("userName",user.getUserEmail());
                
                
                //TODO 2: CHECK THIS USER IS CUSTOMER OR ADMIN BY USING USER ID
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
