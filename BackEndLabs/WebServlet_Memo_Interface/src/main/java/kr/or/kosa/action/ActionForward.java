package kr.or.kosa.action;

/*
클라이언트 -> 서버 요청
1.화면 보여주세요
2.처리해주세요

 화면 주거나...로직 처리해서 결과를 응답하거나
 */
//인터페이스 : 사용자마다 같은 스타일로 코드 만들게 약속


public class ActionForward {
	private boolean isRedirect = false; //뷰의 전환여부 결정 (뷰줄건지, forward 줄건지)
	private String path = null; // 이동 경로의 주소 관리(forward 될 경로, viewpage)
	
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}

	
}
