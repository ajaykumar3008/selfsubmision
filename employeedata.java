package empDetails;

import java.util.ArrayList;

public class EmployeeData {

	int index;
	ArrayList<Employee> empList;

	public EmployeeData(int index, ArrayList<Employee> empList) {
		super();
		this.index = index;
		this.empList = empList;
	}

	public Employee loadData() {

		int id = empList.get(index).getId();
		String name = empList.get(index).getName();
		double sal = empList.get(index).getSalary();
		String job = empList.get(index).getJob();
		Employee e = new Employee(id, name, sal, job);
		return e;
	}
}
