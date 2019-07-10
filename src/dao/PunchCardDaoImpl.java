/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import db.DBConnection;
import entity.PunchCard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import entity.PageBean;

/**
 * 实现PunchCardDao接口的类.但是不负责数据库的打开和关闭
 *
 */
public class PunchCardDaoImpl implements PunchCardDao {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private DBConnection dbcn = null;

	// 通过构造方法取得数据库连接
	public PunchCardDaoImpl() {
		try {
			dbcn = new DBConnection();
			conn = dbcn.getConnection();
		} catch (Exception e) {

		}
	}

	//若数据存在则更新打卡表，若不存在则插入新纪录
	@Override
	public boolean storePunchCard(PunchCard punchCard) throws Exception {
		boolean flag = false;
		if (findById(punchCard.getpId()) == null) {
			String sql = "insert into punchcard(pclock,pnote,ptime) values(?,?,?)";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, punchCard.getPclock());
			this.pstmt.setString(2, punchCard.getPnote());
			this.pstmt.setString(3, punchCard.getPtime());
		} else {
			String sql = "update punchard set pnote,ptime where pclock=?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(3, punchCard.getPclock());
			this.pstmt.setString(1, punchCard.getPnote());
			this.pstmt.setString(2, punchCard.getPtime());
		}
		if (this.pstmt.executeUpdate() > 0) {
			flag = true;
		}
		this.pstmt.close();
		return flag;
	}

	//获取打卡表总记录数
	@Override
	public int getTotalCount() throws SQLException {

		String sql = "select count(*) from punchcard";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		int count = 0;
		if (rs.next()) {
			count = rs.getInt(1);
		}
		return count;
	}

	//根据当前页码获取打卡表指定位置的记录，实现分页显示
	@Override
	public List<PunchCard> findAll(PageBean<PunchCard> pb) throws Exception {
		int totalCount = this.getTotalCount();
		pb.setTotalCount(totalCount);

		if (pb.getCurrentPage() <= 0) {
			pb.setCurrentPage(1); // 把当前页设置为1
		} else if (pb.getCurrentPage() > pb.getTotalPage()) {
			pb.setCurrentPage(pb.getTotalPage()); // 把当前页设置为最大页数
		}
		int currentPage = pb.getCurrentPage();
		int index = (currentPage - 1) * pb.getPageCount(); // 查询的起始行
		int count = pb.getPageCount();

		List<PunchCard> list = new ArrayList<>();
		String sql = "select pId,pclock,pnote,ptime from punchcard limit ?,?";
		this.pstmt = this.conn.prepareStatement(sql);
		pstmt.setInt(1, index);
		pstmt.setInt(2, count);
		ResultSet rs = this.pstmt.executeQuery();
		PunchCard punchCard = null;
		while (rs.next()) {
			punchCard = new PunchCard();
			punchCard.setpId(rs.getInt(1));
			punchCard.setPclock(rs.getString(2));
			punchCard.setPnote(rs.getString(3));
			String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(4));
			punchCard.setPtime(timeStamp);
			list.add(punchCard);
		}
		this.pstmt.close();
		return list;
	}

	//根据id查找打卡表数据
	@Override
	public PunchCard findById(int pId) throws Exception {
		PunchCard punchCard = null;
		String sql = "select pId,pclock,pnote,ptime from punchcard where pId=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, pId);
		ResultSet rs = this.pstmt.executeQuery();
		while (rs.next()) {
			punchCard = new PunchCard();
			punchCard.setpId(rs.getInt(1));
			punchCard.setPclock(rs.getString(2));
			punchCard.setPnote(rs.getString(3));
			String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(4));
			punchCard.setPtime(timeStamp);
		}
		this.pstmt.close();
		return punchCard;
	}

	//删除打卡表中指定id的一条记录
	@Override
	public void delete(int pId) throws Exception {
		String sql = "delete from punchcard where pId=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setInt(1, pId);
		this.pstmt.executeUpdate();
		this.pstmt.close();
	}

	//删除打卡表中指定id的多条记录
	@Override
	public void deleteAll(int[] pIds) throws Exception {
		String sql = null;
		for (int i = 0; i < pIds.length; i++) {
			sql = "delete from punchcard where pId=?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setInt(1, pIds[i]);
			this.pstmt.executeUpdate();
			this.pstmt.close();
		}
	}

	//通过姓名模糊查询打卡表记录，用于模糊搜索
	@Override
	public List<PunchCard> findByName(String pclock) throws Exception {
		List<PunchCard> list = new ArrayList<>();
		String sql = "select pId,pclock,pnote,ptime from punchcard where pclock=?";
		this.pstmt = this.conn.prepareStatement(sql);
		this.pstmt.setString(1, pclock);
		ResultSet rs = this.pstmt.executeQuery();
		PunchCard punchCard = null;
		while (rs.next()) {
			punchCard = new PunchCard();
			punchCard.setpId(rs.getInt(1));
			punchCard.setPclock(rs.getString(2));
			punchCard.setPnote(rs.getString(3));
			String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(4));
			punchCard.setPtime(timeStamp);
			list.add(punchCard);
		}
		this.pstmt.close();
		return list;
	}

	//获取打卡表所有记录
	@Override
	public List<PunchCard> findAll() throws Exception {
		List<PunchCard> list = new ArrayList<>();
		String sql = "select pId,pclock,pnote,ptime from punchcard";
		this.pstmt = this.conn.prepareStatement(sql);
		ResultSet rs = this.pstmt.executeQuery();
		PunchCard punchCard = null;
		while (rs.next()) {
			punchCard = new PunchCard();
			punchCard.setpId(rs.getInt(1));
			punchCard.setPclock(rs.getString(2));
			punchCard.setPnote(rs.getString(3));
			String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(4));
			punchCard.setPtime(timeStamp);
			list.add(punchCard);
		}
		this.pstmt.close();
		return list;
	}

	//定义导出excel的格式和数据
	@Override
	public Workbook output() throws Exception{
			String sql="select * from punchcard";
			pstmt=conn.prepareStatement(sql);
			ResultSet rs=pstmt.executeQuery();
			Workbook xssfWorkbook = new XSSFWorkbook();
            //生成一个表格
            XSSFSheet xssfSheet = (XSSFSheet) xssfWorkbook.createSheet("打卡信息");
            //产生表格标题行
            XSSFRow row = xssfSheet.createRow(0);
            //每列信息
            row.createCell(0).setCellValue("ID");
            row.createCell(1).setCellValue("员工编码");
            row.createCell(2).setCellValue("员工姓名");
            row.createCell(3).setCellValue("打卡时间");
            int index = 1;

            while (rs.next()) {
                //下一行开始
                row = xssfSheet.createRow(index++);
                //每列信息
                row.createCell(0).setCellValue(rs.getInt(1));
                row.createCell(1).setCellValue(rs.getString(2));
                row.createCell(2).setCellValue(rs.getString(3));
                String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(4));
                row.createCell(3).setCellValue(timeStamp);
            }
			return xssfWorkbook;			
	}

}
