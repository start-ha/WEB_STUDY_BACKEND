package kr.or.bit.command;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.service.BoardService;

public class BoardEditCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String idx = request.getParameter("idx");
        
        if (idx == null || idx.trim().equals("")) {
            request.setAttribute("board_msg", "잘못된 접근입니다.");
            request.setAttribute("board_url", "BoardList.do");
            return "redirect.jsp";
        }
        
        BoardService service = BoardService.getInBoardService();
        Board board = service.board_EditContent(idx);
        
        if (board == null) {
            request.setAttribute("board_msg", "존재하지 않는 게시글입니다.");
            request.setAttribute("board_url", "BoardList.do");
            return "redirect.jsp";
        }
        
        request.setAttribute("board", board);
        
        return "board_edit.jsp";
    }
}