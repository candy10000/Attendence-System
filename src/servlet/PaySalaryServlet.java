package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Delayed;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;

import dao.PaySalaryDao;
import entity.EmployeePS;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class PaySalaryServlet
 */
@WebServlet("/PaySalaryServlet")
public class PaySalaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaySalaryServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String action = req.getParameter("action");
		
		if (action == null) {
			listall(req, resp);
		}
				

		if (action.equals("del")) {

			del(req);
			listall(req, resp);

		} else if (action.equals("search")) {

			search(req, resp);

		} else if ( action.equals("findall")) {
			listall(req, resp);

		} else if (action.equals("pdel")) {
			pDel(req);
			listall(req, resp);
		} else if (action.equals("checkid")) {
			checkId(req, resp);
		} else if (action.equals("countMoney")) {

			countMonet(req, resp);

		} else if (action.equals("save")) {
			save(req, resp);
		}
	}

	// 搜索
	public void search(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String msg = req.getParameter("msg");
		int pageid = Integer.parseInt(req.getParameter("id"));
		int totalmsg = 0, totalpage = 0;
		PaySalaryDao psd = new PaySalaryDao();
		List<EmployeePS> emp = psd.search(msg);
		List<EmployeePS> emp1 = new ArrayList<>();

		totalmsg = emp.size();
		totalpage = (totalmsg - 1) / 4 + 1;

		System.out.println(pageid);
		for (int i = (pageid - 1) * 4; i < (pageid - 1) * 4 + 4 & i < totalmsg; i++) {
			emp1.add(emp.get(i));
		}

		req.setAttribute("msg", msg);
		req.setAttribute("flag", "1");
		req.setAttribute("courrentpage", pageid);
		req.setAttribute("totalpage", totalpage);
		req.setAttribute("total", emp.size());
		req.setAttribute("tt", emp1);
		// resp.sendRedirect("paysalarylist.jsp");
		req.getRequestDispatcher("paysalarylist.jsp").forward(req, resp);

	}

	// 保存数据
	public void save(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] msg = req.getParameter("msg").split(":");
		
		System.out.println( req.getParameter("msg"));
		Map<String, String> map = new HashMap<String, String>();
		// System.out.println(req.getParameterValues("msg"));
		map.put("id", msg[0]);
		map.put("bdate", msg[1]);
		map.put("edate", msg[2]);
		map.put("money", msg[3]);
		PaySalaryDao psd = new PaySalaryDao();
		psd.save(map);
		listall(req, resp);
	}

	// 计算薪水
	public void countMonet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String id = req.getParameter("id");
		String bdate = req.getParameter("bdate");
		String edate = req.getParameter("edate");
		PrintWriter out = resp.getWriter();
		JSONObject json = new JSONObject();

		PaySalaryDao psd = new PaySalaryDao();

		double money = psd.countMoney(id, bdate, edate);

		json.put("money", money);
		System.out.println("薪水为：" + money);
		out.print(json.toString());
		out.flush();
		out.close();

	}

	// 检查ID是否存在员工employee表中

	public void checkId(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String id = req.getParameter("id");
		PaySalaryDao psd = new PaySalaryDao();
		JSONObject json = new JSONObject();
		boolean flag = psd.checkId(id);
		PrintWriter out = resp.getWriter();
		System.out.println(flag + "  " + id);

		if (flag) {
			json.put("str", "1");
		} else {
			json.put("str", "0");
		}
		req.setAttribute("msg", "tiantian");
		out.print(json.toString());
		out.flush();
		out.close();
	}

	// 批量删除
	public void pDel(HttpServletRequest req) {
		String plist = req.getParameter("plist");
		String[] str = plist.split(":");
		PaySalaryDao psd = new PaySalaryDao();

		for (int i = 0; i < str.length; i++) {
			String[] ids = str[i].split(",");
			boolean flag = psd.delById(ids[0], ids[1]);
			System.out.println(flag);
		}
	}

	// 显示全部的记录
	public void listall(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		
		String idString  = req.getParameter("id");
		int pageid;
		if (idString == null) {
			 pageid = 1;
		}else {
			 pageid = Integer.parseInt(req.getParameter("id"));
		}
		
		int totalmsg = 0, totalpage = 0;
		PaySalaryDao psd = new PaySalaryDao();
		List<EmployeePS> emp = psd.findall();
		List<EmployeePS> emp1 = new ArrayList<>();

		totalmsg = emp.size();
		totalpage = (totalmsg - 1) / 4 + 1;

		System.out.println(pageid);
		for (int i = (pageid - 1) * 4; i < (pageid - 1) * 4 + 4 & i < totalmsg; i++) {
			emp1.add(emp.get(i));
		}

		req.setAttribute("msg", "ls");
		req.setAttribute("flag", "0");
		req.setAttribute("courrentpage", pageid);
		req.setAttribute("totalpage", totalpage);
		req.setAttribute("total", emp.size());
		req.setAttribute("tt", emp1);
		// resp.sendRedirect("paysalarylist.jsp");
		req.getRequestDispatcher("paysalarylist.jsp").forward(req, resp);
	}

	// 单条记录删除
	public void del(HttpServletRequest req) {
		String id = req.getParameter("idd");
		String eid = req.getParameter("eid");
		PaySalaryDao psd = new PaySalaryDao();
		boolean flag = psd.delById(id, eid);
		System.out.println(flag);

	}

}
