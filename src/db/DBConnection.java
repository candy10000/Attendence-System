/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;
 
import java.sql.Connection;
import java.sql.DriverManager;

//实现数据库连接的类
public class DBConnection {
    private static final String Driver="com.mysql.jdbc.Driver";
    private static final String Url="jdbc:mysql://127.0.0.1:3306/test";
    private static final String User="root";
    private static final String Password="123456";
    private Connection conn=null;
    
    //数据库连接
    public DBConnection() throws Exception{
        try{
            Class.forName(Driver);
            this.conn=DriverManager.getConnection(Url,User,Password);
        }
        catch (Exception e) {
            throw e;
        }
    }
    //获取数据库连接
    public Connection getConnection(){
        return this.conn;        
    }
    //关闭数据库
    public void close() throws Exception{
        if(this.conn!=null){
            try {
                this.conn.close();
                
            } catch (Exception e) {
                throw e;
            }
        }
    } 
}