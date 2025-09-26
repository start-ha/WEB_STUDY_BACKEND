package kr.or.bit.command;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.dto.Reply;
import kr.or.bit.service.BoardService;

public class BoardContentCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String idx = request.getParameter("idx");
        
        if (idx == null || idx.trim().equals("")) {
            request.setAttribute("board_msg", "잘못된 접근입니다.");
            request.setAttribute("board_url", "BoardList.do");
            return "redirect.jsp";
        }
        
        String cpage = request.getParameter("cp");
        String pagesize = request.getParameter("ps");
        
        if (cpage == null || cpage.trim().equals("")) {
            cpage = "1";
        }
        
        if (pagesize == null || pagesize.trim().equals("")) {
            pagesize = "5";
        }
        
        BoardService service = BoardService.getInBoardService();
        
        // 조회수 증가
        service.addReadNum(idx);
        
        // 게시글 내용 조회
        Board board = service.content(Integer.parseInt(idx));
        
        if (board == null) {
            request.setAttribute("board_msg", "존재하지 않는 게시글입니다.");
            request.setAttribute("board_url", "BoardList.do");
            return "redirect.jsp";
        }
        
        // 댓글 목록 조회
        List<Reply> replyList = service.replyList(idx);
        
        request.setAttribute("board", board);
        request.setAttribute("replyList", replyList);
        request.setAttribute("cpage", cpage);
        request.setAttribute("pagesize", pagesize);
        
        return "board_content.jsp";
    }
}