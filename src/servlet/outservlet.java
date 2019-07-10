package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import dao.departmentdao;

//实现导出功能
@WebServlet("/deoutservlet")
public class outservlet extends HttpServlet {

	public outservlet() {
		super();
	}
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.doPost(request, response);
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("application/vnd.ms-excel");
        //设置响应头
        response.setHeader("Content-Disposition","attachment;filename=department");
        //调用模型
        departmentdao excelDao = new departmentdao();
        //调用方法
        HSSFWorkbook hssfWorkbook = excelDao.output();
        //执行
        hssfWorkbook.write(response.getOutputStream());

		
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
