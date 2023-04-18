/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "product_inventory")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ProductInventory.findAll", query = "SELECT p FROM ProductInventory p"),
    @NamedQuery(name = "ProductInventory.findByInventoryid", query = "SELECT p FROM ProductInventory p WHERE p.inventoryid = :inventoryid"),
    @NamedQuery(name = "ProductInventory.findByQuantity", query = "SELECT p FROM ProductInventory p WHERE p.quantity = :quantity"),
    @NamedQuery(name = "ProductInventory.findByColor", query = "SELECT p FROM ProductInventory p WHERE p.color = :color"),
    @NamedQuery(name = "ProductInventory.findBySize", query = "SELECT p FROM ProductInventory p WHERE p.size = :size")})
public class ProductInventory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "INVENTORYID")
    private Integer inventoryid;
    @Basic(optional = false)
    @NotNull
    @Column(name = "QUANTITY")
    private int quantity;
    @Size(max = 20)
    @Column(name = "COLOR")
    private String color;
    @Column(name = "SIZE")
    private Integer size;
    @JoinColumn(name = "PRODUCTID", referencedColumnName = "PRODUCTID")
    @ManyToOne
    private Product productid;

    public ProductInventory() {
    }

    public ProductInventory(Integer inventoryid) {
        this.inventoryid = inventoryid;
    }

    public ProductInventory(Integer inventoryid, int quantity) {
        this.inventoryid = inventoryid;
        this.quantity = quantity;
    }

    public Integer getInventoryid() {
        return inventoryid;
    }

    public void setInventoryid(Integer inventoryid) {
        this.inventoryid = inventoryid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Product getProductid() {
        return productid;
    }

    public void setProductid(Product productid) {
        this.productid = productid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (inventoryid != null ? inventoryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ProductInventory)) {
            return false;
        }
        ProductInventory other = (ProductInventory) object;
        if ((this.inventoryid == null && other.inventoryid != null) || (this.inventoryid != null && !this.inventoryid.equals(other.inventoryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.ProductInventory[ inventoryid=" + inventoryid + " ]";
    }
    
}
