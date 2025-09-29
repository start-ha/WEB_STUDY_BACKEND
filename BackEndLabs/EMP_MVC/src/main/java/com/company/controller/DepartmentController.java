package com.company.controller;

import java.io.IOException;
import java.util.List;

import com.company.dto.DepartmentDTO;
import com.company.dto.EmployeeDTO;
import com.company.service.DepartmentService;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/department")
public class DepartmentController extends HttpServlet {

    private DepartmentService departmentService;

    @Override
    public void init() throws ServletException {
        departmentService = new DepartmentService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("application/json; charset=UTF-8");
        Gson gson = new Gson();

        if (action == null || action.equals("list")) {
            // 1. 부서 목록 조회 (Select 태그용)
            List<DepartmentDTO> departments = departmentService.getAllDepartments();
            response.getWriter().write(gson.toJson(departments));

        } else if (action.equals("employees")) {
            // 2. 특정 부서의 사원 목록 조회
            try {
                int deptNo = Integer.parseInt(request.getParameter("deptNo"));
                List<EmployeeDTO> employees = departmentService.getEmployeesByDept(deptNo);
                response.getWriter().write(gson.toJson(employees));
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Invalid department number\"}");
            }
        }
    }

    // (필요 시 POST/DELETE 기능 추가 유지 가능)
}