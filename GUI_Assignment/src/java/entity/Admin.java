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
@Table(name = "admin")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Admin.findAll", query = "SELECT a FROM Admin a"),
    @NamedQuery(name = "Admin.findByAdminid", query = "SELECT a FROM Admin a WHERE a.adminid = :adminid"),
    @NamedQuery(name = "Admin.findByFullname", query = "SELECT a FROM Admin a WHERE a.fullname = :fullname"),
    @NamedQuery(name = "Admin.findByPhonenum", query = "SELECT a FROM Admin a WHERE a.phonenum = :phonenum"),
    @NamedQuery(name = "Admin.findByPosition", query = "SELECT a FROM Admin a WHERE a.position = :position"),
    @NamedQuery(name = "Admin.findByPermission", query = "SELECT a FROM Admin a WHERE a.permission = :permission")})
public class Admin implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ADMINID")
    private Integer adminid;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "FULLNAME")
    private String fullname;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "PHONENUM")
    private String phonenum;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "POSITION")
    private String position;
    @Basic(optional = false)
    @NotNull
    @Column(name = "PERMISSION")
    private int permission;
    @JoinColumn(name = "USERID", referencedColumnName = "USERID")
    @ManyToOne
    private User userid;

    public Admin() {
    }

    public Admin(Integer adminid) {
        this.adminid = adminid;
    }

    public Admin(Integer adminid, String fullname, String phonenum, String position, int permission) {
        this.adminid = adminid;
        this.fullname = fullname;
        this.phonenum = phonenum;
        this.position = position;
        this.permission = permission;
    }

    public Integer getAdminid() {
        return adminid;
    }

    public void setAdminid(Integer adminid) {
        this.adminid = adminid;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhonenum() {
        return phonenum;
    }

    public void setPhonenum(String phonenum) {
        this.phonenum = phonenum;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public int getPermission() {
        return permission;
    }

    public void setPermission(int permission) {
        this.permission = permission;
    }

    public User getUserid() {
        return userid;
    }

    public void setUserid(User userid) {
        this.userid = userid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (adminid != null ? adminid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Admin)) {
            return false;
        }
        Admin other = (Admin) object;
        if ((this.adminid == null && other.adminid != null) || (this.adminid != null && !this.adminid.equals(other.adminid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Admin[ adminid=" + adminid + " ]";
    }
    
}
