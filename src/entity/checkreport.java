package entity;

public class checkreport {
	String cclock;//员工编号
	String bdate;//开始时间
	String creson;//原因
	String state;//状态
	String edate;//结束时间
	int cid;//数据库中的自增数
	public String getCclock() {
		return cclock;
	}
	public void setCclock(String cclock) {
		this.cclock = cclock;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getCreson() {
		return creson;
	}
	public void setCreson(String creson) {
		this.creson = creson;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
		
	

}
