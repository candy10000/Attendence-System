/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author lenovo
 */
public class leave {

    int lid; //请假id
    String lname; //员工名字
    String lstime; //开始时间
    String letime; //结束时间
    String lnote; //请假原因
	
    public int getLid() {
        return lid;
    }

    public void setLid(int lid) {
        this.lid = lid;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getLstime() {
        return lstime;
    }

    public void setLstime(String lstime) {
        this.lstime = lstime;
    }

    public String getLetime() {
        return letime;
    }

    public void setLetime(String letime) {
        this.letime = letime;
    }

    public String getLnote() {
        return lnote;
    }

    public void setLnote(String lnote) {
        this.lnote = lnote;
    }


    
}
