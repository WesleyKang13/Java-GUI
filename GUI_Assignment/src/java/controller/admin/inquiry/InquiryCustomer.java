/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin.inquiry;

import entity.Inquiry;
import java.io.IOException;
import java.util.Date;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
@WebServlet(name = "InquiryCustomer", urlPatterns = {"/pages/InquiryCustomer"})
public class InquiryCustomer extends HttpServlet {

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
        
        {
        response.setContentType("text/html;charset=UTF-8");
       
        }
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
        try{
            // Begin transaction
            utx.begin();
            
            //Get value from form
            String name = (String)request.getParameter("name");
            String email = (String)request.getParameter("email");
            String subject = (String)request.getParameter("subject");
            String description = (String)request.getParameter("message");

            Inquiry inquiry = new Inquiry();
            inquiry.setInqName(name);
            inquiry.setInqEmail(email);
            inquiry.setInqSubject(subject);
            inquiry.setInqDescription(description);
            inquiry.setInqCreatedDate(new Date());

            em.persist(inquiry);
            
            // Commit transaction
            utx.commit();
            
        }catch (Exception ex) {
            try {
                // Rollback transaction
                utx.rollback();
                errorMsg = ex.getMessage();
            } catch (Exception e) {
                errorMsg += e.getMessage();
            }
            response.sendRedirect("../../pages/error.jsp?errorMsg="+errorMsg);
        }
        
        
//        request.setAttribute("name", name);
//        request.setAttribute("email", email);
//        request.setAttribute("subject", subject);
//        request.setAttribute("message", description);
//          
       // Set the success message attribute
        String successMessage = "Your message has been sent successfully!";
        request.setAttribute("successMessage", successMessage);

        // Forward the request to contactUs.jsp
        request.getRequestDispatcher("contactUs.jsp").forward(request, response);
        
//        RequestDispatcher dispatcher = request.getRequestDispatcher("contactUs.jsp");
//        dispatcher.forward(request, response);
        
    }
        
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
