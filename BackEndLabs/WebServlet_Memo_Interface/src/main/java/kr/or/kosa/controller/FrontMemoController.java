package kr.or.kosa.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.kosa.action.Action;
import kr.or.kosa.action.ActionForward;
import kr.or.kosa.service.MemoAddService;
import kr.or.kosa.service.MemoIdCheckService;
import kr.or.kosa.service.MemoListService;

@WebServlet("*.memo")  //action. = list.memo
public class FrontMemoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FrontMemoController() {
        super();
    }
    
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			//한글처리
			//데이터 받고
			//판단 (command, url) 
			//command 파라미터 사용> list.do?cmd=list or write.do?cmd=write //cmd=write으로 접근
			//url 뒤에 url 뽑아내는 거 > .../list.do > /list.do 추출 ...목록보기
			
			//처리
			request.setCharacterEncoding("UTF-8");
			
			String requestUri = request.getRequestURI();
			String contextPath = request.getContextPath();
			String urlCommand = requestUri.substring(contextPath.length());
			
			System.out.println("urlCommand = " + urlCommand); //list.memo, /write.memo
		
			Action action = null;
			//프론트 컨트롤러 표준화
			ActionForward forward = null;

			//판단 기준
			//화면 줄 건지
			//처리 할 건지 (DB 처리 + 이동(redirect)
			
			if(urlCommand.equals("/MemoAdd.memo")) {//equals 안에 들어갈 거는 규칙 개발시작시에 정해야 함  >>글쓰기처리 }
				//UI + 로직
				action = new MemoAddService(); //다형성 action이 자식인 MemoListService()의 주소를 받아옴
				forward = action.excute(request, response); //excute 실행
				
				
			}else if(urlCommand.equals("/MemoList.memo")) {//목록보기
				//UI + 로직
				action = new MemoListService(); //다형성 
				forward = action.excute(request, response); // excute 
			
			}else if(urlCommand.equals("/MemoId.memo")) {//목록보기
				//UI + 로직
				//비동기는 view만들어서 페이지 필요없는경우 많음. 
				//controller단은 페이지를 만들기 때문에
				//고민(페이지 만들어서 vs 데이터 처리 만들어서 별도의 서비스로 할지)
				//데이터 처리(ajax > 별도의 servlet 만들어서 편하게 처리)
				action = new MemoIdCheckService(); //다형성
				forward = action.excute(request, response); //excute 
			
			}else if(urlCommand.equals("/MemoView.memo")) {
				//만약 로직 처리가 필요없다
				//UI
				forward = new ActionForward();
				forward.setRedirect(false);
				forward.setPath("/WEB-INF/views/memovies.jsp");
				}
			
			
			if(forward != null) {
				if(forward.isRedirect()) {
					//true location.href = "페이지"
					response.sendRedirect(forward.getPath());
				}else {
					//forward (데이터 처리)
					RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
					dis.forward(request, response);
				}
			}
			}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request,response);

	}

}
