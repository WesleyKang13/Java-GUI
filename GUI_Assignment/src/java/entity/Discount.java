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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "discount")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Discount.findAll", query = "SELECT d FROM Discount d"),
    @NamedQuery(name = "Discount.findByDiscountid", query = "SELECT d FROM Discount d WHERE d.discountid = :discountid"),
    @NamedQuery(name = "Discount.findByName", query = "SELECT d FROM Discount d WHERE d.name = :name"),
    @NamedQuery(name = "Discount.findByDescription", query = "SELECT d FROM Discount d WHERE d.description = :description"),
    @NamedQuery(name = "Discount.findByPercent", query = "SELECT d FROM Discount d WHERE d.percent = :percent"),
    @NamedQuery(name = "Discount.findByAddeddate", query = "SELECT d FROM Discount d WHERE d.addeddate = :addeddate")})
public class Discount implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "DISCOUNTID")
    private Integer discountid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "NAME")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "DESCRIPTION")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PERCENT")
    private double percent;
    @Column(name = "ADDEDDATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date addeddate;
    @OneToMany(mappedBy = "discountid")
    private List<Payment> paymentList;

    public Discount() {
    }

    public Discount(Integer discountid) {
        this.discountid = discountid;
    }

    public Discount(Integer discountid, String name, String description, double percent) {
        this.discountid = discountid;
        this.name = name;
        this.description = description;
        this.percent = percent;
    }

    public Integer getDiscountid() {
        return discountid;
    }

    public void setDiscountid(Integer discountid) {
        this.discountid = discountid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public Date getAddeddate() {
        return addeddate;
    }

    public void setAddeddate(Date addeddate) {
        this.addeddate = addeddate;
    }

    @XmlTransient
    public List<Payment> getPaymentList() {
        return paymentList;
    }

    public void setPaymentList(List<Payment> paymentList) {
        this.paymentList = paymentList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (discountid != null ? discountid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Discount)) {
            return false;
        }
        Discount other = (Discount) object;
        if ((this.discountid == null && other.discountid != null) || (this.discountid != null && !this.discountid.equals(other.discountid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Discount[ discountid=" + discountid + " ]";
    }
    
}
