package controller.admin.product;

import entity.CustOrder;
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

@WebServlet(name = "UpdateProduct", urlPatterns = {"/pages/admin/UpdateProduct"})
public class UpdateProduct extends HttpServlet {

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
        response.sendRedirect("LoadOrder");
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
        
        String orderId = (String)request.getParameter("edit_Id");
        String shippingAddress = (String)request.getParameter("edit_shippingAddress");
        String status = (String)request.getParameter("edit_status");
        String errorMsg="";
        String successMsg="";
        boolean forwardPage = true;
        
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<h1>"+orderId+"</h1>");
//            out.println("<h1>"+shippingAddress+"</h1>");
//            out.println("<h1>"+status+"</h1>");
//        }
        
        try {
            // Begin transaction
            utx.begin();

            // Find Order entity to be updated
            CustOrder order = em.find(CustOrder.class, Integer.valueOf(orderId));

            // Update fields in entities
            order.setOrderShippingAddress(shippingAddress);
            order.setOrderStatus(status);

            // Commit transaction
            utx.commit();

            successMsg="Order ID "+order.getOrderId()+" by "+order.getCustId().getCustFullName()+") UPDATED Successfully!";
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
            String url = "LoadOrder";
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
