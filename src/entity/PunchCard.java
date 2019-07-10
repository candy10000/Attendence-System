/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

public class PunchCard {

	private int pId;//自增ID
	private String pclock;//员工编号
	private String pnote;//员工姓名
	private String ptime;//打卡时间

	public int getpId() {
		return pId;
	}

	public void setpId(int pId) {
		this.pId = pId;
	}

	public String getPclock() {
		return pclock;
	}

	public void setPclock(String pclock) {
		this.pclock = pclock;
	}

	public String getPtime() {
		return ptime;
	}

	public void setPtime(String date) {
		this.ptime = date;
	}

	public String getPnote() {
		return pnote;
	}

	public void setPnote(String pnote) {
		this.pnote = pnote;
	}

}
