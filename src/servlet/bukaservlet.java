package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.bukadao;

import entity.buka;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//进行补卡页面的后台数据处理
@WebServlet("/bukaservlet")
public class bukaservlet extends HttpServlet {

	public bukaservlet() {
		super();
	}

	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		//获取用户的操作类型
		String action = request.getParameter("action");
		List<buka> peoples = new ArrayList<buka>();
		bukadao daoo = new bukadao();
        int isSuccess=0;
		if(action!=null){
			//用户点击删除按钮时执行
			if(action.equals("del")){
				System.out.println("del");
				String id = request.getParameter("rid");
				int a=Integer.parseInt(id);
				try {
					daoo.delete(a);
					JSONObject jsonObjOut = new JSONObject();
					jsonObjOut.put("isSuccess", 1);
					out.write(jsonObjOut.toString());
					out.flush();
					out.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
				//用户点击新增按钮时执行
			}else if(action.equals("add")){
				System.out.println("add");
				String id = request.getParameter("id");
				System.out.println(id);
				String[] list=null;
				list=id.split("/");
				buka user=new buka();
				user.setRempid(list[0]);
				user.setRdate(list[1]);
				user.setRreson(list[2]);
				try {
					daoo.add(user);
					JSONObject jsonObjOut = new JSONObject();
					jsonObjOut.put("isSuccess", 1);
					out.write(jsonObjOut.toString());
					out.flush();
					out.close();
					
				} catch (Exception e) {
					
					e.printStackTrace();
				} 				
				
			}
			//进入页面用户无操作时执行，用于展示数据库中补卡表单数据
		}else{
			Map<String, List<buka>> map = new HashMap<String, List<buka>>();
			String currentId = request.getParameter("currentId");
			int currentid = Integer.parseInt(currentId);
			int pagetotal;
			int usertotal;

			List<buka> users = daoo.findall();
			List<buka> users1 = new ArrayList<buka>();
	                usertotal = users.size();
			pagetotal = (users.size() - 1) / 4 + 1;

			for (int i = (currentid - 1) * 4; i < (currentid - 1) * 4 + 4 && i < users.size(); i++) {
				users1.add(users.get(i));
			}
            
			System.out.println(users1+" "+pagetotal);
			// 返回JSON数据格式
			map.put("userall", users);
			map.put("user", users1);
			
			JSONArray jsonArr = JSONArray.fromObject(users1);
			JSONObject jsonObjOut = new JSONObject();
			jsonObjOut.put("users", jsonArr);
			jsonObjOut.put("total", pagetotal);
			jsonObjOut.put("utotal", usertotal);
			out.write(jsonObjOut.toString());
			out.flush();
			out.close();
			System.out.println("endpage");
		}
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
