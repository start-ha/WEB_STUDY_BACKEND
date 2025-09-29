package com.company.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmployeeDTO {
    private int empNo;
    private String empName;
    private String job;
    private Integer mgrNo;  // null 허용
    private Date hireDate;
    private int salary;
    private Integer commission;  // null 허용
    private int deptNo;
    
    
    // 조인용 필드
    private String deptName;
    private String mgrName;
    
   
    // 전체 필드 생성자
    public EmployeeDTO(int empNo, String empName, String job, Integer mgrNo, 
                       Date hireDate, int salary, Integer commission, int deptNo) {
        this.empNo = empNo;
        this.empName = empName;
        this.job = job;
        this.mgrNo = mgrNo;
        this.hireDate = hireDate;
        this.salary = salary;
        this.commission = commission;
        this.deptNo = deptNo;
    }
    
   
    
    
    
}