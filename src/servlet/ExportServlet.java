package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;

import dao.EmployeeDaoImpl;
import dao.PunchCardDaoImpl;

//用于实现导出功能
@WebServlet("/ExportServlet")
public class ExportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ExportServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String object = request.getParameter("object");
		System.out.println("object:"+object);
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		// 设置响应头
		response.addHeader("Content-Disposition", "attachment;filename="+object+".xlsx");

		// 调用模型
		PunchCardDaoImpl punchDao = new PunchCardDaoImpl();
		EmployeeDaoImpl empDao = new EmployeeDaoImpl();
		
		// 调用方法
		Workbook xssfWorkbook = null;
		try {
			if(object.equals("punchCard")) {
				xssfWorkbook = punchDao.output();
			}
			else if (object.equals("employee")) {
				xssfWorkbook = empDao.output();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 执行
		xssfWorkbook.write(response.getOutputStream());

	}

}
