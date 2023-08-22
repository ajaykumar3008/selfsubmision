<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*,java.util.*,javax.servlet.http.HttpSession,empDetails.Employee,empDetails.EmployeeData" %>
   
   <%
   HttpSession s=request.getSession();
   ArrayList<Employee> empList=null;
   String click=request.getParameter("click");
   int index=0;
   Employee e=null;
   if(empList==null){
			empList=new ArrayList<>();
   		try{
	   		index=0;
	   		
	   		Class.forName("org.postgresql.Driver");
	   		Connection con= DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training",
				"plf_training_admin", "pff123");
	   		
	   		Statement st=con.createStatement();
	   		
			ResultSet rs= st.executeQuery("select * from ajayEmp");
		
			while(rs.next()){
				int num=Integer.parseInt(rs.getString(1));
				String name=rs.getString(2);
				double salary=Double.parseDouble(rs.getString(3));
				String job=rs.getString(4);
				
				Employee e1=new Employee(num,name,salary,job);
				empList.add(e1);
			}
	   		con.close();
  		}catch(Exception ex){
		   ex.printStackTrace();
   		}
   		System.out.println("if"+(String) s.getAttribute("index"));
   		s.setAttribute("emp",empList);
   		s.setAttribute("index",String.valueOf(index));
   }else{
	   
	   System.out.println("else"+(String) s.getAttribute("index"));
	   index=Integer.parseInt((String) s.getAttribute("index"));
	   empList=(ArrayList<Employee>)s.getAttribute("emp");
   }
   
   
   
   if (click == null) {
		
		index=0;
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
	}

	if ("first".equals(click)) {
		index=0;
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
	} else if ("next".equals(click)) {
		if (index >=empList.size()-1) {
			index =empList.size()-1;
		} else {
			index++;
		}
		System.out.println(index);
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
	} else if ("prev".equals(click)) {
		if (index <= 0) {
			index = 0;
		} else {
			index--;
		}
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
		
	} else if ("last".equals(click)) {
		index = empList.size() - 1;
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
		
	} else if ("save".equals(click)) {

		int id = Integer.parseInt((String)request.getParameter("id"));
		String name = request.getParameter("name");
		double salary = Double.parseDouble((String)request.getParameter("salary"));
		String job = request.getParameter("job");

		try {
			System.out.println(1);
			Class.forName("org.postgresql.Driver");

			Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training",
					"plf_training_admin", "pff123");
			PreparedStatement ps = con.prepareStatement("insert into ajayEmp(id,name,salary,job) values(?,?,?,?)");

			ps.setInt(1, id);
			ps.setString(2, name);
			ps.setDouble(3, salary);
			ps.setString(4, job);

			int success = ps.executeUpdate();
			response.getWriter().write(success);
		} catch (Exception ex1) {

		}
		index = empList.size() - 1;
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
		
	} else if ("delete".equals(click)) {

		int id1 = Integer.parseInt(request.getParameter("id"));

		try {
			System.out.println(1);
			Class.forName("org.postgresql.Driver");

			Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training",
					"plf_training_admin", "pff123");
			Statement st = con.createStatement();
			String s1 = "delete from ajayEmp where id=" + id1;
			int success = st.executeUpdate(s1);
			
		} catch (Exception ex2) {
				ex2.printStackTrace();
		}
		index=0;
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
		
	}
	else if("search".equals(click)){
		
		int num=Integer.parseInt((String)request.getParameter("search"));
		int count=0;
		for(Employee e3:empList){
			if(e3.getId()==num){
				e=e3;
				index=count;
				break;
			}
			count++;
		}
		s.setAttribute("index",String.valueOf(index));
	}
	else if("update".equals(click)){
		
		int id = Integer.parseInt((String)request.getParameter("id"));
		String name = request.getParameter("name");
		double salary = Double.parseDouble((String)request.getParameter("salary"));
		String job = request.getParameter("job");
		
		try{
			
			Class.forName("org.postgresql.Driver");

			Connection con = DriverManager.getConnection("jdbc:postgresql://192.168.110.48:5432/plf_training",
					"plf_training_admin", "pff123");

			PreparedStatement ps=con.prepareStatement("update ajayemp set name=?,salary=?,job=? where id=?");
			ps.setString(1, name);
			ps.setDouble(2,salary);
			ps.setString(3,job);
			ps.setInt(4,id);
			
			int val=ps.executeUpdate();
			con.close();
			
		}catch(Exception exe){
			exe.printStackTrace();
		}
		
		EmployeeData ed=new EmployeeData(index,empList);
		e=ed.loadData();
		s.setAttribute("index",String.valueOf(index));
		
	}
	
	   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>self submission</title>
</head>
<body>
<h1 align="center">Employee Details</h1><br><br>
<form align="center" method="get" action="Submission.jsp">
    <input type="text" name="search"><input type="submit" name="click" value="search"><br><br><br><br>
    <label for="id">ID:</label>
    <input type="text" id="id" name="id" value="<%=e.getId()  %>"><br><br>
    
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%=e.getName()  %>"><br><br>
    
    <label for="salary">Salary:</label>
    <input type="text" id="salary" name="salary" value="<%=e.getSalary()  %>"><br><br>

    <label for="job">Job:</label>
    <input type="text" id="job" name="job" value="<%=e.getJob()  %>"><br><br>

    <input type="submit" name="click" value="first">
    <input type="submit" name="click" value="next">
    <input type="submit" name="click" value="prev">
    <input type="submit" name="click" value="last">
    <input type="submit" name="click" value="save">
    <input type="submit" name="click" value="delete">
    <input type="submit" name="click" value="update">
    
</form><br>
<div align="center">
	<button id="add" onclick="add()">add</button>
	<button id="edit" onclick="edit()">edit</button>
	</div>
<script>
console.log("ajay");

document.getElementById("id").readOnly=true;
document.getElementById("name").readOnly=true;
document.getElementById("salary").readOnly=true;
document.getElementById("job").readOnly=true;

	function add(){
		
		document.getElementById("id").value="";
		document.getElementById("name").value="";
		document.getElementById("salary").value="";
		document.getElementById("job").value="";
		
		document.getElementById("id").readOnly=false;
		document.getElementById("name").readOnly=false;
		document.getElementById("salary").readOnly=false;
		document.getElementById("job").readOnly=false;
		
	}
	
function edit(){
		
	document.getElementById("id").readOnly=false;
	document.getElementById("name").readOnly=false;
	document.getElementById("salary").readOnly=false;
	document.getElementById("job").readOnly=false;
		
	}
		

</script>
</body>
</html>
