/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import entity.PageBean;
import entity.station;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author exg
 */
public class stationdao {

    private String url = "jdbc:mysql://localhost:3306/test";
    private String username = "root";
    private String password = "123456";

    private Connection conn = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    //获取表单数据
//    public List<station> findall() throws Exception {
//        List<station> stas = new ArrayList<station>();
//        String sql = "select * from station";
//        try {
//            conn = DriverManager.getConnection(url, username, password);
//            stmt = conn.prepareStatement(sql);
//            rs = stmt.executeQuery();
//
//            while (rs.next()) {
//                station sta = new station();
//                sta.setStid(rs.getInt("stid"));
//                sta.setStcode(rs.getString("stcode"));
//                sta.setStname(rs.getString("stname"));
//                sta.setStdepartment(rs.getString("stdepartment"));
//                sta.setStup(rs.getString("stup"));
////              System.out.println(rs.getString("stup")+"22222222222222222222");              
//                sta.setStclass(rs.getString("stclass"));
//                sta.setStnote(rs.getString("stnote"));
//                stas.add(sta);
//
//            }
//        } catch (SQLException ex) {
//            System.out.println("岗位信息获取异常");
//        }
//        stmt.close();
//        System.out.print(stas);
//        return stas;
//
//    }
    public List<station> findall(PageBean<station> pb) throws SQLException {

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

        List<station> stas = new ArrayList<station>();
        try {
            conn = DriverManager.getConnection(url, username, password);
            String sql = "select * from station limit ?,?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, index);
            stmt.setInt(2, count);
            rs = stmt.executeQuery();
            while (rs.next()) {
                station sta = new station();
                sta.setStid(rs.getInt("stid"));
                sta.setStcode(rs.getString("stcode"));
                sta.setStname(rs.getString("stname"));
                sta.setStdepartment(rs.getString("stdepartment"));
                sta.setStup(rs.getString("stup"));
//              System.out.println(rs.getString("stup")+"22222222222222222222");              
                sta.setStclass(rs.getString("stclass"));
                sta.setStnote(rs.getString("stnote"));
                stas.add(sta);

            }
        } catch (SQLException e) {

            e.printStackTrace();
        }
        return stas;
    }

    public int getTotalCount() throws SQLException {

        conn = DriverManager.getConnection(url, username, password);
        String sql = "select count(*) from station";
        stmt = conn.prepareStatement(sql);
        //Long count=stmt.executeUpdate();
        rs = stmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;

    }

    //添加消息
    public void add(station sta) throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
//        String sql = "insert station(stid,stcode,stname,stdepartment,stup,stclass,stnote)values(?,?,?,?,?,?,?)";
        System.out.println(sta.getStdepartment()+"  "+sta.getStup());
        System.out.println("HHH");
        String sql = "insert station(stcode,stname,stdepartment,stup,stclass,stnote)values(?,?,?,?,?,?)";
        stmt = conn.prepareStatement(sql);
//        stmt.setInt(1, sta.getStid());
        stmt.setString(1, sta.getStcode());
        stmt.setString(2, sta.getStname());
        stmt.setString(3, sta.getStdepartment());
        stmt.setString(4, sta.getStup());
        stmt.setString(5, sta.getStclass());
        stmt.setString(6, sta.getStnote());
        stmt.executeUpdate();
        stmt.close();
    }

    //删除一条信息
    public void delete(int stid) throws SQLException {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "delete from station where stid=?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, stid);
        stmt.executeUpdate();
        stmt.close();
    }

    //删除所有选中消息
    public void deleteAll(int[] stids) throws Exception {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "delete from station where stid=?";
        for (int i = 0; i < stids.length; i++) {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, stids[i]);
            stmt.executeUpdate();
            System.out.print(i);
        }
        stmt.close();
    }

    public void updata(station sta) throws Exception {
        conn = DriverManager.getConnection(url, username, password);
        String sql = "update station set stid=?,stcode=?,stname=?,stdepartment=?,stup=?,stclass=?,stnote=? where stid=?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, sta.getStid());
            stmt.setString(2, sta.getStcode());
            stmt.setString(3, sta.getStname());
            stmt.setString(4, sta.getStdepartment());
            stmt.setString(5, sta.getStup());
            stmt.setString(6, sta.getStclass());
            stmt.setString(7, sta.getStnote());
            stmt.setInt(8, sta.getStid());
            stmt.executeUpdate();
            stmt.close();
        } catch (SQLException ex) {
            System.out.println("update: edit update error");
            ex.printStackTrace();
        }
    }
    public int getTotalCountname(String stname) throws SQLException {

        conn = DriverManager.getConnection(url, username, password);
        String sql = "select count(*) from station where stname like ?";
        stmt = conn.prepareStatement(sql);
        //Long count=stmt.executeUpdate();
        stmt.setString(1, stname + '%');
        rs = stmt.executeQuery();
        int count = 0;
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;

    }
    public List<station> findbyname(PageBean<station> pb, String stname) throws SQLException {
        int totalCount = this.getTotalCountname(stname);
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
        List<station> stas = new ArrayList<>();
        String sql = "select * from station where stname like ? limit ?,?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, stname + '%');
        
        stmt.setInt(2, index);
        stmt.setInt(3, count);
        
        rs = stmt.executeQuery();
        while (rs.next()) {
            station sta = new station();
            sta.setStid(rs.getInt("stid"));
            sta.setStcode(rs.getString("stcode"));
            sta.setStname(rs.getString("stname"));
            sta.setStdepartment(rs.getString("stdepartment"));
            sta.setStup(rs.getString("stup"));
            sta.setStclass(rs.getString("stclass"));
            sta.setStnote(rs.getString("stnote"));
            stas.add(sta);
            
        }
        stmt.close();
        return stas;
    }

}
