package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.logindao;
import entity.user;

//用于实现登陆校验
@WebServlet("/loginservlet")
public class loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginservlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		//获取用户输入的用户名和密码
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		
		user people=new user();
		people.setUser(username);
		people.setPasswd(password);
		
		logindao daoo=new logindao();
		user student = null;
		try {
			student = daoo.findByName(people.getUser());
			System.out.println(student.getPasswd());
		} catch (Exception e) {
			e.printStackTrace();
		}
		//若用户名密码正确则跳转至home.jsp，否则跳转至faillogin.jsp
		if(password.equals(student.getPasswd())){
			response.sendRedirect("home.jsp");
		}else{
			response.sendRedirect("faillogin.jsp");
		}
		
	}
}
