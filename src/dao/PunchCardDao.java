/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.PunchCard;
import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;

import entity.PageBean;

public interface PunchCardDao {

	//若数据存在则更新打卡表，若不存在则插入新纪录
    public boolean storePunchCard(PunchCard punchCard) throws Exception;

    //获取打卡表总记录数
    public int getTotalCount() throws Exception;
    
    //通过姓名模糊查询打卡表记录，用于模糊搜索
    public List<PunchCard> findByName(String pnote)throws Exception;
    
    //根据当前页码获取打卡表指定位置的记录，实现分页显示
    public List<PunchCard> findAll(PageBean<PunchCard> pb) throws Exception;
    
    //获取打卡表所有记录
    public List<PunchCard> findAll() throws Exception;

    //根据id查找打卡表数据
    public PunchCard findById(int pId) throws Exception;

    //删除打卡表中指定id的一条记录
    public void delete(int pId) throws Exception;

    //删除打卡表中指定id的多条记录
    public void deleteAll(int[] pIds) throws Exception;
    
    //定义导出excel的格式和数据
    public Workbook output() throws Exception;

}
