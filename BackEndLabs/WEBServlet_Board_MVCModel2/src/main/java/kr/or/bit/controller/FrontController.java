package kr.or.bit.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID =1L;
	
	public FrontController() {
		super();
	}

}
