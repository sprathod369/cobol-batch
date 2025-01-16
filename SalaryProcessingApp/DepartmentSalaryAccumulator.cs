using System; 
using System.Collections.Generic; 
namespace SalaryProcessingApp 
{ 
    public class DepartmentSalaryAccumulator 
    { 
        public Dictionary<string, decimal> CalculateDepartmentSalaries(List<Employee> employees) 
        { 
            var departmentSalaries = new Dictionary<string, decimal>(); 
            foreach (var employee in employees) 
            { 
                try 
                { 
                    if (departmentSalaries.ContainsKey(employee.EmployeeDeptName)) 
                    { 
                        departmentSalaries[employee.EmployeeDeptName] += employee.EmployeeSalary; 
                    } 
                    else 
                    { 
                        departmentSalaries[employee.EmployeeDeptName] = employee.EmployeeSalary; 
                    } 
                } 
                catch (Exception ex) 
                { 
                    Console.WriteLine($"Error processing employee data: {ex.Message}"); 
                    Console.WriteLine($"Stack Trace: {ex.StackTrace}"); 
                } 
            } 
            return departmentSalaries; 
        } 
        public void DisplayDepartmentSalaries(Dictionary<string, decimal> departmentSalaries) 
        { 
            Console.WriteLine("\nDepartment Salary Accumulations:"); 
            foreach (var dept in departmentSalaries) 
            { 
                Console.WriteLine($"Department: {dept.Key}, Total Salary: {dept.Value}"); 
            } 
        } 
    } 
}