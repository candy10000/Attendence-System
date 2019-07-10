package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entity.EmployeeList;

public class CheckReportDao {

	//连接数据库
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
  
	//查找考勤表的全部信息
	public List<EmployeeList> findall() {
		List<EmployeeList> clocks = new ArrayList<EmployeeList>();
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select * from checkreport";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			//遍历查询的结果
			while (rs.next()) {
				EmployeeList clock = new EmployeeList();
				clock.setBdate(rs.getString("bdate"));
				clock.setEdate(rs.getString("edate"));
				clock.setCclock(rs.getString("cclock"));

				sql = "select  name from employees where id = " + "'" + rs.getString("cclock") + "'";
				stmt = conn.prepareStatement(sql);
				rs1 = stmt.executeQuery();
				rs1.next();
				clock.setName(rs1.getString("name"));
				clock.setState(rs.getString("state"));

				clocks.add(clock);
			}

			return clocks;
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}
    
	//根据员工的编号查找信息
	public List<EmployeeList> getClockById(Map<String, String> map) {
		List<EmployeeList> clocks = new ArrayList<EmployeeList>();
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select * from checkreport where cclock =" + "'" + map.get("cclock") + "'";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			while (rs.next()) {

				String[] str = rs.getString("bdate").replace(" ", "-").split("-");
				String[] str1 = rs.getString("edate").replace(" ", "-").split("-");

				if (str[1].startsWith("0")) {
					str[1] = str[1].substring(1);

				}

				if (str[1].equals(map.get("month"))) {

					if (str[2].startsWith("0")) {
						str[2] = str[2].substring(1);
					}

					if (str1[2].startsWith("0")) {
						str1[2] = str1[2].substring(1);
					}
                        
					if (Integer.parseInt(str[2]) >= Integer.parseInt(map.get("bday"))
							&& Integer.parseInt(str1[2]) <= Integer.parseInt(map.get("eday"))) {
						EmployeeList clock = new EmployeeList();
						clock.setBdate(rs.getString("bdate"));
						clock.setEdate(rs.getString("edate"));
						clock.setCclock(rs.getString("cclock"));
						sql = "select  name from employees where id = " + "'" + rs.getString("cclock") + "'";
						stmt = conn.prepareStatement(sql);
						rs1 = stmt.executeQuery();
						rs1.next();
						clock.setName(rs1.getString("name"));
						clock.setState(rs.getString("state"));
						clocks.add(clock);
					}
				}
			}

			return clocks;
		} catch (Exception e) {

			e.printStackTrace();
		}
		return null;
	}
    
	//搜索相应id中出勤的情况
	public float getCount(Map<String, String> map) {
		float unatten = 0;
		int total = 0;
		List<EmployeeList> clocks = new ArrayList<EmployeeList>();
		Map map1 = new HashMap<String, String>();
		try {
			conn = DriverManager.getConnection(url, username, password);
			String sql = "select * from checkreport where cclock =" + "'" + map.get("id") + "'";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
          
			//�������鲢�ж�
			while (rs.next()) {
				total++;
				
				map1 = getStrings(rs.getString("bdate"));
				
				//判断年月 统计其状态的数量
				if ((map1.get("year").equals(map.get("year") )) && (map1.get("month").equals( map.get("month")))) {
					System.out.println("state");
					if (rs.getString("state").equals("�쳣")) {
						System.out.println("state");
						unatten++;
					}
				}
			}
			System.out.println(total);
		    System.out.println(unatten);
		    
		    //计算未出勤使得概率
			unatten = unatten/total;
			return unatten;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	//分割日期时间
	public Map<String, String> getStrings(String sb) {
		Map map = new HashMap<String, String>();
		String[] str = sb.toString().replace(" ", "-").split("-");

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
