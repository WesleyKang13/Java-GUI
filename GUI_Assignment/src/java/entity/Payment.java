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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "PAYMENT")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Payment.findAll", query = "SELECT p FROM Payment p"),
    @NamedQuery(name = "Payment.findByPaytId", query = "SELECT p FROM Payment p WHERE p.paytId = :paytId"),
    @NamedQuery(name = "Payment.findByPaytTotalAmount", query = "SELECT p FROM Payment p WHERE p.paytTotalAmount = :paytTotalAmount"),
    @NamedQuery(name = "Payment.findByPaytMethod", query = "SELECT p FROM Payment p WHERE p.paytMethod = :paytMethod"),
    @NamedQuery(name = "Payment.findByPaytDate", query = "SELECT p FROM Payment p WHERE p.paytDate = :paytDate")})
public class Payment implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "PAYT_ID")
    private Integer paytId;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "PAYT_TOTAL_AMOUNT")
    private Double paytTotalAmount;
    @Size(max = 20)
    @Column(name = "PAYT_METHOD")
    private String paytMethod;
    @Column(name = "PAYT_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date paytDate;
    @OneToMany(mappedBy = "paytId")
    private List<CustOrder> custOrderList;

    public Payment() {
    }

    public Payment(Integer paytId) {
        this.paytId = paytId;
    }

    public Integer getPaytId() {
        return paytId;
    }

    public void setPaytId(Integer paytId) {
        this.paytId = paytId;
    }

    public Double getPaytTotalAmount() {
        return paytTotalAmount;
    }

    public void setPaytTotalAmount(Double paytTotalAmount) {
        this.paytTotalAmount = paytTotalAmount;
    }

    public String getPaytMethod() {
        return paytMethod;
    }

    public void setPaytMethod(String paytMethod) {
        this.paytMethod = paytMethod;
    }

    public Date getPaytDate() {
        return paytDate;
    }

    public void setPaytDate(Date paytDate) {
        this.paytDate = paytDate;
    }

    @XmlTransient
    public List<CustOrder> getCustOrderList() {
        return custOrderList;
    }

    public void setCustOrderList(List<CustOrder> custOrderList) {
        this.custOrderList = custOrderList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (paytId != null ? paytId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Payment)) {
            return false;
        }
        Payment other = (Payment) object;
        if ((this.paytId == null && other.paytId != null) || (this.paytId != null && !this.paytId.equals(other.paytId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Payment[ paytId=" + paytId + " ]";
    }
    
}
