package bt01oop;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Ex04 {
	public static void main(String[] args) {
		Employee employee = new Employee(1, "Phan", "Trung", 100);
		System.out.println(employee);

		List<Employee> employees = Arrays.asList(new Employee(1, "Phan", "Trung", 100),
				new Employee(3, "Phan", "Trung", 100), new Employee(9, "Phan", "Trung", 100),
				new Employee(2, "Phan", "Trung", 100), new Employee(5, "Phan", "Trung", 100),
				new Employee(7, "Phan", "Trung", 100), new Employee(6, "Phan", "Trung", 100),
				new Employee(8, "Phan", "Trung", 100), new Employee(4, "Phan", "Trung", 100),
				new Employee(10, "Phan", "Trung", 100));
		// Arrays.stream(employees).forEach(System.out::println);
		employees = employees.stream().sorted((o1, o2) -> o1.getId() - o2.getId()).collect(Collectors.toList());
		employees.stream().forEach(System.out::println);
	}

}