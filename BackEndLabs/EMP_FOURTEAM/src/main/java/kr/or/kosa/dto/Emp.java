package kr.or.kosa.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConsstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Emp {
	
	private int empno;
	private String ename;
	private String job;
	private int mgr;
//	private Timestamp HireDate;
	private int sal;
	private int comm;
	private int deptno;

}
