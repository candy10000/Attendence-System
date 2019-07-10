package entity;

public class EmployeeList {
  
	 int cid ;//数据库中的自增id
	 String state;//状态
	 String cclock;//员工编号
	 String name;//员工名字
	 String creson;//原因
	 String bdate;//开始时间
	 String edate;//结束时间
	 
	 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCclock() {
		return cclock;
	}
	public void setCclock(String cclock) {
		this.cclock = cclock;
	}
	public String getCreson() {
		return creson;
	}
	public void setCreson(String creson) {
		this.creson = creson;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}
	
 @Override
public String toString() {
	// TODO Auto-generated method stub
	return cclock+name +bdate+edate+state+creson;
}
	
	 
	 
}
