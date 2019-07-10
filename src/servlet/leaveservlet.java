package servlet;

import dao.leavedao;
import entity.PageBean;
import entity.leave;
import entity.station;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "leaveservlet", urlPatterns = {"/leaveservlet"})
public class leaveservlet extends HttpServlet {

	
	//获取leaveadd页面传来的值
    public leave add(HttpServletRequest request, HttpServletResponse response) {
        leave lea1 = new leave();
        String lname = request.getParameter("lname");
        String lstime = request.getParameter("lstime");
        String letime = request.getParameter("letime");
        String lnote = request.getParameter("lnote");
        try {
            lea1.setLname(lname);
            lea1.setLstime(lstime);
            lea1.setLetime(letime);
            lea1.setLnote(lnote);
        } catch (Exception e) {
            System.out.println("从add得到数据转化或存储失败");

        }

        return lea1;

    }

    //获取leaveadd页面传来的值
    public leave edit(HttpServletRequest request, HttpServletResponse response) {
        leave lea1 = new leave();
        String lid = request.getParameter("lid");
        String lname = request.getParameter("lname");
        String lstime = request.getParameter("lstime");
        String letime = request.getParameter("letime");
        String lnote = request.getParameter("lnote");
        try {
            int lid1 = Integer.parseInt(lid);
            lea1.setLid(lid1);
            lea1.setLname(lname);
            lea1.setLstime(lstime);
            lea1.setLetime(letime);
            lea1.setLnote(lnote);
        } catch (Exception e) {
            System.out.println("从edit得到数据转化或存储失败");

        }

        return lea1;

    }
    
    //获取单个删除对应的id
    public String delete(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        return id;

    }

    //获取多个删除对应的id
    public String dels(HttpServletRequest request, HttpServletResponse response) {
        String ids = request.getParameter("allIDCheck");
        return ids;

    }

    //获取查询文本框的值
    public String name(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("name");
        return name;
    }
    
    //调用dopost方法
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("leave");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String method = request.getParameter("method");
        //定义变量
        List<leave> leas = null;
        leave lea = new leave();
        leavedao leao = new leavedao();

        //分页
        String currPage = request.getParameter("page");
        if (currPage == null || "".equals(currPage.trim())) {
            currPage = "1";
        }
        int currentPage = Integer.parseInt(currPage);
        PageBean<leave> pageBean = new PageBean<leave>();
        pageBean.setCurrentPage(currentPage);

        if (method == null || "".equals(method)) {
            try {
                leas = leao.findall(pageBean);

            } catch (SQLException e) {
                e.printStackTrace();
            }

            request.setAttribute("pageBean", pageBean);
            request.setAttribute("leas", leas);
            request.getRequestDispatcher("leavelist.jsp").forward(request, response);

        } else if (method != null) {
            if ("add".equals(method)) {
//                //添加
//                String datetime = request.getParameter("lstime");
                lea = this.add(request, response);
                try {
                    leao.add(lea);
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("新增异常");
                }
                response.sendRedirect("leaveadd.jsp");
            } else if ("del".equals(method)) {
                //单个删除
                String id = this.delete(request, response);
                int stid = Integer.parseInt(id);
                try {
                    leao.delete(stid);
                    response.sendRedirect(request.getContextPath() + "/leaveservlet");
                } catch (SQLException e) {
                    e.printStackTrace();
                }

            } else if ("dels".equals(method)) {
                //执行多个删除
                String ids = this.dels(request, response);
                String[] stids = ids.split(",");

                try {
                    int arr[] = new int[stids.length];
                    for (int i = 0; i < stids.length; i++) {
                        arr[i] = Integer.parseInt(stids[i]);
                    }
                    leao.deleteAll(arr);
                    response.sendRedirect(request.getContextPath() + "/leaveservlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("删除操作中String转int失败或者数据库访问出现问题");
                }

            } else if ("edit".equals(method)) {

                try {
                    lea = this.edit(request, response);
                    leao.updata(lea);
                    response.sendRedirect(request.getContextPath() + "/leaveservlet");
                } catch (Exception e) {
                    e.printStackTrace();
                    System.out.println("更新异常");
                }
            } else if ("search".equals(method)) {

                try {
                    String name = this.name(request, response);
                    leas = leao.findbyname(pageBean, name);

                } catch (Exception e) {
                    e.printStackTrace();
                }
                request.setAttribute("pageBean", pageBean);
                request.setAttribute("leas", leas);

                //5. 跳转 
                request.getRequestDispatcher("leavelist.jsp").forward(request, response);
            }

        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
