package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CheckReportDao;
import entity.EmployeeList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@WebServlet("/CountServlet")
public class CountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CountServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  
		    resp.setCharacterEncoding("utf-8"); 
	        // ����action��ֵ��ִ�в�ͬ�Ķ�����������ʾ�����û�����ʾ�����û�
	        String action = req.getParameter("action");
	        System.out.println("i am get");
	  
		    if (action.equals("count")) {	
    	       count(req, resp);
		    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	public void count(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		 String str =  req.getParameter("id");
		 String date =  req.getParameter("date");
	
         float unatten = getListByID(date,str);
         float atten = 1-unatten;
         PrintWriter out = resp.getWriter(); 
         System.out.println(atten);
       

         // ����JSON���ݸ�ʽ
     
         JSONObject jsonObjOut = new JSONObject();
         jsonObjOut.put("atten", atten);
         jsonObjOut.put("unatten", unatten);
         // JSONUtil.returnJSON(req, resp, jsonObjOut);   
           out.write(jsonObjOut.toString());
           out.flush();
           out.close();
         System.out.println("endcount");
	}
	
	
	//��ȡǰ���������������Ϣ
	public Map<String, String> getStrings(String sb) {
		Map map = new HashMap<String, String>();
		String[] str = sb.toString().split("-");

	     //�ж��·�ǰ�Ƿ�Ϊ0��ͷ
	     if(str[1].startsWith("0")) {
	    	 //ȥ��0
	    	 str[1] = str[1].substring(1);
	     }
	     
	     //�ж���Ϊ0��ͷ
	     if(str[2].startsWith("0")) {
	    	//ȥ��0
	    	str[2] = str[2].substring(1);
	     } 
	     map.put("year", str[0]);
	     map.put("month", str[1]);
	     map.put("day", str[2]);
		return map;
	}
	
	public float getListByID(String date,String id) {
		  Map map = getStrings(date);
		  float unatten = 0;
	      CheckReportDao crd = new CheckReportDao();
	      map.put("id", id);
		  unatten =  crd.getCount(map);
	     
		return unatten;
	}
	

}
