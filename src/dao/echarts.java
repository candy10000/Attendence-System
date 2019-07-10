package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class echarts {
	private String url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=UTF-8";
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

    //获取相应打卡状态和编码的记录总数
   public int getTotalCount(String state,String people) throws SQLException{
    	
        conn=DriverManager.getConnection(url, username, password);
    	String sql="select count(*) from checkreport where state =? and cclock=?";
    	stmt=conn.prepareStatement(sql);
    	//Long count=stmt.executeUpdate();
    	stmt.setString(1, state);
    	stmt.setString(2, people);
    	rs=stmt.executeQuery();
    	int count = 0;
    	if(rs.next()){
    		count=rs.getInt(1);
    	}
    	System.out.println(count);
    	return count;
    	
    }


}
