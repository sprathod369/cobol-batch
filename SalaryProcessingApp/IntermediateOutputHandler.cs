using System; 
using System.Collections.Generic; 
namespace SalaryProcessingApp 
{ 
    public class IntermediateOutputHandler 
    { 
        private Dictionary<string, decimal> _departmentSalaries; 
        public IntermediateOutputHandler() 
        { 
            _departmentSalaries = new Dictionary<string, decimal>(); 
        } 
        public void AddOrUpdateDepartmentSalary(string departmentName, decimal salary) 
        { 
            if (_departmentSalaries.ContainsKey(departmentName)) 
            { 
                _departmentSalaries[departmentName] += salary; 
            } 
            else 
            { 
                _departmentSalaries[departmentName] = salary; 
            } 
            Console.WriteLine($"Updated salary for department {departmentName}: {_departmentSalaries[departmentName]}"); 
        } 
        public Dictionary<string, decimal> GetDepartmentSalaries() 
        { 
            return new Dictionary<string, decimal>(_departmentSalaries); 
        } 
        public void DisplayDepartmentSalaries() 
        { 
            Console.WriteLine("\nIntermediate Department Salary Accumulations:"); 
            foreach (var dept in _departmentSalaries) 
            { 
                Console.WriteLine($"Department: {dept.Key}, Total Salary: {dept.Value}"); 
            } 
        } 
    } 
}