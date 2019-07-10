package entity;

public class EmployeePS {
	String psid;//编号，数据库中的自增值
	String psempid ;//员工编号
	String name;//员工名字
	String pssalary;//员工薪水
	String psstime;//工资的开始结算时间
	String psetime;//工资的结束结算时间
	
	
	
	public String getPsid() {
		return psid;
	}
	public void setPsid(String psid) {
		this.psid = psid;
	}
	public String getPsempid() {
		return psempid;
	}
	public void setPsempid(String psempid) {
		this.psempid = psempid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPssalary() {
		return pssalary;
	}
	public void setPssalary(String pssalary) {
		this.pssalary = pssalary;
	}
	public String getPsstime() {
		return psstime;
	}
	public void setPsstime(String psstime) {
		this.psstime = psstime;
	}
	public String getPsetime() {
		return psetime;
	}
	public void setPsetime(String psetime) {
		this.psetime = psetime;
	}
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return psempid + name + pssalary + psstime + psetime;
	}
	

}
