package kr.or.bit.command;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BoardWriteCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return "board_write.jsp";
    }
}