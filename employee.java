package empDetails;

public class Employee {

	int id;
	String name;
	double salary;
	String job;

	public Employee(int id, String name, double salary, String job) {

		this.id = id;
		this.name = name;
		this.salary = salary;
		this.job = job;
	}

	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public double getSalary() {
		return salary;
	}

	public String getJob() {
		return job;
	}

}
