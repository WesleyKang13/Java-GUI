package controller.admin.product;

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


@WebServlet(name = "LoadProduct", urlPatterns = {"/pages/admin/LoadProduct/*"})
public class LoadProduct extends HttpServlet {
    @PersistenceContext EntityManager em;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            //Load all products in database
            Query q = em.createNamedQuery("Product.findAllDescId");
            List<Product> productList = q.getResultList();
            request.setAttribute("productList", productList);
            request.setAttribute("ROOT_PATH", "../../");

            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/product.jsp");
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
        
        if (pathParts[1].equals("editProductID")) {
            // Edit the product with the specified ID
            int editProductID = Integer.parseInt(pathParts[2]);
            Product editProduct = em.find(Product.class, editProductID);

            // Get the inventory list for the product being edited
            List<Inventory> inventoryList = em.createQuery("SELECT i FROM Inventory i WHERE i.prodId = :product", Inventory.class)
                .setParameter("product", editProduct)
                .getResultList();

            // Set the result as attributes for the request
            request.setAttribute("editProduct", editProduct);
            request.setAttribute("inventoryList", inventoryList);
        }
        
        else if (pathParts[1].equals("search")) {
            // Get the search value from the request
            String searchValue = "";
            if (pathParts.length > 2) {
            searchValue = pathParts[2];
            }
            // Query to search for a product based on search value
            Query query = em.createQuery("SELECT p FROM Product p WHERE p.prodName LIKE :searchValue OR p.prodBrand LIKE :searchValue");
            query.setParameter("searchValue", "%" + searchValue + "%");

            // Execute the query and retrieve the result
            List<Product> productList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("productList", productList);
            request.setAttribute("searchValue", searchValue);
        }
        
        
        else if (pathParts[1].equals("filter")) {
            // Get the search query from the request
            String filter = "";
            if (pathParts.length > 2) {
                filter = pathParts[2];
            }
            
            // Query to search for products based on their name or brand
            Query query = em.createQuery("SELECT p FROM Product p WHERE p.prodType LIKE :filter");
            query.setParameter("filter", filter);
            
            // Execute the query and retrieve the result
            List<Product> productList = query.getResultList();

            // Set the result as an attribute for the request
            request.setAttribute("productList", productList);
            request.setAttribute("filter", filter);
        }

        else {
            //error
            forwardPage = false;
        }

        if (forwardPage) {
            //Forward Page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/admin/product.jsp");
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
