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
@Table(name = "INQUIRY")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Inquiry.findAll", query = "SELECT i FROM Inquiry i"),
    @NamedQuery(name = "Inquiry.findByInqId", query = "SELECT i FROM Inquiry i WHERE i.inqId = :inqId"),
    @NamedQuery(name = "Inquiry.findByInqName", query = "SELECT i FROM Inquiry i WHERE i.inqName = :inqName"),
    @NamedQuery(name = "Inquiry.findByInqEmail", query = "SELECT i FROM Inquiry i WHERE i.inqEmail = :inqEmail"),
    @NamedQuery(name = "Inquiry.findByInqDescription", query = "SELECT i FROM Inquiry i WHERE i.inqDescription = :inqDescription"),
    @NamedQuery(name = "Inquiry.findByInqCreatedDate", query = "SELECT i FROM Inquiry i WHERE i.inqCreatedDate = :inqCreatedDate")})
public class Inquiry implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "INQ_ID")
    private Integer inqId;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "INQ_NAME")
    private String inqName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "INQ_EMAIL")
    private String inqEmail;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "INQ_DESCRIPTION")
    private String inqDescription;
    @Column(name = "INQ_CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date inqCreatedDate;

    public Inquiry() {
    }

    public Inquiry(Integer inqId) {
        this.inqId = inqId;
    }

    public Inquiry(Integer inqId, String inqName, String inqEmail, String inqDescription) {
        this.inqId = inqId;
        this.inqName = inqName;
        this.inqEmail = inqEmail;
        this.inqDescription = inqDescription;
    }

    public Integer getInqId() {
        return inqId;
    }

    public void setInqId(Integer inqId) {
        this.inqId = inqId;
    }

    public String getInqName() {
        return inqName;
    }

    public void setInqName(String inqName) {
        this.inqName = inqName;
    }

    public String getInqEmail() {
        return inqEmail;
    }

    public void setInqEmail(String inqEmail) {
        this.inqEmail = inqEmail;
    }

    public String getInqDescription() {
        return inqDescription;
    }

    public void setInqDescription(String inqDescription) {
        this.inqDescription = inqDescription;
    }

    public Date getInqCreatedDate() {
        return inqCreatedDate;
    }

    public void setInqCreatedDate(Date inqCreatedDate) {
        this.inqCreatedDate = inqCreatedDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (inqId != null ? inqId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Inquiry)) {
            return false;
        }
        Inquiry other = (Inquiry) object;
        if ((this.inqId == null && other.inqId != null) || (this.inqId != null && !this.inqId.equals(other.inqId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Inquiry[ inqId=" + inqId + " ]";
    }
    
}
