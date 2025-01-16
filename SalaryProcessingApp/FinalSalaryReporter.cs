using System; 
using System.Collections.Generic; 
namespace SalaryProcessingApp 
{ 
    public class FinalSalaryReporter 
    { 
        private Dictionary<string, decimal> _departmentSalaries; 
        public FinalSalaryReporter(Dictionary<string, decimal> departmentSalaries) 
        { 
            _departmentSalaries = departmentSalaries ?? throw new ArgumentNullException(nameof(departmentSalaries)); 
            Console.WriteLine("FinalSalaryReporter initialized with department salaries."); 
        } 
        public void DisplayFinalReport() 
        { 
            try 
            { 
                Console.WriteLine("\nFinal Department Salary Report:"); 
                foreach (var dept in _departmentSalaries) 
                { 
                    Console.WriteLine($"Department: {dept.Key}, Total Salary: {dept.Value}"); 
                } 
            } 
            catch (Exception ex) 
            { 
                Console.WriteLine($"Error displaying final report: {ex.Message}"); 
                Console.WriteLine($"Stack Trace: {ex.StackTrace}"); 
            } 
        } 
    } 
}