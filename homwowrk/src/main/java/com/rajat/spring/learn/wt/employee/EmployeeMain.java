package com.rajat.spring.learn.wt.employee;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan (basePackages = {"com.rajat.spring.learn.wt.employee"})
@EnableAutoConfiguration
public class EmployeeMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SpringApplication.run(EmployeeMain.class,args);
	}

}
