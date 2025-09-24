package kr.or.kosa.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.dao.EmpDao;
import kr.or.kosa.dto.Emp;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("*.do") //list.do , write.do
public class EMP_FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	private int parseIntOrDefault(String param, int defaultValue) {
	    if (param == null || param.trim().isEmpty()) {
	        return defaultValue;
	    }
	    return Integer.parseInt(param);
	}
	
    public EMP_FrontController() {
        super();
    } 

	private void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 한글처리
		//2. 데이터 받기
		//3. 모든 요청을 받고 처리 하겠다
		//3.1 요청에 대한 판단
		//3.1.1 command 방식 list.do?cmd=list , write.do?cmd-insert
		
		//url 방식 (뒷 주속값을 추룰해서 비교)
		//마지막 주소 문자열 : localhost:8090/WEB/list.do
		//>>>>   /list.do   /insert.do     추출 .... 
		
		
		//데이터 받기
		//URL 방식
		String requestUri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String urlCommand = requestUri.substring(contextPath.length());
		
		System.out.println(urlCommand);
		
		//3. 요청하기
		String viewPage= "";
		
		EmpDao empDao = new EmpDao();
		
		//요구분석 (UI 보여주 , 데이터 처리해주)
		if(urlCommand.equals("/emp.do")) {
			//화면 ...
			viewPage = "/WEB-INF/views/emp/emp_insert.jsp";
		
		}else if(urlCommand.equals("/empdetail.do")) {
			
		  int id = Integer.parseInt(request.getParameter("empno"));
		  Emp empDetail = empDao.getEmpListByEmpno(id);
		  request.setAttribute("empdetail", empDetail);
		  viewPage="/WEB-INF/views/emp/emp_detail.jsp"; //forward
			  
		}else if(urlCommand.equals("/emplist.do"))
			
		{
			List<Emp> empList;
			
			try {
				  empList = empDao.getAllEmpList();
				  request.setAttribute("empList", empList);
				  viewPage="/WEB-INF/views/emp/emp_list.jsp";
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(urlCommand.equals("/empinsert.do")) {
			//코드 채우기
			//데이터 받기 , emp 객체 생성 (뷰지정하고 forward)
			//상세보기 ..
			
			int empno = parseIntOrDefault(request.getParameter("empno"), 0);
			String ename = request.getParameter("ename");
			String job = request.getParameter("job");
			int deptno = parseIntOrDefault(request.getParameter("deptno"), 0);
			int sal = parseIntOrDefault(request.getParameter("sal"), 0);
			int comm = parseIntOrDefault(request.getParameter("comm"), 0);
			
			
			
//			int empno = Integer.parseInt(request.getParameter("empno"));
//    		String ename = request.getParameter("ename");
//    		String job = request.getParameter("job");
//    		int deptno = Integer.parseInt(request.getParameter("deptno"));
//    		int sal = Integer.parseInt(request.getParameter("sal"));
//    		int comm = Integer.parseInt(request.getParameter("comm"));
    		
    		
    		Emp emp = new Emp();
    		empDao.insertEmp(emp);
    		
    		request.setAttribute("empdetail", emp);
    		viewPage = "/WEB-INF/views/emp/emp_detail.jsp";
			
		}else if(urlCommand.equals("/empdelete.do")) {
			
			int empno = Integer.parseInt(request.getParameter("empno"));
    		empDao.deleteEmp(empno);
    		
    		List<Emp> empList=null;;
			try {
				empList = empDao.getAllEmpList();
				request.setAttribute("empList", empList);
	    		viewPage = "/WEB-INF/views/emp/emp_list.jsp";
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	
		}else if(urlCommand.equals("/empupdate.do")) {
			///memoupdate.do?id=99
			//수정하기 화면 (기존 데이터 출력) > select 
			int empno = Integer.parseInt(request.getParameter("empno"));    		
			Emp empDetail = empDao.getEmpListByEmpno(empno);
    		System.out.println(empDetail);
    		
    		request.setAttribute("empupdate", empDetail);
    		viewPage = "/WEB-INF/views/emp/emp_update.jsp";
    		
		}else if (urlCommand.equals("/empupdateok.do")) {
    		// 변경된 내용 수정 > update ....
			int empno = Integer.parseInt(request.getParameter("empno"));
    		String ename = request.getParameter("ename");
    		String job = request.getParameter("job");
    		int deptno = Integer.parseInt(request.getParameter("deptno"));
    		int mgr = Integer.parseInt(request.getParameter("mgr"));
    		int sal = Integer.parseInt(request.getParameter("sal"));
    		int comm = Integer.parseInt(request.getParameter("comm"));
    		
    		Emp emp = new Emp();
    		empDao.updateEmpno(emp);
    	
    		request.setAttribute("empdetail", emp);	
    		viewPage = "/WEB-INF/views/emp/emp_detail.jsp";
    	}
		
		// 5. 뷰지정
    	RequestDispatcher dis = request.getRequestDispatcher(viewPage);
    	
    	// 6. 뷰 forward
    	dis.forward(request, response);
    	
    	// 7. 뷰페이지 화면 출력..
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess( request,  response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess( request,  response);
	}

}
