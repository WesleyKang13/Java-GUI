/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "CUST_ORDER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CustOrder.findAll", query = "SELECT c FROM CustOrder c"),
    @NamedQuery(name = "CustOrder.findByOrderId", query = "SELECT c FROM CustOrder c WHERE c.orderId = :orderId"),
    @NamedQuery(name = "CustOrder.findByOrderShippingAddress", query = "SELECT c FROM CustOrder c WHERE c.orderShippingAddress = :orderShippingAddress"),
    @NamedQuery(name = "CustOrder.findByDate", query = "SELECT c FROM CustOrder c WHERE c.date = :date")})
public class CustOrder implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ORDER_ID")
    private Integer orderId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 150)
    @Column(name = "ORDER_SHIPPING_ADDRESS")
    private String orderShippingAddress;
    @Column(name = "DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;
    @JoinColumn(name = "CUST_ID", referencedColumnName = "CUST_ID")
    @ManyToOne
    private Customer custId;
    @JoinColumn(name = "PAYT_ID", referencedColumnName = "PAYT_ID")
    @ManyToOne
    private Payment paytId;
    @OneToMany(mappedBy = "orderId")
    private List<OrderItem> orderItemList;

    public CustOrder() {
    }

    public CustOrder(Integer orderId) {
        this.orderId = orderId;
    }

    public CustOrder(Integer orderId, String orderShippingAddress) {
        this.orderId = orderId;
        this.orderShippingAddress = orderShippingAddress;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderShippingAddress() {
        return orderShippingAddress;
    }

    public void setOrderShippingAddress(String orderShippingAddress) {
        this.orderShippingAddress = orderShippingAddress;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Customer getCustId() {
        return custId;
    }

    public void setCustId(Customer custId) {
        this.custId = custId;
    }

    public Payment getPaytId() {
        return paytId;
    }

    public void setPaytId(Payment paytId) {
        this.paytId = paytId;
    }

    @XmlTransient
    public List<OrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderId != null ? orderId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CustOrder)) {
            return false;
        }
        CustOrder other = (CustOrder) object;
        if ((this.orderId == null && other.orderId != null) || (this.orderId != null && !this.orderId.equals(other.orderId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.CustOrder[ orderId=" + orderId + " ]";
    }
    
}
