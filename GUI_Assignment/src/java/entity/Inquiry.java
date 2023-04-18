/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author yapwa
 */
@Entity
@Table(name = "inquiry")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Inquiry.findAll", query = "SELECT i FROM Inquiry i"),
    @NamedQuery(name = "Inquiry.findByInquiryid", query = "SELECT i FROM Inquiry i WHERE i.inquiryid = :inquiryid"),
    @NamedQuery(name = "Inquiry.findByName", query = "SELECT i FROM Inquiry i WHERE i.name = :name"),
    @NamedQuery(name = "Inquiry.findByEmail", query = "SELECT i FROM Inquiry i WHERE i.email = :email"),
    @NamedQuery(name = "Inquiry.findByDescription", query = "SELECT i FROM Inquiry i WHERE i.description = :description"),
    @NamedQuery(name = "Inquiry.findByDate", query = "SELECT i FROM Inquiry i WHERE i.date = :date")})
public class Inquiry implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "INQUIRYID")
    private Integer inquiryid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "NAME")
    private String name;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "EMAIL")
    private String email;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "DESCRIPTION")
    private String description;
    @Column(name = "DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date date;

    public Inquiry() {
    }

    public Inquiry(Integer inquiryid) {
        this.inquiryid = inquiryid;
    }

    public Inquiry(Integer inquiryid, String name, String email, String description) {
        this.inquiryid = inquiryid;
        this.name = name;
        this.email = email;
        this.description = description;
    }

    public Integer getInquiryid() {
        return inquiryid;
    }

    public void setInquiryid(Integer inquiryid) {
        this.inquiryid = inquiryid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (inquiryid != null ? inquiryid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Inquiry)) {
            return false;
        }
        Inquiry other = (Inquiry) object;
        if ((this.inquiryid == null && other.inquiryid != null) || (this.inquiryid != null && !this.inquiryid.equals(other.inquiryid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Inquiry[ inquiryid=" + inquiryid + " ]";
    }
    
}
