using System;
using System.Linq;
using System.Collections.Generic;

namespace BatchMigration
{
    public static class ProgramCService
    {
        public static void Run(List<DepartmentSalary> departmentSalaries)
        {
            decimal totalSalary = departmentSalaries.Sum(d => d.TotalSalary);
            Console.WriteLine("Total Salary: " + totalSalary);
        }
    }
}
