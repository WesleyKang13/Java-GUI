/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
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
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "CUSTOMER")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c"),
    @NamedQuery(name = "Customer.findByCustId", query = "SELECT c FROM Customer c WHERE c.custId = :custId"),
    @NamedQuery(name = "Customer.findByCustFullName", query = "SELECT c FROM Customer c WHERE c.custFullName = :custFullName"),
    @NamedQuery(name = "Customer.findByCustPhoneNum", query = "SELECT c FROM Customer c WHERE c.custPhoneNum = :custPhoneNum"),
    @NamedQuery(name = "Customer.findByCustShippingAddress", query = "SELECT c FROM Customer c WHERE c.custShippingAddress = :custShippingAddress")})
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "CUST_ID")
    private Integer custId;
    @Size(max = 50)
    @Column(name = "CUST_FULL_NAME")
    private String custFullName;
    @Size(max = 20)
    @Column(name = "CUST_PHONE_NUM")
    private String custPhoneNum;
    @Size(max = 150)
    @Column(name = "CUST_SHIPPING_ADDRESS")
    private String custShippingAddress;
    @OneToMany(mappedBy = "custId")
    private List<CustOrder> custOrderList;
    @JoinColumn(name = "USER_ID", referencedColumnName = "USER_ID")
    @ManyToOne
    private User userId;
    @OneToMany(mappedBy = "custId")
    private List<Cart> cartList;

    public Customer() {
    }

    public Customer(Integer custId) {
        this.custId = custId;
    }

    public Integer getCustId() {
        return custId;
    }

    public void setCustId(Integer custId) {
        this.custId = custId;
    }

    public String getCustFullName() {
        return custFullName;
    }

    public void setCustFullName(String custFullName) {
        this.custFullName = custFullName;
    }

    public String getCustPhoneNum() {
        return custPhoneNum;
    }

    public void setCustPhoneNum(String custPhoneNum) {
        this.custPhoneNum = custPhoneNum;
    }

    public String getCustShippingAddress() {
        return custShippingAddress;
    }

    public void setCustShippingAddress(String custShippingAddress) {
        this.custShippingAddress = custShippingAddress;
    }

    @XmlTransient
    public List<CustOrder> getCustOrderList() {
        return custOrderList;
    }

    public void setCustOrderList(List<CustOrder> custOrderList) {
        this.custOrderList = custOrderList;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }

    @XmlTransient
    public List<Cart> getCartList() {
        return cartList;
    }

    public void setCartList(List<Cart> cartList) {
        this.cartList = cartList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (custId != null ? custId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Customer)) {
            return false;
        }
        Customer other = (Customer) object;
        if ((this.custId == null && other.custId != null) || (this.custId != null && !this.custId.equals(other.custId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Customer[ custId=" + custId + " ]";
    }
    
}
