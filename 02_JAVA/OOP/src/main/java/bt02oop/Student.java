package bt02oop;

public class Student extends Person{
	private double Gpa;
	

	public Student() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Student(String name, int age, String address,double gpa) {
		super(name, age, address);
		this.Gpa=gpa;

	}

	public double getGpa() {
		return Gpa;
	}

	public void setGpa(double gpa) {
		Gpa = gpa;
	}

	@Override
	public String toString() {
		return super.toString()+ "Student [Gpa=" + Gpa + "]";
	}
	
		
		
	


}
