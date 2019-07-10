package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import entity.user;

public class logindao {
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
       
       //根据姓名查找用户表，用于用户登陆校验
       public user findByName(String name){
    	   user use=new user();
    	   try {
			conn=DriverManager.getConnection(url, username, password);
			String sql="select * from user where user=?";
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, name);
			rs=stmt.executeQuery();
			if(rs.next()){
				use.setId(rs.getInt("id"));
				use.setUser(rs.getString("user"));
				use.setPasswd(rs.getString("passwd"));
				return use;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    	   return null;
       }
}
