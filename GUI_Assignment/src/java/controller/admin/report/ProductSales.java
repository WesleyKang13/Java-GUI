
package controller.admin.report;

import entity.Product;

public class ProductSales {
    private Product productId;
    private long salesCount;
    
    public ProductSales() {
    }
    
    public ProductSales(Product productId, long salesCount) {
        this.productId = productId;
        this.salesCount = salesCount;
    }
    
    // getters and setters
    public Product getProductId() {
        return productId;
    }
    
    public void setProductId(Product productId) {
        this.productId = productId;
    }
    
    public long getSalesCount() {
        return salesCount;
    }
    
    public void setSalesCount(int salesCount) {
        this.salesCount = salesCount;
    }
}