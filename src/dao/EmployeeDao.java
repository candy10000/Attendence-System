/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.Employee;
import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;

import entity.PageBean;

public interface EmployeeDao {

	//若数据存在则更新员工表，若不存在则插入新纪录
    public boolean storeEmployee(Employee employee) throws Exception;

    //获取员工表总记录数
    public int getTotalCount() throws Exception;
    
    //通过姓名模糊查询员工表记录，用于模糊搜索
    public List<Employee> findByName(String name)throws Exception;
    
    //根据当前页码获取员工表指定位置的记录，实现分页显示
    public List<Employee> findAll(PageBean<Employee> pb) throws Exception;

    //根据id查找员工表数据
    public Employee findById(String id) throws Exception;

    //删除员工表中指定id的一条记录
    public void delete(String id) throws Exception;

    //删除员工表中指定id的多条记录
    public void deleteAll(String[] ids) throws Exception;

    //定义导出excel的格式和数据
    public Workbook output() throws Exception;
}
