package controller.admin.customer;

import entity.Customer;
import java.io.IOException;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "LoadCustomer", urlPatterns = {"/pages/admin/LoadCustomer/*"})
public class LoadCustomer extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all customers in database
            Query q = em.createNamedQuery("Customer.findAllDescId");
            List<Customer> customerList = q.getResultList();
            request.setAttribute("customerList", customerList);
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/customer.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception ex){
            //error
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

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) { //No action require
            processRequest(request, response);
            return;
        }

        boolean forwardPage = true;
        request.setAttribute("ROOT_PATH", "../../../../") ;
        //Remove customerList
        request.removeAttribute("customerList");

        String[] pathParts = pathInfo.split("/");
        if (pathParts[1].equals("editCustID")) {
            // Edit the customer with the specified ID
            int editCustID = Integer.parseInt(pathParts[2]);
            Customer editCustomer = em.find(Customer.class, editCustID);
            request.setAttribute("editCustomer", editCustomer);
        } else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/customer.jsp");
            dispatcher.forward(request, response);
        }
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
        processRequest(request, response);
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
