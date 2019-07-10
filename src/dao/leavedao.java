/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.PageBean;
import entity.leave;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lenovo
 */
public class leavedao {
     private String url = "jdbc:mysql://localhost:3306/test";
    private String username = "root";
    private String password = "123456";

    private Connection conn = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;
    //连接数据库
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
    //分段获取leaves表中的记录
     public List<leave> findall(PageBean<leave> pb) throws SQLException {
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
        List<leave> leas = new ArrayList<leave>();
        try {
            String sql = "select * from leaves limit ?,?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, index);
            stmt.setInt(2, count);
            rs = stmt.executeQuery();
            while (rs.next()) {
                leave lea = new leave();
                lea.setLid(rs.getInt("lid"));
                lea.setLname(rs.getString("lname"));
                lea.setLstime(rs.getString("lstime"));
                lea.setLetime(rs.getString("letime"));
                lea.setLnote(rs.getString("lnote"));
                leas.add(lea);
            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return leas;
    }
    
     //获取leaves表的总记录数
     public int getTotalCount() throws SQLException {

        conn = DriverManager.getConnection(url, username, password);
        String sql = "select count(*) from leaves";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;

    }
     
     //向leaves表中添加一条数据
    public void add(leave lea) throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "insert leaves(lname,lstime,letime,lnote)values(?,?,?,?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, lea.getLname());
        stmt.setString(2, lea.getLstime());
        stmt.setString(3, lea.getLetime());
        stmt.setString(4, lea.getLnote());
        stmt.executeUpdate();
        stmt.close();
    }

    //删除一条信息
    public void delete(int lid) throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "delete from leaves where lid=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, lid);
        stmt.executeUpdate();
        stmt.close();
    }

    //删除所有选中消息
    public void deleteAll(int[] lids) throws Exception {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "delete from leaves where lid=?";
        for (int i = 0; i < lids.length; i++) {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, lids[i]);
            stmt.executeUpdate();
            System.out.print(i);
        }
        stmt.close();
    }

    //更新leaves表信息
    public void updata(leave lea) throws Exception {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "update leaves set lid=?,lname=?,lstime=?,letime=?,lnote=? where lid=?";
        stmt = conn.prepareStatement(sql);
        try {   
            stmt.setInt(1, lea.getLid());
            stmt.setString(2, lea.getLname());
            stmt.setString(3, lea.getLstime());
            stmt.setString(4, lea.getLetime());
            stmt.setString(5, lea.getLnote());
            stmt.setInt(6, lea.getLid());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("update: edit update error");
            ex.printStackTrace();
        }
    }
    
    //得到姓名前缀相同的记录数
    public int getTotalCountname(String lname) throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "select count(*) from leaves where lname like ?";
        stmt = conn.prepareStatement(sql);
        //Long count=stmt.executeUpdate();
        stmt.setString(1, lname + '%');
        rs = stmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;
    }
    
    //实现模糊查询姓名和分页显示
    public List<leave> findbyname(PageBean<leave> pb, String lname) throws SQLException {
        int totalCount = this.getTotalCountname(lname);
        pb.setTotalCount(totalCount);

        if (pb.getCurrentPage() <= 0) {
            pb.setCurrentPage(1);                        // 把当前页设置为1
        } else if (pb.getCurrentPage() > pb.getTotalPage()) {
            pb.setCurrentPage(pb.getTotalPage());        // 把当前页设置为最大页数
        }
        int currentPage = pb.getCurrentPage();
        int index = (currentPage - 1) * pb.getPageCount();        // 查询的起始行
        int count = pb.getPageCount();

        conn = DriverManager.getConnection(url, username, password);
        List<leave> leas = new ArrayList<>();
        String sql = "select * from leaves where lname like ? limit ?,?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, lname + '%');
        
        stmt.setInt(2, index);
        stmt.setInt(3, count);
        
        rs = stmt.executeQuery();
        while (rs.next()) {
            leave lea = new leave();
            lea.setLid(rs.getInt("lid"));
            lea.setLname(rs.getString("lname"));
            lea.setLstime(rs.getString("lstime"));
            lea.setLetime(rs.getString("letime"));
            lea.setLnote(rs.getString("lnote"));
            leas.add(lea);
            
        }
        stmt.close();
        return leas;
    }
    
    
    
    
    
    
    
    
    
}
