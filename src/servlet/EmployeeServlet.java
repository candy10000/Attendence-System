package servlet;

import dao.EmployeeDaoImpl;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import entity.Employee;
import entity.PageBean;

//进行员工页面的后台数据处理
@WebServlet("/EmployeeServlet")
public class EmployeeServlet extends HttpServlet {

	//实例化数据库处理类
	private final EmployeeDaoImpl dao = new EmployeeDaoImpl();

	//分页显示员工表数据的方法
	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Employee> list = null;
		String currPage = request.getParameter("page");

		System.out.println("currentPage:" + currPage);

		if (currPage == null || "".equals(currPage.trim())) {
			currPage = "1";
		}
		int currentPage = Integer.parseInt(currPage);
		PageBean<Employee> pageBean = new PageBean<>();
		pageBean.setCurrentPage(currentPage);

		try {
			list = dao.findAll(pageBean);
		} catch (Exception ex) {
			Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
		}
		request.getSession().setAttribute("pageBean", pageBean);
		request.getSession().setAttribute("list", list);
	}

	//显示查询数据的方法
	private void searchList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Employee> list = new ArrayList<>();
		PageBean<Employee> pageBean = new PageBean<>();

		String name = request.getParameter("name");
		name=new String(name.getBytes("iso-8859-1")); 
		System.out.println("search"+name);
		try {
			list = dao.findByName(name);
		} catch (Exception ex) {
			Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
		}
		pageBean.setCurrentPage(1);
		pageBean.setTotalPage(1);
		pageBean.setTotalCount(list.size());
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("list", list);
		request.getRequestDispatcher("employee_list.jsp").forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		//获取用户的操作类型
		String method = request.getParameter("method");
		List<Employee> list = null;
		//进入页面用户无操作时执行，用于展示数据库中员工表单数据
		if (method == null || "".equals(method)) {
			String currPage = request.getParameter("page");
			if (currPage == null || "".equals(currPage.trim())) {
				currPage = "1";
			}
			int currentPage = Integer.parseInt(currPage);
			PageBean<Employee> pageBean = new PageBean<>();
			pageBean.setCurrentPage(currentPage);

			try {
				list = dao.findAll(pageBean);
			} catch (Exception ex) {
				Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
			}
			request.getSession().setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("list", list);
			request.getRequestDispatcher("employee_list.jsp").forward(request, response);

		} else {
			switch (method) {
			//无论是新增操作还是编辑操作，均执行此方法
			case "store": {
				Employee employee = new Employee();
				String id = request.getParameter("id");
				String name = request.getParameter("name");
				String sex = request.getParameter("sex");
				System.out.println("hhh"+request.getParameter("age"));
				int age = Integer.parseInt(request.getParameter("age"));
				String nation = request.getParameter("nation");
				String cardID = request.getParameter("cardID");
				String salary = request.getParameter("salary");
				String tel = request.getParameter("tel");
				String detail = request.getParameter("detail");
				String sation_ID = request.getParameter("sation_ID");

				System.out.println("name:"+name);
				employee.setId(id);
				employee.setName(name);
				employee.setSex(sex);
				employee.setAge(age);
				employee.setNation(nation);
				employee.setCardID(cardID);
				employee.setSalary(salary);
				employee.setTel(tel);
				employee.setDetail(detail);
				employee.setSation_ID(sation_ID);
				try {
					dao.storeEmployee(employee);
				} catch (Exception ex) {
					Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);
				request.getRequestDispatcher("employee_list.jsp").forward(request, response);
				break;
			}
			//用户点击删除按钮时执行
			case "delete": {
				String id = request.getParameter("id");
				try {
					dao.delete(id);
				} catch (Exception ex) {
					Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);
				response.sendRedirect("employee_list.jsp");
				break;
			}
			//用户点击批量删除按钮时执行
			case "deleteAll": {
				String checkId = request.getParameter("allIDCheck");
				String[] str = checkId.split(",");
				String[] ids = new String[str.length];
				if (str.length > 0) {
					for (int i = 0; i < str.length; i++) {
						ids[i] = str[i];
					}
				}
				try {
					dao.deleteAll(ids);
				} catch (Exception ex) {
					Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);
				response.sendRedirect("employee_list.jsp");
				break;
			}
			//用户点击查询按钮时执行
			case "search": {
				String name = request.getParameter("name");
				name=new String(name.getBytes("iso-8859-1")); 
				System.out.println("search"+name);
				if (name == null || "".equals(name)) {
					list(request, response);
					response.sendRedirect("employee_list.jsp");
				} else {
					searchList(request, response);
				}
				break;
			}
			default:
				break;
			}
		}

	}

	@Override
	public String getServletInfo() {
		return "Short description";
	}

}
