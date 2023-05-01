package controller.admin.staff;

import entity.Admin;
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


@WebServlet(name = "AdminLoadStaff", urlPatterns = {"/pages/admin/LoadStaff/*"})
public class LoadStaff extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all customers in database
            Query q = em.createNamedQuery("Admin.findAllDescId");
            List<Admin> staffList = q.getResultList();
            request.setAttribute("staffList", staffList);
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/staff.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception ex){
            response.sendRedirect("../../pages/error.jsp?errorMsg="+ex.getMessage());
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
        request.setAttribute("ROOT_PATH", "../../../../");
        //Remove customerList
        request.removeAttribute("staffList");

        String[] pathParts = pathInfo.split("/");
        if (pathParts[1].equals("editStaffID")) {
            // Edit the customer with the specified ID
            int editStaffID = Integer.parseInt(pathParts[2]);
            Admin editStaff = em.find(Admin.class, editStaffID);
            request.setAttribute("editStaff", editStaff);
        }
        
        
        else if (pathParts[1].equals("search")) {
            // Get the search value from the request
            String searchValue = "";
            if (pathParts.length > 2) {
                searchValue = pathParts[2];
            }
            // Query to search for a customer based on search value
            Query query = em.createQuery("SELECT a FROM Admin a JOIN a.userId u WHERE a.adminFullName LIKE :searchValue OR u.userName LIKE :searchValue OR a.adminPhoneNum LIKE :searchValue OR u.userEmail LIKE :searchValue OR a.adminPosition LIKE :searchValue");

            query.setParameter("searchValue", "%" + searchValue + "%");

            // Execute the query and retrieve the result
            List<Admin> staffList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("staffList", staffList);
            request.setAttribute("searchValue", searchValue);
        }
        
        else if (pathParts[1].equals("filter")) {
            // Get the status value from the request
            String filter = "";
            if (pathParts.length > 2) {
                filter = pathParts[2];
            }
            
            int permission = 0;
            if(filter.equals("ADMIN")){
                permission = 0;
            } else if(filter.equals("STAFF")){
                permission = 1;
            }
            
            // Query to search for orders based on the status
            Query query = em.createQuery("SELECT a FROM Admin a WHERE a.adminPermission = :permission");

            query.setParameter("permission", permission);

            // Execute the query and retrieve the result
            List<Admin> staffList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("staffList", staffList);
            request.setAttribute("filter", filter);
        }
        
        
        else {
            //error
            forwardPage = false;
            response.sendRedirect("../../pages/error.jsp?errorMsg=Wrong URL path");
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/staff.jsp");
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
