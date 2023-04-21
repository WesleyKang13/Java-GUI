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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "PRODUCT_INVENTORY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Inventory.findAll", query = "SELECT i FROM Inventory i"),
    @NamedQuery(name = "Inventory.findByProductId", query = "SELECT i FROM Inventory i WHERE i.prodId = :prodId"),
    @NamedQuery(name = "Inventory.findByInvId", query = "SELECT i FROM Inventory i WHERE i.invId = :invId"),
    @NamedQuery(name = "Inventory.findByInvQuantity", query = "SELECT i FROM Inventory i WHERE i.invQuantity = :invQuantity"),
    @NamedQuery(name = "Inventory.findByInvColor", query = "SELECT i FROM Inventory i WHERE i.invColor = :invColor"),
    @NamedQuery(name = "Inventory.findByInvShoeSize", query = "SELECT i FROM Inventory i WHERE i.invShoeSize = :invShoeSize")})
public class Inventory implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "INV_ID")
    private Integer invId;
    @Column(name = "INV_QUANTITY")
    private Integer invQuantity;
    @Size(max = 20)
    @Column(name = "INV_COLOR")
    private String invColor;
    @Column(name = "INV_SHOE_SIZE")
    private Integer invShoeSize;
    @JoinColumn(name = "PROD_ID", referencedColumnName = "PROD_ID")
    @ManyToOne
    private Product prodId;

    public Inventory() {
    }

    public Inventory(Integer invId) {
        this.invId = invId;
    }

    public Integer getInvId() {
        return invId;
    }

    public void setInvId(Integer invId) {
        this.invId = invId;
    }

    public Integer getInvQuantity() {
        return invQuantity;
    }

    public void setInvQuantity(Integer invQuantity) {
        this.invQuantity = invQuantity;
    }

    public String getInvColor() {
        return invColor;
    }

    public void setInvColor(String invColor) {
        this.invColor = invColor;
    }

    public Integer getInvShoeSize() {
        return invShoeSize;
    }

    public void setInvShoeSize(Integer invShoeSize) {
        this.invShoeSize = invShoeSize;
    }

    public Product getProdId() {
        return prodId;
    }

    public void setProdId(Product prodId) {
        this.prodId = prodId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (invId != null ? invId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Inventory)) {
            return false;
        }
        Inventory other = (Inventory) object;
        if ((this.invId == null && other.invId != null) || (this.invId != null && !this.invId.equals(other.invId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Inventory[ invId=" + invId + " ]";
    }
    
}
