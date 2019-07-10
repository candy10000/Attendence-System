/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author exg
 */
public class station {
    int stid; //岗位id
    String stcode; //岗位编码
    String stname; //岗位名称
    String stdepartment; //所在部门
    String stup;  //直接上级
    String stclass; //岗位类别
    String stnote; //岗位描述

    public int getStid() {
        return stid;
    }

    public void setStid(int stid) {
        this.stid = stid;
    }

    public String getStcode() {
        return stcode;
    }

    public void setStcode(String stcode) {
        this.stcode = stcode;
    }

    public String getStname() {
        return stname;
    }

    public void setStname(String stname) {
        this.stname = stname;
    }

    public String getStdepartment() {
        return stdepartment;
    }

    public void setStdepartment(String stdepartment) {
        this.stdepartment = stdepartment;
    }



    public String getStup() {
        return stup;
    }

    public void setStup(String stup) {
        this.stup = stup;
    }

    public String getStclass() {
        return stclass;
    }

    public void setStclass(String stclass) {
        this.stclass = stclass;
    }

    public String getStnote() {
        return stnote;
    }

    public void setStnote(String stnote) {
        this.stnote = stnote;
    }

   
}
