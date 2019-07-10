package servlet;

import dao.PunchCardDaoImpl;
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
import entity.PunchCard;
import entity.PageBean;

//进行打卡页面的后台数据处理
@WebServlet("/PunchCardServlet")
public class PunchCardServlet extends HttpServlet {

	//实例化数据库处理类
	private final PunchCardDaoImpl dao = new PunchCardDaoImpl();

	//分页显示打卡表数据的方法
	private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PunchCard> list = null;
		String currPage = request.getParameter("page");

		System.out.println("currentPage:" + currPage);

		if (currPage == null || "".equals(currPage.trim())) {
			currPage = "1";
		}
		int currentPage = Integer.parseInt(currPage);
		PageBean<PunchCard> pageBean = new PageBean<>();
		pageBean.setCurrentPage(currentPage);

		try {
			list = dao.findAll(pageBean);
		} catch (Exception ex) {
			Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
		}
		request.getSession().setAttribute("pageBean", pageBean);
		request.getSession().setAttribute("list", list);

	}

	//显示查询数据的方法
	private void searchList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<PunchCard> list = new ArrayList<>();
		PageBean<PunchCard> pageBean = new PageBean<>();

		String pclock = request.getParameter("pclock");
		try {
			list = dao.findByName(pclock);
		} catch (Exception ex) {
			Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
		}
		pageBean.setCurrentPage(1);
		pageBean.setTotalPage(1);
		pageBean.setTotalCount(list.size());
		request.getSession().setAttribute("pageBean", pageBean);
		request.getSession().setAttribute("list", list);
		request.getRequestDispatcher("punchCard_list.jsp").forward(request, response);

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
		List<PunchCard> list = null;
		System.out.println("method 1:" + method);
		//进入页面用户无操作时执行，用于展示数据库中打卡表单数据
		if (method == null || "".equals(method)) {

			String currPage = request.getParameter("page");
			if (currPage == null || "".equals(currPage.trim())) {
				currPage = "1";
			}
			int currentPage = Integer.parseInt(currPage);
			PageBean<PunchCard> pageBean = new PageBean<>();
			pageBean.setCurrentPage(currentPage);

			try {
				list = dao.findAll(pageBean);
			} catch (Exception ex) {
				Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
			}
			request.getSession().setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("list", list);
			request.getRequestDispatcher("punchCard_list.jsp").forward(request, response);

		} else {
			switch (method) {
			//无论是新增操作还是编辑操作，均执行此方法
			case "store": {
				// SimpleDateFormat adf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				PunchCard punchCard = new PunchCard();
				String pclock = request.getParameter("pclock");
				String pnote = request.getParameter("pnote");
				String ptime = request.getParameter("ptime");
//				pnote=new String(pnote.getBytes("iso-8859-1")); 
				
				punchCard.setPclock(pclock);
				punchCard.setPnote(pnote);
				punchCard.setPtime(ptime);

				try {
					dao.storePunchCard(punchCard);
				} catch (Exception ex) {
					Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);				
				request.getRequestDispatcher("punchCard_list.jsp").forward(request, response);
				break;
			}
			//用户点击删除按钮时执行
			case "delete": {
				int pId = Integer.parseInt(request.getParameter("pId"));
				try {
					dao.delete(pId);
				} catch (Exception ex) {
					Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);
				response.sendRedirect("punchCard_list.jsp");
				break;
			}
			//用户点击批量删除按钮时执行
			case "deleteAll": {
				String checkId = request.getParameter("allIDCheck");
				String[] str = checkId.split(",");
				int[] pIds = new int[str.length];
				if (str.length > 0) {
					for (int i = 0; i < str.length; i++) {
						pIds[i] = Integer.parseInt(str[i]);
					}
				}
				try {
					dao.deleteAll(pIds);
				} catch (Exception ex) {
					Logger.getLogger(PunchCardServlet.class.getName()).log(Level.SEVERE, null, ex);
				}
				list(request, response);
				response.sendRedirect("punchCard_list.jsp");
				break;
			}
			//用户点击查询按钮时执行
			case "search": {
				String pclock = request.getParameter("pclock");
				if (pclock == null || "".equals(pclock)) {
					list(request, response);
					response.sendRedirect("punchCard_list.jsp");
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
