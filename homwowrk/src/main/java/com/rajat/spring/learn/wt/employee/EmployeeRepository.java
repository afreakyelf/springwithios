package com.rajat.spring.learn.wt.employee;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends CrudRepository<Employee, Long>{
    List<Employee> findByfirstName(String firstname);

}
