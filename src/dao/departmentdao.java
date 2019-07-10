package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import entity.PageBean;
import entity.department;
import entity.user;

public class departmentdao {
	private static String url="jdbc:mysql://localhost:3306/test";
    private static String username="root";
    private static String password="123456";
    
    private static Connection conn=null;
    private PreparedStatement stmt=null;
    private ResultSet rs=null;
    //连接数据库
    static{
 	   try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
    //根据当前页码查找部门表中指定的记录数
    public List<department> findall(PageBean<department> pb) throws SQLException{
    	
    	int totalCount = this.getTotalCount();
    	pb.setTotalCount(totalCount);
    	
    	 if (pb.getCurrentPage() <=0) {
                pb.setCurrentPage(1);                        // 把当前页设置为1
    		 } else if (pb.getCurrentPage() > pb.getTotalPage()){
    		            pb.setCurrentPage(pb.getTotalPage());        // 把当前页设置为最大页数
    	     }
    	 int currentPage = pb.getCurrentPage();
         int index = (currentPage -1 ) * pb.getPageCount();        // 查询的起始行
         int count = pb.getPageCount();  
    	 
    	 
    	List<department> departs=new ArrayList<department>();
    	try {
			//conn=DriverManager.getConnection(url, username, password);
			String sql="select * from department limit ?,?";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, index);
			stmt.setInt(2, count);
			rs=stmt.executeQuery();
			while(rs.next()){
				department depart=new department();
				depart.setId(rs.getString("id"));
				depart.setDecode(rs.getString("decode"));
				depart.setDename(rs.getString("dename"));
				depart.setDeres(rs.getString("deres"));
				depart.setDeduty(rs.getString("deduty"));
				depart.setDeup(rs.getString("deup"));
				departs.add(depart);
			}
			//System.out.print(departs);
			return departs;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	//conn.close();
    	return null;
    }
    
    //向部门表添加一条记录
    public void add(department depart) throws SQLException{
    	
		String sql = "insert department(id,decode,dename,deres,deduty,deup)values(?,?,?,?,?,?)";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,depart.getId());
		stmt.setString(2, depart.getDecode());
		stmt.setString(3, depart.getDename());
		stmt.setString(4, depart.getDeres());
		stmt.setString(5, depart.getDeduty());
		stmt.setString(6, depart.getDeup());
		stmt.executeUpdate();
		//conn.close();
    }
    
    //删除一条部门表中指定id的数据
    public void delete(String id) throws SQLException{
    	//conn=DriverManager.getConnection(url, username, password);
		String sql = "delete from department where id=?";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,id);
		stmt.executeUpdate();
		//conn.close();
    }
    
    //获取部门表中总记录数
    public int getTotalCount() throws SQLException{
    	
        //conn=DriverManager.getConnection(url, username, password);
    	String sql="select count(*) from department";
    	stmt=conn.prepareStatement(sql);
    	//Long count=stmt.executeUpdate();
    	rs=stmt.executeQuery();
    	int count = 0;
    	if(rs.next()){
    		count=rs.getInt(1);
    	}
    	//conn.close();
    	return count;
    	
    }
        
    //更新部门表中指定记录的数据
    public void update(department depart) throws SQLException{
    	//conn=DriverManager.getConnection(url, username, password);
    	String sql="update department set id=?,decode=?,dename=?,deres=?,deduty=?,deup=? where id=?";
    	stmt=conn.prepareStatement(sql);
    	stmt.setString(1,depart.getId());
    	stmt.setString(2, depart.getDecode());
    	stmt.setString(3, depart.getDename());
    	stmt.setString(4, depart.getDeres());
    	stmt.setString(5, depart.getDeduty());
    	stmt.setString(6, depart.getDeup());
    	stmt.setString(7, depart.getId());
    	stmt.execute();
    	//conn.close();
    	return;

    }
    
    //根据id查找部门表中的记录
    public department findbyid(String id) throws SQLException{
    	//conn=DriverManager.getConnection(url, username, password);
    	String sql="select * from department where id=?";
    	stmt=conn.prepareStatement(sql);
    	stmt.setString(1, id);
    	department depart=new department();
    	rs=stmt.executeQuery();
    	if(rs.next()){
    		depart.setId(rs.getString("id"));
    		depart.setDecode(rs.getString("decode"));
    		depart.setDename(rs.getString("dename"));
    		depart.setDeres(rs.getString("deres"));
    		depart.setDeduty(rs.getString("deduty"));
    		depart.setDeup(rs.getString("deup"));
    	}
    	//conn.close();
    	return depart;
    }
    
    //根据提供的编号模糊查询部门表并返回查询结果
    public List<department> findmohu(String decode,PageBean<department> pb) throws SQLException{
    	List<department> departs=new ArrayList<department>();
    	//conn=DriverManager.getConnection(url, username, password);
    	
    	int totalCount = this.getTotalCount();
    	pb.setTotalCount(totalCount);
    	
    	 if (pb.getCurrentPage() <=0) {
                pb.setCurrentPage(1);                        // 把当前页设置为1
    		 } else if (pb.getCurrentPage() > pb.getTotalPage()){
    		            pb.setCurrentPage(pb.getTotalPage());        // 把当前页设置为最大页数
    	     }
    	 int currentPage = pb.getCurrentPage();
         int index = (currentPage -1 ) * pb.getPageCount();        // 查询的起始行
         int count = pb.getPageCount();  
    	
		String sql="select * from department where decode like ? limit ?,?";
		stmt=conn.prepareStatement(sql);
    	stmt.setString(1, "%"+decode+"%");
    	stmt.setInt(2, index);
    	stmt.setInt(3, count);
    	
    	rs=stmt.executeQuery();
		while(rs.next()){
			department depart=new department();
			depart.setId(rs.getString("id"));
			depart.setDecode(rs.getString("decode"));
			depart.setDename(rs.getString("dename"));
			depart.setDeres(rs.getString("deres"));
			depart.setDeduty(rs.getString("deduty"));
			depart.setDeup(rs.getString("deup"));
			departs.add(depart);
		}
		System.out.print(departs);
		//conn.close();
		return departs;
    }
    
    //新建导出Excel表的样式及内容
    public HSSFWorkbook output(){
    	List<department> departs=new ArrayList<department>();
    	try {
			//conn=DriverManager.getConnection(url, username, password);
			String sql="select * from department";
			stmt=conn.prepareStatement(sql);
			rs=stmt.executeQuery();
			
			HSSFWorkbook hssfWorkbook = new HSSFWorkbook();
            //生成一个表格-->表名为"部门信息"
            HSSFSheet hssfSheet = hssfWorkbook.createSheet("部门信息");
            //产生表格标题行
            HSSFRow row = hssfSheet.createRow(0);
            //每列信息
            row.createCell(0).setCellValue("id");
            row.createCell(1).setCellValue("部门编码");
            row.createCell(2).setCellValue("部门名称");
            row.createCell(3).setCellValue("部门负责人");
            row.createCell(4).setCellValue("部门责任");
            row.createCell(5).setCellValue("上级部门");
            
            int index = 1;

            while (rs.next()) {
                //下一行开始
                row = hssfSheet.createRow(index++);
                //每列信息
                row.createCell(0).setCellValue(rs.getString("id"));
                row.createCell(1).setCellValue(rs.getString("decode"));
                row.createCell(2).setCellValue(rs.getString("dename"));
                row.createCell(3).setCellValue(rs.getString("deres"));
                row.createCell(4).setCellValue(rs.getString("deduty"));
                row.createCell(5).setCellValue(rs.getString("deup"));
            }

			System.out.print(departs);
			return hssfWorkbook;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
    	
    	return null;

    }
    
}
