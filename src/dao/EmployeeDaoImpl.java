/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import db.DBConnection;
import entity.Employee;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import entity.PageBean;

/**
 * 实现EmployeeDao接口的类.但是不负责数据库的打开和关闭
 *
 */
public class EmployeeDaoImpl implements EmployeeDao {

    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private DBConnection dbcn = null;

    //通过构造方法取得数据库连接
    public EmployeeDaoImpl() {
        try {
            dbcn = new DBConnection();
            conn = dbcn.getConnection();
        } catch (Exception e) {

        }
    }

  //若数据存在则更新员工表，若不存在则插入新纪录
    @Override
    public boolean storeEmployee(Employee employee) throws Exception {
        boolean flag = false;
        if (findById(employee.getId()) == null) {
            String sql = "insert into employees(id,name,sex,age,nation,cardID,salary,tel,sation_ID,detail) values(?,?,?,?,?,?,?,?,?,?)";
            this.pstmt = this.conn.prepareStatement(sql);
            this.pstmt.setString(1, employee.getId());
            this.pstmt.setString(2, employee.getName());
            this.pstmt.setString(3, employee.getSex());
            this.pstmt.setInt(4, employee.getAge());
            this.pstmt.setString(5, employee.getNation());
            this.pstmt.setString(6, employee.getCardID());
            this.pstmt.setString(7, employee.getSalary());
            this.pstmt.setString(8, employee.getTel());
            this.pstmt.setString(9, employee.getSation_ID());
            this.pstmt.setString(10, employee.getDetail());
        } else {
            String sql = "update employees set name=?,sex=?,age=?,nation=?,cardID=?,salary=?,tel=?,sation_ID=?,detail=? where id=?";
            this.pstmt = this.conn.prepareStatement(sql);
            this.pstmt.setString(10, employee.getId());
            this.pstmt.setString(1, employee.getName());
            this.pstmt.setString(2, employee.getSex());
            this.pstmt.setInt(3, employee.getAge());
            this.pstmt.setString(4, employee.getNation());
            this.pstmt.setString(5, employee.getCardID());
            this.pstmt.setString(6, employee.getSalary());
            this.pstmt.setString(7, employee.getTel());
            this.pstmt.setString(8, employee.getSation_ID());
            this.pstmt.setString(9, employee.getDetail());
        }
        if (this.pstmt.executeUpdate() > 0) {
            flag = true;
        }
        this.pstmt.close();
        return flag;
    }

  //获取员工表总记录数
    @Override
    public int getTotalCount() throws SQLException {

        String sql = "select count(*) from employees";
        pstmt = conn.prepareStatement(sql);
        //Long count=stmt.executeUpdate();
        ResultSet rs = this.pstmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }

    //根据当前页码获取员工表指定位置的记录，实现分页显示
    @Override
    public List<Employee> findAll(PageBean<Employee> pb) throws Exception {
        int totalCount = this.getTotalCount();
        pb.setTotalCount(totalCount);

        if (pb.getCurrentPage() <= 0) {
            pb.setCurrentPage(1);                        // 把当前页设置为1
        } else if (pb.getCurrentPage() > pb.getTotalPage()) {
            pb.setCurrentPage(pb.getTotalPage());        // 把当前页设置为最大页数
        }
        int currentPage = pb.getCurrentPage();
        int index = (currentPage - 1) * pb.getPageCount();        // 查询的起始行
        int count = pb.getPageCount();

        List<Employee> list = new ArrayList<>();
        String sql = "select * from employees limit ?,?";
        this.pstmt = this.conn.prepareStatement(sql);
        pstmt.setInt(1, index);
        pstmt.setInt(2, count);
        ResultSet rs = this.pstmt.executeQuery();
        Employee employee = null;
        while (rs.next()) {
            employee = new Employee();
            employee.setEmp_id(rs.getInt(1));
            employee.setId(rs.getString(2));
            employee.setName(rs.getString(3));
            employee.setSex(rs.getString(4));
            employee.setAge(rs.getInt(5));
            employee.setNation(rs.getString(6));
            employee.setCardID(rs.getString(7));
            employee.setSalary(rs.getString(8));
            employee.setTel(rs.getString(9));
            employee.setSation_ID(rs.getString(10));
            employee.setDetail(rs.getString(11));
            list.add(employee);
        }
        this.pstmt.close();
        return list;
    }


  //根据id查找员工表数据
    @Override
    public Employee findById(String id) throws Exception {
        Employee employee = null;
        String sql = "select emp_id,id,name,sex,age,nation,sation_ID from employees where id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, id);
        ResultSet rs = this.pstmt.executeQuery();
        while (rs.next()) {
            employee = new Employee();
            employee.setEmp_id(rs.getInt(1));
            employee.setId(rs.getString(2));
            employee.setName(rs.getString(3));
            employee.setSex(rs.getString(4));
            employee.setAge(rs.getInt(5));
            employee.setNation(rs.getString(6));
            employee.setSation_ID(rs.getString(7));
        }
        this.pstmt.close();
        return employee;
    }

  //删除员工表中指定id的一条记录
    @Override
    public void delete(String id) throws Exception {
        String sql = "delete from employees where id=?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, id);
        this.pstmt.executeUpdate();
        this.pstmt.close();
    }

  //删除员工表中指定id的多条记录
    @Override
    public void deleteAll(String[] ids) throws Exception {
        String sql = null;
        for (int i = 0; i < ids.length; i++) {
            sql = "delete from employees where id=?";
            this.pstmt = this.conn.prepareStatement(sql);
            this.pstmt.setString(1, ids[i]);
            this.pstmt.executeUpdate();
            this.pstmt.close();
        }
    }

  //通过姓名模糊查询员工表记录，用于模糊搜索
    @Override
    public List<Employee> findByName(String name) throws Exception {
        List<Employee> list = new ArrayList<>();
        String sql = "select emp_id,id,name,sex,age,nation,sation_ID from employees where name like ?";
        this.pstmt = this.conn.prepareStatement(sql);
        this.pstmt.setString(1, '%' + name + '%');
        ResultSet rs = this.pstmt.executeQuery();
        Employee employee = null;
        while (rs.next()) {
            employee = new Employee();
            employee.setEmp_id(rs.getInt(1));
            employee.setId(rs.getString(2));
            employee.setName(rs.getString(3));
            employee.setSex(rs.getString(4));
            employee.setAge(rs.getInt(5));
            employee.setNation(rs.getString(6));
            employee.setSation_ID(rs.getString(7));
            list.add(employee);
        }
        this.pstmt.close();
        return list;
    }

  //定义导出excel的格式和数据
	@Override
	public Workbook output() throws Exception {
		String sql="select * from employees";
		pstmt=conn.prepareStatement(sql);
		ResultSet rs=pstmt.executeQuery();
		Workbook xssfWorkbook = new XSSFWorkbook();
        //生成一个表格
        XSSFSheet xssfSheet = (XSSFSheet) xssfWorkbook.createSheet("员工信息");
        //产生表格标题行
        XSSFRow row = xssfSheet.createRow(0);
        //每列信息
        row.createCell(0).setCellValue("ID");
        row.createCell(1).setCellValue("员工编码");
        row.createCell(2).setCellValue("姓名");
        row.createCell(3).setCellValue("性别");
        row.createCell(4).setCellValue("年龄");
        row.createCell(5).setCellValue("民族");
        row.createCell(6).setCellValue("身份证号码");        
        row.createCell(7).setCellValue("薪资");
        row.createCell(8).setCellValue("手机号码");
        row.createCell(9).setCellValue("岗位");       
        row.createCell(10).setCellValue("备注");
        int index = 1;

        while (rs.next()) {
            //下一行开始
            row = xssfSheet.createRow(index++);
            //每列信息
            row.createCell(0).setCellValue(rs.getInt(1));
            row.createCell(1).setCellValue(rs.getString(2));
            row.createCell(2).setCellValue(rs.getString(3));
            row.createCell(3).setCellValue(rs.getString(4));
            row.createCell(4).setCellValue(rs.getInt(5));
            row.createCell(5).setCellValue(rs.getString(6));
            row.createCell(6).setCellValue(rs.getString(7));
            row.createCell(7).setCellValue(rs.getString(8));
            row.createCell(8).setCellValue(rs.getString(9));
            row.createCell(9).setCellValue(rs.getString(10));
            row.createCell(10).setCellValue(rs.getString(11));
        }
		return xssfWorkbook;	
	}
}
