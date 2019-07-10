/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.stationdao;
import entity.PageBean;
import entity.station;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author exg
 */
@WebServlet(name = "stationservlet", urlPatterns = {"/stationservlet"})
public class stationservlet extends HttpServlet {

    private final stationdao stao = new stationdao();

    public stationservlet() {
        super();
    }

    public void destroy() {
        super.destroy();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

//    private void searchList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Employee employee = null;
//        List<station> stas = new ArrayList<>();
//        String currPage = request.getParameter("page");
//
//        if (currPage == null || "".equals(currPage.trim())) {
//            currPage = "1";
//        }
//        int currentPage = Integer.parseInt(currPage);
//        PageBean<station> pageBean = new PageBean<>();
//        pageBean.setCurrentPage(1);
//        pageBean.setTotalPage(1);
//
//        String name = request.getParameter("name");
//        try {
//            stas = stao.findbyname(name);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//
//        pageBean.setTotalCount(stas.size());
//        request.setAttribute("pageBean", pageBean);
//        request.setAttribute("stas", stas);
//        request.getRequestDispatcher("stationlist.jsp").forward(request, response);
//
//    }
    public station add(HttpServletRequest request, HttpServletResponse response) {
        station station1 = new station();
//        String stid = request.getParameter("stid");
        String stcode = request.getParameter("stcode");
        String stname = request.getParameter("stname");
        String stdepartment = request.getParameter("stdepartment");
        String stup = request.getParameter("stup");
        String stclass = request.getParameter("stclass");
        String stnote = request.getParameter("stnote");
        System.out.println("add"+stup);
        
        try {
//            int stid1 = Integer.parseInt(stid);
//            station1.setStid(stid1);
//            System.out.println("能到这吗");
            station1.setStcode(stcode);
            station1.setStname(stname);
            station1.setStdepartment(stdepartment);
            station1.setStup(stup);
            station1.setStclass(stclass);
            station1.setStnote(stnote);
        } catch (Exception e) {
            System.out.println("从edit得到数据转化或存储失败");

        }

        return station1;

    }

     public station edit(HttpServletRequest request, HttpServletResponse response) {
        station station1 = new station();
        String stid = request.getParameter("stid");
        String stcode = request.getParameter("stcode");
        String stname = request.getParameter("stname");
        String stdepartment = request.getParameter("stdepartment");
        String stup = request.getParameter("stup");
        String stclass = request.getParameter("stclass");
        String stnote = request.getParameter("stnote");
        try {
            int stid1 = Integer.parseInt(stid);
            station1.setStid(stid1);
//            System.out.println("能到这吗");
            station1.setStcode(stcode);
            station1.setStname(stname);
            station1.setStdepartment(stdepartment);
            station1.setStup(stup);
            station1.setStclass(stclass);
            station1.setStnote(stnote);
        } catch (Exception e) {
            System.out.println("从edit得到数据转化或存储失败");

        }

        return station1;

    }
     
    public String delete(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        return id;

    }

    public String dels(HttpServletRequest request, HttpServletResponse response) {
        String ids = request.getParameter("allIDCheck");
        return ids;

    }

    public String name(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        return name;
    }

    /**
     * The doPost method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to
     * post.
     *
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("station");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        List<station> stas = null;
        station sta = new station();

        String method = request.getParameter("method");
//      String method = "search";

        String name = this.name(request, response);
        System.out.println(name);
        String currPage = request.getParameter("page");
        // 判断
        if (currPage == null || "".equals(currPage.trim())) {
            currPage = "1";      // 第一次访问，设置当前页为1;
        }
        // 转换
        int currentPage = Integer.parseInt(currPage);

        //2. 创建PageBean对象，设置当前页参数； 传入service方法参数
        PageBean<station> pageBean = new PageBean<station>();
        pageBean.setCurrentPage(currentPage);

        if (method == null || "".equals(method)) {

            //3. 调用dao 
            try {
                stas = stao.findall(pageBean);
                System.out.print(stas);
            } catch (SQLException e) {
                e.printStackTrace();
            }    // 【pageBean已经被dao填充了数据】

            //4. 保存pageBean对象，到request域中
            request.setAttribute("pageBean", pageBean);
            request.setAttribute("stas", stas);
            //5. 跳转 
            request.getRequestDispatcher("stationlist.jsp").forward(request, response);

        } else if (method != null) {
            if ("add".equals(method)) {
//                //添加
                sta = this.add(request, response);
                try {
                    stao.add(sta);
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("新增异常");
                }
                response.sendRedirect("stationadd.jsp");
            } else if ("del".equals(method)) {
                //单个删除
                String id = this.delete(request, response);
                int stid = Integer.parseInt(id);
//                System.out.print(id + stid + "stid把id的值转化成int类型");
                try {
                    stao.delete(stid);
                    response.sendRedirect(request.getContextPath() + "/stationservlet");
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            } else if ("dels".equals(method)) {
                //执行多个删除
                String ids = this.dels(request, response);
//                String ids = "1,2,3,4,5,6,7";
                String[] stids = ids.split(",");

                try {
                    int arr[] = new int[stids.length];
                    for (int i = 0; i < stids.length; i++) {
                        arr[i] = Integer.parseInt(stids[i]);
                    }

                    stao.deleteAll(arr);
                    response.sendRedirect(request.getContextPath() + "/stationservlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("删除操作中String转int失败或者数据库访问出现问题");
                }

            } else if ("edit".equals(method)) {

                try {
                    sta = this.edit(request, response);
//            sta.setStid(11);
//            System.out.println("能到这吗");
//            sta.setStcode("11");
//            sta.setStname("11");
//            sta.setStdepartment("11");
//            sta.setStup("11");
//            sta.setStclass("11");
//            sta.setStnote("11");
//                    System.out.println("1111111111111111111111111111111111111");
                    stao.updata(sta);
//                    System.out.println("2222222222222222222222222222222222222222222");
                    response.sendRedirect(request.getContextPath() + "/stationservlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("更新异常");
                }
            } else if ("search".equals(method)) {

                try {
                    stas = stao.findbyname(pageBean, name);

                } catch (Exception e) {
                    e.printStackTrace();
                }
                request.setAttribute("pageBean", pageBean);
                request.setAttribute("stas", stas);

                //5. 跳转 
                request.getRequestDispatcher("stationlist.jsp").forward(request, response);
            }

        }

    }

    public void init() throws ServletException {
        // Put your code here
    }
}
