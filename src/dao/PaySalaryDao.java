package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import entity.EmployeePS;

public class PaySalaryDao {
	//初始化变量
	private String url = "jdbc:mysql://localhost:3306/test";
	private String username = "root";
	private String password = "123456";

	private Connection conn = null;
	private PreparedStatement stmt = null;
	private ResultSet rs = null, rs1 = null;
	
	//加载数据库的驱动
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//按照搜索的限制条件搜索
	public List<EmployeePS> search(String msg) {
		
		List<EmployeePS> employees = new ArrayList<EmployeePS>();
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select psid,psempid,name,pssalary,psstime,psetime from paysalary,employees where psempid = id and psempid = ?";
			stmt = conn.prepareStatement(sql);
		    stmt.setString(1, msg);
			rs = stmt.executeQuery();
			while (rs.next()) {
				EmployeePS employee = new EmployeePS();

				employee.setPsid(rs.getString("psid"));
				employee.setPsempid(rs.getString("psempid"));
				employee.setName(rs.getString("name"));
				employee.setPssalary(rs.getString("pssalary"));
				employee.setPsstime(rs.getString("psstime"));
				employee.setPsetime(rs.getString("psetime"));
				employees.add(employee);
			}

			return employees;
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}
	
	
	//保存数据
   public void save(Map<String, String>  map) {
	
	   try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "insert into paysalary(psempid,psstime,psetime,pssalary) value(?,?,?,?)";
			stmt = conn.prepareStatement(sql);
			
			
			stmt.setString(1, map.get("id"));
			stmt.setString(2, map.get("bdate"));
			stmt.setString(3, map.get("edate"));
			stmt.setString(4, map.get("money"));
			
			stmt.execute();
             
		} catch (Exception e) {

			e.printStackTrace();
		}
   }
	
	
	//计算员工的薪水
	public double countMoney(String id, String bdate, String edate) {
		double money = 0;
		int totalMoney = 0,totaltime = 0;
        Map<String, String> map,map1;
        map = getStrings(bdate);
		map1 = getStrings(edate);
		if ( map.get("month").equals(map1.get("month")) ) {
			totaltime =  Integer.parseInt(map1.get("day")) - Integer.parseInt(map.get("day"));
		}else {
			totaltime = (getdays(bdate) - Integer.parseInt(map.get("day")) ) + Integer.parseInt(map1.get("day")) ;
		}
		
		String sql = "select sum(t.hours)totaltime from checkreport t WHERE  t.cclock = ? and DATE_FORMAT(t.bdate,'%Y-%m-%d') <= ? and DATE_FORMAT(t.bdate,'%Y-%m-%d') >= ? ";
		try {
			conn = DriverManager.getConnection(url, username, password);

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(3, bdate);
			stmt.setString(2, edate);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				totalMoney = Integer.parseInt(rs.getString("totaltime"));
				System.out.println(rs.getString("totaltime"));
			}
   
			
            money  = (totaltime*50)*((totalMoney*1.0)/(totaltime*9));
           
		} catch (Exception e) {

			e.printStackTrace();
		}

		return money;
	}

	//根据输入的id检查是否存在
	public boolean checkId(String id) {
		boolean flag = false;

		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select * from employees where  id =?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				flag = true;
			}

			System.out.println(rs);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return flag;
	}

	//根据id删除记录
	public boolean delById(String id, String eid) {
		boolean flag = false;
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "delete  from paysalary where psid=? and psempid =?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(2, eid);
			stmt.setInt(1, Integer.parseInt(id));
			flag = stmt.execute();

		} catch (Exception e) {

			e.printStackTrace();
		}

		return flag;
	}

	//查找全部记录
	public List<EmployeePS> findall() {
		List<EmployeePS> employees = new ArrayList<EmployeePS>();
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select psid,psempid,name,pssalary,psstime,psetime from paysalary,employees where psempid = id";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				EmployeePS employee = new EmployeePS();

				employee.setPsid(rs.getString("psid"));
				employee.setPsempid(rs.getString("psempid"));
				employee.setName(rs.getString("name"));
				employee.setPssalary(rs.getString("pssalary"));
				employee.setPsstime(rs.getString("psstime"));
				employee.setPsetime(rs.getString("psetime"));
				employees.add(employee);
			}

			return employees;
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}
	
	//֪获取某年某月的天数
	public int  getdays(String date ) {
		int days = 0;
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		Calendar rightNow = Calendar.getInstance();
		
		try {
			rightNow.setTime(simpleDate.parse(date));
			days = rightNow.getActualMaximum(Calendar.DAY_OF_MONTH);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return days;
	}
	
	
	
	
	//切割日期时间
	public Map<String, String> getStrings(String sb) {
		Map map = new HashMap<String, String>();
		String[] str = sb.split("-");

		// �ж��·�ǰ�Ƿ�Ϊ0��ͷ
		if (str[1].startsWith("0")) {
			// ȥ��0
			str[1] = str[1].substring(1);
		}

		// �ж���Ϊ0��ͷ
		if (str[2].startsWith("0")) {
			// ȥ��0
			str[2] = str[2].substring(1);
		}

		map.put("year", str[0]);
		map.put("month", str[1]);
		map.put("day", str[2]);
//		System.out.println(str[0]);
//		System.out.println(str[1]);
//		System.out.println(str[2]);
		
		return map;
	}
}
