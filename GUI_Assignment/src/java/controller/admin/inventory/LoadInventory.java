package controller.admin.inventory;

import entity.Inventory;
import entity.Product;
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


@WebServlet(name = "AdminLoadInventory", urlPatterns = {"/pages/admin/LoadInventory/*"})
public class LoadInventory extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all products in database
            Query q = em.createNamedQuery("Inventory.findAllDescId");
            List<Inventory> InventoryList = q.getResultList();
            request.setAttribute("inventoryList", InventoryList);
            request.setAttribute("ROOT_PATH", "../../");
            
            // Get Product List
            List<Product> productList = em.createNamedQuery("Product.findAllDescId").getResultList();
            request.setAttribute("productList", productList);

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/inventory.jsp");
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
        request.setAttribute("ROOT_PATH", "../../../../");
        //Remove productList
        request.removeAttribute("productList");

        String[] pathParts = pathInfo.split("/");
        
        if (pathParts[1].equals("editInventoryID")) {
            // Find the inventory with the specified ID
            int editInventoryID = Integer.parseInt(pathParts[2]);
            Inventory editInventory = em.find(Inventory.class, editInventoryID);
            request.setAttribute("editInventory", editInventory);
            
            // Get Product List
            List<Product> productList = em.createNamedQuery("Product.findAllDescId").getResultList();
            request.setAttribute("productList", productList);
        }
        
        else if (pathParts[1].equals("search")) {
            // Get the search value from the request
            String searchValue = "";
            if (pathParts.length > 2) {
                searchValue = pathParts[2];
            }
            // Query to search for inventory based on product ID
            Query query = em.createQuery("SELECT i FROM Inventory i WHERE i.prodId.prodName LIKE :searchValue OR i.invColor LIKE :searchValue");
            query.setParameter("searchValue", "%" + searchValue + "%");
            
            // Execute the query and retrieve the result
            List<Inventory> inventoryList = query.getResultList();
            
            // Set the result as an attribute for the request
            request.setAttribute("inventoryList", inventoryList);
            request.setAttribute("searchValue", searchValue);
            
        }

        else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/inventory.jsp");
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
