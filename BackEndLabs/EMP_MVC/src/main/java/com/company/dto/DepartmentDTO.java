package com.company.dto;

public class DepartmentDTO {
    private int deptNo;
    private String deptName;
    private String location;
    
    // 기본 생성자
    public DepartmentDTO() {}
    
    // 전체 필드 생성자
    public DepartmentDTO(int deptNo, String deptName, String location) {
        this.deptNo = deptNo;
        this.deptName = deptName;
        this.location = location;
    }
    
    // Getter and Setter
    public int getDeptNo() {
        return deptNo;
    }
    
    public void setDeptNo(int deptNo) {
        this.deptNo = deptNo;
    }
    
    public String getDeptName() {
        return deptName;
    }
    
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    @Override
    public String toString() {
        return "DepartmentDTO [deptNo=" + deptNo + ", deptName=" + deptName 
                + ", location=" + location + "]";
    }
}