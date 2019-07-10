package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.departmentdao;
import entity.PageBean;
import entity.department;

//进行部门页面的后台数据处理
@WebServlet("/departmentservlet")
public class departmentservlet extends HttpServlet {

	public departmentservlet() {
		super();
	}
	
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	//新增方法
	public department add(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		String decode = request.getParameter("decode");
		String dename = request.getParameter("dename");
		String deres = request.getParameter("deres");
		String deduty = request.getParameter("deduty");
		String deup = request.getParameter("deup");

		department depart = new department();
		depart.setId(id);
		depart.setDecode(decode);
		depart.setDename(dename);
		depart.setDeres(deres);
		depart.setDeduty(deduty);
		depart.setDeup(deup);

		return depart;

	}

	//删除方法
	public String delete(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");

		return id;

	}

	//批量删除方法
	public String deletes(HttpServletRequest request, HttpServletResponse response) {

		String ids = request.getParameter("allIDCheck");

		return ids;

	}

	//更新方法
	public department update(HttpServletRequest request, HttpServletResponse response) throws SQLException {
		String id = request.getParameter("id");
		String decode = request.getParameter("decode");
		String dename = request.getParameter("dename");
		String deres = request.getParameter("deres");
		String deduty = request.getParameter("deduty");
		String deup = request.getParameter("deup");

		department depart = new department();
		depart.setId(id);
		depart.setDecode(decode);
		depart.setDename(dename);
		depart.setDeres(deres);
		depart.setDeduty(deduty);
		depart.setDeup(deup);

		return depart;

	}

	//模糊搜索方法
	public String findmohu(HttpServletRequest request, HttpServletResponse response) {
		String decode = request.getParameter("findcode");
		return decode;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("department");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		List<department> departs = null;

		departmentdao daoo = new departmentdao();
		department depart = new department();
		boolean flag = false;
		//获取用户的操作类型
		String method = request.getParameter("method");
		if (method != null) {
			//用户点击新增按钮时执行
			if ("add".equals(method)) {
				depart = this.add(request, response);
				try {
					daoo.add(depart);
					request.getRequestDispatcher("departmentservlet").forward(request, response);
				} catch (SQLException e) {

					e.printStackTrace();
				}
				//用户点击删除按钮时执行
			} else if ("del".equals(method)) {
				PageBean<department> pageBean = new PageBean<department>();
				try {
					String currPage = request.getParameter("page");
					int currentPage = Integer.parseInt(currPage);
					pageBean.setCurrentPage(currentPage);
					String id = this.delete(request, response);
					daoo.delete(id);
					request.setAttribute("pageBean", pageBean);
					response.sendRedirect(request.getContextPath() + "/departmentservlet");
				} catch (SQLException e) {
					e.printStackTrace();
				}
				//用户点击批量删除按钮时执行
			} else if ("dels".equals(method)) {
				String ids = this.deletes(request, response);
				System.out.println(ids);
				String[] deids = ids.split(",");
				int i;
				for (i = 0; i < deids.length; i++) {
					try {
						daoo.delete(deids[i]);
					} catch (SQLException e) {

						e.printStackTrace();
					}
				}
				response.sendRedirect(request.getContextPath() + "/departmentservlet");
				//用户点击编辑按钮时执行
			} else if ("edit".equals(method)) {

				try {
					depart = this.update(request, response);
					System.out.println(depart);
					daoo.update(depart);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				//用户点击查询按钮时执行
			} else if ("search".equals(method)) {
				PageBean<department> pageBean = new PageBean<department>();
				try {
					String decode = this.findmohu(request, response);
					String currPage = request.getParameter("page");
					if (currPage == null || "".equals(currPage.trim())) {
						currPage = "1"; // 第一次访问，设置当前页为1;
					}

					int currentPage = Integer.parseInt(currPage);
					
					pageBean.setCurrentPage(currentPage);

					departs = daoo.findmohu(decode,pageBean);
					System.out.println(departs);

				} catch (Exception e) {
					e.printStackTrace();
				}
				request.setAttribute("pageBean", pageBean);
				request.setAttribute("departs", departs);
				request.getRequestDispatcher("bumenlist.jsp").forward(request, response);

			}
			//进入页面用户无操作时执行，用于展示数据库中部门表单数据
		} else {
			// 1. 获取“当前页”参数； (第一次访问当前页为null)
			String currPage = request.getParameter("page");
			// 判断
			if (currPage == null || "".equals(currPage.trim())) {
				currPage = "1"; // 第一次访问，设置当前页为1;
			}
			// 转换
			int currentPage = Integer.parseInt(currPage);

			// 2. 创建PageBean对象，设置当前页参数； 传入service方法参数
			PageBean<department> pageBean = new PageBean<department>();
			pageBean.setCurrentPage(currentPage);

			// 3. 调用dao
			try {
				departs = daoo.findall(pageBean);
				System.out.print(departs);
			} catch (SQLException e) {

				e.printStackTrace();
			} // 【pageBean已经被dao填充了数据】

			// 4. 保存pageBean对象，到request域中
			request.setAttribute("pageBean", pageBean);
			request.setAttribute("departs", departs);
			// 5. 跳转

			request.getRequestDispatcher("bumenlist.jsp").forward(request, response);

		}

	}

	public void init() throws ServletException {
		// Put your code here
	}

}
