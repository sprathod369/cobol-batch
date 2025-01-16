using System; 
using System.Collections.Generic; 
using System.Threading.Tasks; 
namespace SalaryProcessingApp 
{ 
    class Program 
    { 
        static async Task Main(string[] args) 
        { 
            if (args.Length == 0) 
            { 
                Console.WriteLine("Please provide the path to the EmployeeData.csv file."); 
                return; 
            } 
            var filePath = args[0]; 
            var parser = new EmployeeDataParser(); 
            var employees = parser.ParseEmployeeData(filePath); 
            Console.WriteLine("Employee Data:"); 
            foreach (var employee in employees) 
            { 
                Console.WriteLine($"ID: {employee.EmployeeID}, Name: {employee.EmployeeName}, " + 
                                  $"Department: {employee.EmployeeDeptName}, Salary: {employee.EmployeeSalary}"); 
            } 
            try 
            { 
                var intermediateHandler = new IntermediateOutputHandler(); 
                var tasks = new List<Task>(); 
                foreach (var employee in employees) 
                { 
                    tasks.Add(Task.Run(() => intermediateHandler.AddOrUpdateDepartmentSalary(employee.EmployeeDeptName, employee.EmployeeSalary))); 
                } 
                await Task.WhenAll(tasks); 
                intermediateHandler.DisplayDepartmentSalaries(); 
                // Final salary reporting 
                var finalReporter = new FinalSalaryReporter(intermediateHandler.GetDepartmentSalaries()); 
                finalReporter.DisplayFinalReport(); 
            } 
            catch (Exception ex) 
            { 
                Console.WriteLine($"Error processing department salaries: {ex.Message}"); 
                Console.WriteLine($"Stack Trace: {ex.StackTrace}"); 
            } 
        } 
    } 
}