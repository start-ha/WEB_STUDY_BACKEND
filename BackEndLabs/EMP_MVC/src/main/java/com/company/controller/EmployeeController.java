package com.company.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.company.dto.EmployeeDTO;
import com.company.service.EmployeeService;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/employee/*")
public class EmployeeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeService employeeService;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        employeeService = new EmployeeService();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String pathInfo = request.getPathInfo();
        
        if(pathInfo == null || pathInfo.equals("/")) {
            // 사원 목록 페이지로 이동
            request.getRequestDispatcher("/WEB-INF/views/employee/list.jsp").forward(request, response);
            return;
        }
        
        switch(pathInfo) {
            case "/list":
                // 부서별 사원 조회 페이지
                request.getRequestDispatcher("/WEB-INF/views/employee/list.jsp").forward(request, response);
                break;
                
            case "/insert":
                // 사원 입력 페이지
                request.getRequestDispatcher("/WEB-INF/views/employee/insert.jsp").forward(request, response);
                break;
                
            case "/getByDept":
                // Ajax: 부서별 사원 조회
                getEmployeesByDept(request, response);
                break;
                
            case "/checkEmpNo":
                // Ajax: 사번 중복 체크
                checkEmpNo(request, response);
                break;
                
            case "/getManagers":
                // Ajax: 관리자 목록 조회
                getManagers(request, response);
                break;
                
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String pathInfo = request.getPathInfo();
        
        if("/insert".equals(pathInfo)) {
            insertEmployee(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    // 부서별 사원 조회
    private void getEmployeesByDept(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String deptNoStr = request.getParameter("deptNo");
        PrintWriter out = response.getWriter();
        
        try {
            int deptNo = Integer.parseInt(deptNoStr);
            List<EmployeeDTO> list = employeeService.getEmployeesByDept(deptNo);
            out.print(gson.toJson(list));
        } catch(NumberFormatException e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "잘못된 부서번호입니다.");
            out.print(gson.toJson(error));
        }
    }
    
    // 사번 중복 체크
    private void checkEmpNo(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        String empNoStr = request.getParameter("empNo");
        PrintWriter out = response.getWriter();
        
        try {
            int empNo = Integer.parseInt(empNoStr);
            boolean exists = employeeService.checkEmpNo(empNo);
            
            Map<String, Boolean> result = new HashMap<>();
            result.put("exists", exists);
            out.print(gson.toJson(result));
        } catch(NumberFormatException e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "잘못된 사번입니다.");
            out.print(gson.toJson(error));
        }
    }
    
    // 관리자 목록 조회
    private void getManagers(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        PrintWriter out = response.getWriter();
        List<EmployeeDTO> list = employeeService.getManagers();
        out.print(gson.toJson(list));
    }
    
    // 사원 등록
    private void insertEmployee(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        
        PrintWriter out = response.getWriter();
        
        try {
            // 파라미터 받기
            int empNo = Integer.parseInt(request.getParameter("empNo"));
            String empName = request.getParameter("empName");
            int salary = Integer.parseInt(request.getParameter("salary"));
            String hireDateStr = request.getParameter("hireDate");
            int deptNo = Integer.parseInt(request.getParameter("deptNo"));
            String mgrNoStr = request.getParameter("mgrNo");
            
            // DTO 생성
            EmployeeDTO emp = new EmployeeDTO();
            emp.setEmpNo(empNo);
            emp.setEmpName(empName);
            emp.setSalary(salary);
            emp.setHireDate(Date.valueOf(hireDateStr));
            emp.setDeptNo(deptNo);
            
            if(mgrNoStr != null && !mgrNoStr.isEmpty()) {
                emp.setMgrNo(Integer.parseInt(mgrNoStr));
            }
            
            // 서비스 호출
            boolean result = employeeService.insertEmployee(emp);
            
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("success", result);
            resultMap.put("message", result ? "사원이 성공적으로 등록되었습니다." : "사원 등록에 실패했습니다.");
            
            out.print(gson.toJson(resultMap));
            
        } catch(Exception e) {
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "오류 발생: " + e.getMessage());
            out.print(gson.toJson(error));
        }
    }
}