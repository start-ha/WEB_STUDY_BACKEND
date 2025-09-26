package kr.or.bit.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.service.BoardService;

public class BoardWriteOkCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        // 파라미터를 Board 객체에 자동 매핑 (JSP useBean 대신 수동 처리)
        Board board = new Board();
        board.setSubject(request.getParameter("subject"));
        board.setWriter(request.getParameter("writer"));
        board.setEmail(request.getParameter("email"));
        board.setHomepage(request.getParameter("homepage"));
        board.setContent(request.getParameter("content"));
        board.setPwd(request.getParameter("pwd"));
        board.setFilename(request.getParameter("filename"));
        
        BoardService service = BoardService.getInBoardService();
        int result = service.writeOk(board);
        
        String msg = "";
        String url = "";
        if (result > 0) {
            msg = "글 등록이 완료되었습니다.";
            url = "BoardList.do";
        } else {
            msg = "글 등록에 실패했습니다.";
            url = "BoardWrite.do";
        }
        
        request.setAttribute("board_msg", msg);
        request.setAttribute("board_url", url);
        
        return "redirect.jsp";
    }
}