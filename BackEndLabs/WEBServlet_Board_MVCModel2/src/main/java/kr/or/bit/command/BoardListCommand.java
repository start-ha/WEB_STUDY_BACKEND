package kr.or.bit.command;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.dto.Board;
import kr.or.bit.service.BoardService;
import kr.or.bit.utils.ThePager;

public class BoardListCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        BoardService service = BoardService.getInBoardService();
        
        // 게시물 총 건수
        int totalboardcount = service.totalBoardCount();
        
        // 페이징 처리
        String ps = request.getParameter("ps"); // pagesize
        String cp = request.getParameter("cp"); // current page
        
        if (ps == null || ps.trim().equals("")) {
            ps = "5"; // default 5개씩
        }
        
        if (cp == null || cp.trim().equals("")) {
            cp = "1"; // default 1페이지
        }
        
        int pagesize = Integer.parseInt(ps);
        int cpage = Integer.parseInt(cp);
        int pagecount = 0;
        
        if (totalboardcount % pagesize == 0) {
            pagecount = totalboardcount / pagesize;
        } else {
            pagecount = (totalboardcount / pagesize) + 1;
        }
        
        // 전체 목록 가져오기
        List<Board> list = service.list(cpage, pagesize);
        
        // ThePager 생성
        int pagersize = 3;
        ThePager pager = new ThePager(totalboardcount, cpage, pagesize, pagersize, "BoardList.do");
        
        // request에 데이터 저장
        request.setAttribute("boardList", list);
        request.setAttribute("pagesize", pagesize);
        request.setAttribute("cpage", cpage);
        request.setAttribute("pagecount", pagecount);
        request.setAttribute("totalboardcount", totalboardcount);
        request.setAttribute("pager", pager);
        
        return "board_list.jsp";
    }
}