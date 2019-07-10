package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.echarts;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//为数据图形化展示提供数据
@WebServlet("/echartservlet")
public class echartservlet extends HttpServlet {

	public echartservlet() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.doPost(request, response);
		
		}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//创建了一个bardao的对象，barDAO主要是对数据库的连接和对数据库的操作
        echarts echartsdao=new echarts();
        String people=request.getParameter("id");
        System.out.println(people);
        if(people!=null){
        int a = 0,b = 0;
		try {
			a = echartsdao.getTotalCount("正常",people);
			b=echartsdao.getTotalCount("异常",people);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        //设置返回时的编码格式
        response.setContentType("text/html; charset=utf-8");
        //调用JSONArray.fromObject方法把array中的对象转化为JSON格式的数组
        ArrayList<Integer> array=new ArrayList<Integer> ();
        array.add(a);
        array.add(b);
        //JSONArray json=new JSONArray();
        
        request.setAttribute("array", array);
        
        JSONArray json=JSONArray.fromObject(array);
        System.out.println(json.toString());
        JSONObject jso=new JSONObject();
        jso.put("json", json);
        
        //返回给前段页面d
        PrintWriter out = response.getWriter();  
        out.println(jso.toString()); 
        out.flush();  
        out.close();   	
        }
        }

	public void init() throws ServletException {
		// Put your code here
	}

}
