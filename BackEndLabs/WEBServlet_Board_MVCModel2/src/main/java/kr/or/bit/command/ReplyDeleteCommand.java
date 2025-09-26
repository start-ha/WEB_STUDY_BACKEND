package kr.or.bit.command;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.bit.service.BoardService;

public class ReplyDeleteCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        
        String idx_fk = request.getParameter("idx");
        String no = request.getParameter("no");
        String pwd = request.getParameter("delPwd");
        
        if (idx_fk == null || no == null || pwd == null || 
            idx_fk.trim().isEmpty() || no.trim().isEmpty() || pwd.trim().isEmpty()) {
            
            request.setAttribute("board_msg", "필수 정보가 누락되었습니다.");
            request.setAttribute("board_url", "BoardList.do");
            return "redirect.jsp";
        }
        
        BoardService service = BoardService.getInBoardService();
        int result = service.replyDelete(no, pwd);
        
        String msg = "";
        String url = "BoardContent.do?idx=" + idx_fk;
        
        if (result > 0) {
            msg = "댓글이 삭제되었습니다.";
        } else {
            msg = "댓글 삭제에 실패했습니다. 비밀번호를 확인해주세요.";
        }
        
        request.setAttribute("board_msg", msg);
        request.setAttribute("board_url", url);
        
        return "redirect.jsp";
    }
}