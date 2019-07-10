package servlet;

import java.util.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;

import dao.CheckReportDao;
import entity.EmployeeList;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import util.ExportExcel;

@WebServlet(name = "UserServlet", urlPatterns = { "/UserServlet" })
public class UserServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ���÷��ر����ʽ�������������
		resp.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");

		PrintWriter out = resp.getWriter();

		// ����action��ֵ��ִ�в�ͬ�Ķ�����������ʾ�����û�����ʾ�����û�
		String action = req.getParameter("action");
		System.out.println("i am get");
        //����������ȫ������
		if (action.equals("sexportallexcel")) {
			try {
				Map<String, List<EmployeeList>> map = searchList(req, resp);
				List<EmployeeList> list = map.get("userall");
				ExportExcel.excel(list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		  //ȫ��������ȫ������
		if (action.equals("pexportallexcel")) {
			try {
				Map<String, List<EmployeeList>> map = pageList(req, resp);
				List<EmployeeList> list = map.get("userall");
				ExportExcel.excel(list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
        //������ǰ����ҳ�������
		if (action.equals("exportexcel")) {
			try {
				Map<String, List<EmployeeList>> map = searchList(req, resp);
				List<EmployeeList> list = map.get("user");
				ExportExcel.excel(list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//������ǰҳ�������
		if (action.equals("exportexcel1")) {
			try {
				Map<String, List<EmployeeList>> map = pageList(req, resp);
				List<EmployeeList> list = map.get("user");
				ExportExcel.excel(list);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
       //��ʾ��ȫ������
		if (action.equals("page")) {
			pageList(req, resp);
		}

		// ����ָ��ID
		if (action.equals("search")) {

			try {
				searchList(req, resp);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
		System.out.println("i am post");

	}

	// ȫ����ҳ
	public Map<String, List<EmployeeList>> pageList(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		Map<String, List<EmployeeList>> map = new HashMap<String, List<EmployeeList>>();
		PrintWriter out = resp.getWriter();
		String currentId = req.getParameter("currentId");
		int currentid = Integer.parseInt(currentId);
		int pagetotal;
		int usertotal;

		CheckReportDao crd = new CheckReportDao();
		List<EmployeeList> users = crd.findall();
		List<EmployeeList> users1 = new ArrayList<EmployeeList>();
        usertotal = users.size();
		pagetotal = (users.size() - 1) / 4 + 1;

		for (int i = (currentid - 1) * 4; i < (currentid - 1) * 4 + 4 && i < users.size(); i++) {
			users1.add(users.get(i));
		}

		// ����JSON���ݸ�ʽ

		map.put("userall", users);
		map.put("user", users1);
		
		JSONArray jsonArr = JSONArray.fromObject(users1);
		JSONObject jsonObjOut = new JSONObject();
		jsonObjOut.put("users", jsonArr);
		jsonObjOut.put("total", pagetotal);
		jsonObjOut.put("utotal", usertotal);
		// JSONUtil.returnJSON(req, resp, jsonObjOut);
		out.write(jsonObjOut.toString());
		out.flush();
		out.close();
		System.out.println("endpage");

		return map;
	}

	// ����
	public Map<String, List<EmployeeList>> searchList(HttpServletRequest req, HttpServletResponse resp)
			throws Exception {
		Map<String, List<EmployeeList>> map = new HashMap<String, List<EmployeeList>>();
		PrintWriter out = resp.getWriter();
		String currentId = req.getParameter("currentId");
		String str = req.getParameter("detail");
		int currentid = Integer.parseInt(currentId);
		int pagetotal;
		int usertotal;

		List<EmployeeList> users = getListByID(str);
		List<EmployeeList> users1 = new ArrayList<EmployeeList>();
		pagetotal = (users.size() - 1) / 4 + 1;
        usertotal = users.size();
		for (int i = (currentid - 1) * 4; i < (currentid - 1) * 4 + 4 && i < users.size(); i++) {
			users1.add(users.get(i));
		}

		map.put("userall", users);
		map.put("user", users1);
		// ����JSON���ݸ�ʽ
		JSONArray jsonArr = JSONArray.fromObject(users1);
		JSONObject jsonObjOut = new JSONObject();
		jsonObjOut.put("users", jsonArr);
		jsonObjOut.put("total", pagetotal);
		jsonObjOut.put("utotal", usertotal);
		// JSONUtil.returnJSON(req, resp, jsonObjOut);
		out.write(jsonObjOut.toString());
		out.flush();
		out.close();
		System.out.println("endsearch");

		return map;
	}

	// ��ȡǰ���������������Ϣ
	public String[] getStrings(String sb) {

		String[] str = sb.toString().split(":");
		return str;
	}

	public List<EmployeeList> getListByID(String stri) {
		List<EmployeeList> list = null;
		String[] str = getStrings(stri);
		String[] time = null;
		String[] time1 = null;

		Map map = new HashMap<String, String>();
		map.put("cclock", str[0]);

		time = str[1].split("-");
		time1 = str[2].split("-");

		if (time[1].startsWith("0")) {
			time[1] = time[1].substring(1);
		}
		if (time[2].startsWith("0")) {
			time[2] = time[2].substring(1);
		}
		if (time1[2].startsWith("0")) {
			time1[2] = time1[2].substring(1);
		}

		map.put("month", time[1]);
		map.put("bday", time[2]);
		map.put("eday", time1[2]);

		CheckReportDao crd = new CheckReportDao();
		list = crd.getClockById(map);

		return list;
	}

	public List getList() {
		CheckReportDao crd = new CheckReportDao();
		return (List) crd.findall();
	}

}
