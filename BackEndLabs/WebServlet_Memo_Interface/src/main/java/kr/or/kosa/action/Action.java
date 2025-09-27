package kr.or.kosa.action;

//톰캣 9.x javax
//톰캣 10. 자카르타

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//생성되는 모든 서비스는 Action 인터페이스를 구현하게 하겠다
public interface Action {
	//Action 인터페이스를 구현한다면
	ActionForward excute(HttpServletRequest request, HttpServletResponse response);
	
	
}
