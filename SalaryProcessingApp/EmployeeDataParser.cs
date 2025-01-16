using System; 
using System.Collections.Generic; 
using System.IO; 
namespace SalaryProcessingApp 
{ 
    public class EmployeeDataParser 
    { 
        public List<Employee> ParseEmployeeData(string filePath) 
        { 
            var employees = new List<Employee>(); 
            try 
            { 
                using (var reader = new StreamReader(filePath)) 
                { 
                    string line; 
                    while ((line = reader.ReadLine()) != null) 
                    { 
                        var fields = line.Split(','); 
                        if (fields.Length == 4) 
                        { 
                            var employee = new Employee 
                            { 
                                EmployeeID = int.Parse(fields[0]), 
                                EmployeeName = fields[1].Trim(), 
                                EmployeeDeptName = fields[2].Trim(), 
                                EmployeeSalary = decimal.Parse(fields[3]) 
                            }; 
                            employees.Add(employee); 
                        } 
                    } 
                } 
            } 
            catch (Exception ex) 
            { 
                Console.WriteLine($"Error reading file: {ex.Message}"); 
                Console.WriteLine($"Stack Trace: {ex.StackTrace}"); 
            } 
            return employees; 
        } 
    } 
    public class Employee 
    { 
        public int EmployeeID { get; set; } 
        public string EmployeeName { get; set; } 
        public string EmployeeDeptName { get; set; } 
        public decimal EmployeeSalary { get; set; } 
    } 
} 