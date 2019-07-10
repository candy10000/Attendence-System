package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import entity.buka;


public class bukadao {
	private String url="jdbc:mysql://localhost:3306/test";
	private String username="root";
	private String password="123456";

	private Connection conn=null;
	private PreparedStatement stmt=null;
	private ResultSet rs=null;

	//连接数据库
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//将时间转换成String类型
	public String getStringdate(Date date){
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time=formatter.format(date);
		
		return time;
	}
	
	//将String类型的时间转换成Date型
	public Date getdate(String date) throws ParseException{
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date time=formatter.parse(date);
		return time;
	}

	//查找补卡表中的所有记录
	public List<buka> findall(){
		List<buka> people=new ArrayList<buka>();
		try {
			conn=DriverManager.getConnection(url, username, password);
			String sql="select * from repaircard";
			stmt=conn.prepareStatement(sql);
			rs=stmt.executeQuery();
			while(rs.next()){
				buka depart=new buka();
				depart.setRid(rs.getInt("rid"));
				depart.setRempid(rs.getString("rempid"));
				String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("rdate"));
				depart.setRdate(time);
				depart.setRreson(rs.getString("rreson"));
				people.add(depart);

			}
			System.out.println(people);
			return people;
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return null;
	}

	//查找补卡表中指定id的记录
	public void delete(int id) throws SQLException{
		conn=DriverManager.getConnection(url, username, password);
		String sql = "delete from repaircard where rid=?";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, id);
		stmt.executeUpdate();
	}

	//在补卡表中新增指定记录
	 public void add(buka people) throws SQLException, ParseException{
	    	conn=DriverManager.getConnection(url, username, password);
			String sql = "insert repaircard(rempid,rdate,rreson)values(?,?,?)";
			stmt=conn.prepareStatement(sql);
			//stmt.setInt(1, people.getRid());
			stmt.setString(1, people.getRempid());
			//Date time=this.getdate(people.getRdate());
			//System.out.print(time);
			
			//stmt.setDate(2, people.getRdate());
			stmt.setString(2, people.getRdate());
			System.out.print(people.getRdate());
			stmt.setString(3, people.getRreson());
			
			stmt.executeUpdate();
	    }

}

