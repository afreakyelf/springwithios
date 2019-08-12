package com.rajat.spring.learn.wt.employee;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path = "/empData")
public class EmployeeController {

	@Autowired
	EmployeeRepository employeeRepository;
	
	@Autowired
	EmployeeService empService;

	@GetMapping(path = "/add")
	@ResponseBody
	public String addUser(@RequestParam String firstname, @RequestParam String lastname, @RequestParam String phone) {

		Employee employee = new Employee();
		employee.setFirstName(firstname);
		employee.setLastName(lastname);
		employee.setNumber(phone);

		empService.generateEmail(employee);
		empService.generateFullName(employee);

		employeeRepository.save(employee);

		System.out.println(employee);
		
		return "Success";
	}
	
	@GetMapping(path="/findAll",produces = "application/json")
	@ResponseBody
	public JsonOutput findAllEmployees(){
		
		List<Employee> listOfEmployees = (List<Employee>) employeeRepository.findAll();		
		JsonOutput json = new JsonOutput();
		json.setList(listOfEmployees);
		
		return json;
		
	}
	
	@GetMapping(path = "/findByName", produces = "application/json")
	@ResponseBody
	public JsonOutput findEmployeeByName(@RequestParam String firstname){
		
		List<Employee> listOfEmployees = (List<Employee>) employeeRepository.findByfirstName(firstname);		
		JsonOutput json = new JsonOutput();
		json.setList(listOfEmployees);
		
		return json;
		
	}

}
