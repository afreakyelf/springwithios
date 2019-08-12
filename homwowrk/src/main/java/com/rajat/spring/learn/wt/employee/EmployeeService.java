package com.rajat.spring.learn.wt.employee;

import org.springframework.stereotype.Repository;

@Repository
public class EmployeeService {
	
	public void generateEmail(Employee emp) {
		// TODO Auto-generated method stub
		String mail = emp.getFirstName().toLowerCase()+"."+emp.getLastName().toLowerCase()+"@syamclasses.com";
		emp.setMail(mail);
		
	}

	public void generateFullName(Employee emp) {
		// TODO Auto-generated method stub
		String fullName = emp.getFirstName()+" "+emp.getLastName();
		emp.setFullName(fullName);
	}

}
